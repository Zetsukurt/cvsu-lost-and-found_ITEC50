// --- Global State ---
let myClaims = [];
let currentFilter = 'All';
let isArchiveView = false; // NEW: Tracks if we are looking at the vault
let currentUser = null;    // NEW: Stores the user so we can refresh easily

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/auth-gods.html';
        return;
    }

    currentUser = user; // Store user globally
    await fetchMySubmittedClaims(currentUser.id);
    setupClaimsListeners(); 
});

// --- 1. Fetch Submitted Claims ---
async function fetchMySubmittedClaims(userId) {
    await _supabase.rpc('enforce_claim_expiration_windows');

    const { data, error } = await _supabase
        .from('claims')
        .select(`
            *,
            items:item_id (
                title, category, location_found, pickup_location, status, created_at, claimed_at,
                profiles:reporter_id (full_name, contact_info)
            )
        `)
        .eq('claimer_id', userId)
        .eq('is_archived_by_claimer', isArchiveView) // SMART TOGGLE: Flips between false and true
        .order('created_at', { ascending: false });

    if (error) {
        console.error("Claims query fetch error:", error.message);
        return;
    }

    myClaims = data || [];
    renderClaimsCounters();
    renderClaimsGrid();
}

// --- 2. Update Metric Overview Counters ---
function renderClaimsCounters() {
    const total = myClaims.length;
    const pending = myClaims.filter(c => c.claim_status === 'pending').length;
    const approved = myClaims.filter(c => c.claim_status === 'approved').length;
    const rejected = myClaims.filter(c => c.claim_status === 'rejected').length;

    document.getElementById('stat-total').innerText = total;
    document.getElementById('stat-pending').innerText = pending;
    document.getElementById('stat-approved').innerText = approved;
    document.getElementById('stat-rejected').innerText = rejected;
}

// --- 3. Filter & Search Grid Loop ---
function renderClaimsGrid() {
    const container = document.getElementById('dynamic-claims-container');
    if (!container) return;

    const searchInput = document.getElementById('searchInput');
    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';

    const filteredClaims = myClaims.filter(claim => {
        const itemInfo = claim.items || {};
        const itemTitle = itemInfo.title || '';
        
        const matchesFilter = currentFilter === 'All' || claim.claim_status.toLowerCase() === currentFilter.toLowerCase();
        const matchesSearch = itemTitle.toLowerCase().includes(searchTerm);
        
        return matchesFilter && matchesSearch;
    });

    if (filteredClaims.length === 0) {
        container.innerHTML = `<p class="no-items" style="grid-column: 1/-1; text-align: center; color: #555; padding: 40px 0;">${isArchiveView ? 'Your archive is currently empty.' : 'No matching claim records found.'}</p>`;
        return;
    }

    container.innerHTML = filteredClaims.map(claim => {
        const itemInfo = claim.items || {};
        const finderProfile = itemInfo.profiles || {};
        const statusClass = claim.claim_status.toLowerCase();
        
        const finderName = finderProfile.full_name || "Anonymous Finder";
        const finderContact = finderProfile.contact_info || "No contact info provided";
        const pickupLocation = itemInfo.pickup_location || "Pending Center Assignment";

        const foundDate = itemInfo.created_at ? new Date(itemInfo.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : 'Unknown Date';
        const returnedDate = itemInfo.claimed_at ? new Date(itemInfo.claimed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : 'Recent Date';

        return `
            <div class="claim-card" style="${isArchiveView ? 'opacity: 0.85; filter: grayscale(20%);' : ''}">
                <div class="claim-header">
                    <h2 class="claim-title" style="font-family: 'Georgia', serif; font-size: 2.2rem; color: #3d5a3d;">${itemInfo.title || 'Unknown Item'}</h2>
                    <span class="claim-status status-${statusClass}">${claim.claim_status.toUpperCase()}</span>
                </div>
                
                <p class="claim-location" style="margin-bottom: 8px;"><i class="fa-solid fa-location-dot" style="color: #3d5a3d; margin-right: 6px;"></i> Initially found at: <strong>${itemInfo.location_found || 'N/A'} • ${foundDate}</strong></p>
                <p class="claim-finder-meta" style="font-size: 0.85rem; color: #555; margin-bottom: 18px;">
                    <i class="fa-solid fa-user" style="color: #3d5a3d; margin-right: 4px;"></i> Found By: <b>${finderName}</b> | <i class="fa-solid fa-phone" style="color: #3d5a3d; margin-right: 4px;"></i> Contact: <b>${finderContact}</b>
                </p>

                <div class="claim-proof">
                    <span class="proof-label">Your Proof Submitted:</span>
                    <p class="proof-text">"${claim.proof_text}"</p>
                </div>

                ${claim.claim_status === 'approved' ? `
                    <div class="claim-pickup" style="margin-top: 15px; padding: 20px; border-radius: 15px; 
                        background-color: ${claim.finder_confirmed && claim.claimant_confirmed ? '#e8f5e9' : '#c3e6cb'}; 
                        color: ${claim.finder_confirmed && claim.claimant_confirmed ? '#1b5e20' : '#155724'};">
                        
                        ${claim.finder_confirmed && claim.claimant_confirmed ? `
                            <span class="pickup-label" style="font-weight: bold; display: block; margin-bottom: 5px;"><i class="fa-solid fa-circle-check"></i> HAND-OFF COMPLETE!</span>
                            <p class="pickup-text">This item has been successfully returned and verified by both parties on ${returnedDate}.</p>
                            
                            ${isArchiveView ? `
                                <button style="background: transparent; border: 1px solid #1b5e20; color: #1b5e20; padding: 10px; border-radius: 8px; width: 100%; margin-top: 15px; cursor: pointer; font-weight: bold;" onclick="window.unarchiveClaim('${claim.id}')">
                                    <i class="fa-solid fa-trash-can-arrow-up"></i> Restore to Dashboard
                                </button>
                            ` : `
                                <button style="background: transparent; border: 1px solid #1b5e20; color: #1b5e20; padding: 10px; border-radius: 8px; width: 100%; margin-top: 15px; cursor: pointer; font-weight: bold;" onclick="window.archiveClaim('${claim.id}')">
                                    <i class="fa-solid fa-box-archive"></i> Remove from Dashboard
                                </button>
                            `}
                            
                        ` : `
                            <span class="pickup-label" style="font-weight: bold; display: block; margin-bottom: 5px;"><i class="fa-solid fa-box-open"></i> CLAIM APPROVED & READY FOR PICKUP!</span>
                            <p class="pickup-text">Proceed to <strong>${pickupLocation}</strong> with your university student ID card.</p>
                            
                            <div style="margin-top: 12px; border-top: 1px dashed rgba(0,0,0,0.1); padding-top: 10px;">
                                ${!claim.claimant_confirmed ? `
                                    <button class="dashboard-action-btn accept" style="background: #2b4530; color: white; border: none; padding: 10px 16px; border-radius: 8px; width: 100%; font-weight: bold; cursor: pointer;" onclick="window.handleClaimantReceipt('${claim.id}')"><i class="fa-solid fa-box-open" style="margin-right: 5px;"></i> I Have Received My Item</button>
                                ` : `
                                    <span style="font-style: italic; font-size: 0.85rem; display: block; text-align: center; color: #555;"><i class="fa-solid fa-hourglass-half"></i> Verification saved! Waiting for the finder to confirm handout...</span>
                                `}
                            </div>
                        `}
                    </div>
                ` : ''}
            </div>
        `;
    }).join('');
}

// --- 4. Event Controls & Listeners Binding ---
function setupClaimsListeners() {
    const searchInput = document.getElementById('searchInput');
    if (searchInput) searchInput.addEventListener('input', renderClaimsGrid);

    document.querySelectorAll('.filter-btn:not(#toggleArchiveBtn)').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn:not(#toggleArchiveBtn)').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentFilter = btn.getAttribute('data-filter');
            renderClaimsGrid();
        });
    });

    // NEW: Archive Toggle Button Logic
    const archiveBtn = document.getElementById('toggleArchiveBtn');
    if (archiveBtn) {
        archiveBtn.addEventListener('click', () => {
            isArchiveView = !isArchiveView; // Flip state
            
            // Update button UI
            if (isArchiveView) {
                archiveBtn.innerHTML = `<i class="fa-solid fa-arrow-left"></i> Back to Active`;
                archiveBtn.style.backgroundColor = '#1e293b';
                archiveBtn.style.color = '#ffffff';
            } else {
                archiveBtn.innerHTML = `<i class="fa-solid fa-box-archive"></i> View Archives`;
                archiveBtn.style.backgroundColor = '#f1f5f9';
                archiveBtn.style.color = '#475569';
            }
            
            // Re-fetch the data based on the new state
            fetchMySubmittedClaims(currentUser.id);
        });
    }
}

// --- Database Operations ---
window.handleClaimantReceipt = async (claimId) => {
    if (!confirm("Confirming means you have physically received your lost item. Proceed?")) return;
    const { error } = await _supabase.from('claims').update({ claimant_confirmed: true }).eq('id', claimId);
    if (error) return alert("Transaction Error: " + error.message);
    fetchMySubmittedClaims(currentUser.id);
};

window.archiveClaim = async (claimId) => {
    if (!confirm("Hide this completed record from your dashboard?")) return;
    const { error } = await _supabase.from('claims').update({ is_archived_by_claimer: true }).eq('id', claimId);
    if (error) return alert("Archive Error: " + error.message);
    fetchMySubmittedClaims(currentUser.id); 
};

// NEW: Restore function
window.unarchiveClaim = async (claimId) => {
    const { error } = await _supabase.from('claims').update({ is_archived_by_claimer: false }).eq('id', claimId);
    if (error) return alert("Restore Error: " + error.message);
    fetchMySubmittedClaims(currentUser.id); 
};