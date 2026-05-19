// --- Global State ---
let myClaims = [];
let currentFilter = 'All';

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    // 1. Authenticate user session
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/auth-gods.html';
        return;
    }

    // 2. Fetch data and bind interactive toggles
    await fetchMySubmittedClaims(user.id);
    setupClaimsListeners(); // Updated function name to reflect filter + search
});

// --- 1. Fetch Submitted Claims with Parent Item & Finder Profiles ---
async function fetchMySubmittedClaims(userId) {
    // automated structural cleanup rules:
    await _supabase.rpc('enforce_claim_expiration_windows');

    // Nested relationship sub-join: maps claim -> parent item -> item's reporter profile
    const { data, error } = await _supabase
        .from('claims')
        .select(`
            *,
            items:item_id (
                title,
                category,
                location_found,
                pickup_location,
                status,
                profiles:reporter_id (
                    full_name,
                    contact_info
                )
            )
        `)
        .eq('claimer_id', userId)
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
        container.innerHTML = `<p class="no-items" style="grid-column: 1/-1; text-align: center; color: #555; padding: 40px 0;">No matching claim records found.</p>`;
        return;
    }

    container.innerHTML = filteredClaims.map(claim => {
        const itemInfo = claim.items || {};
        const finderProfile = itemInfo.profiles || {};
        const statusClass = claim.claim_status.toLowerCase();
        
        const finderName = finderProfile.full_name || "Anonymous Finder";
        const finderContact = finderProfile.contact_info || "No contact info provided";
        const pickupLocation = itemInfo.pickup_location || "Pending Center Assignment";

        // FORMAT TIMESTAMPS FROM CHILD DATA NODE
        const foundDate = itemInfo.created_at 
            ? new Date(itemInfo.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) 
            : 'Unknown Date';
            
        const returnedDate = itemInfo.claimed_at 
            ? new Date(itemInfo.claimed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) 
            : 'Recent Date';

        return `
            <div class="claim-card">
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
                            <p class="pickup-text">This item has been successfully returned and verified by both parties on ${returnedDate}. Thank you for keeping our campus honest!</p>
                        ` : `
                            <span class="pickup-label" style="font-weight: bold; display: block; margin-bottom: 5px;"><i class="fa-solid fa-box-open"></i> CLAIM APPROVED & READY FOR PICKUP!</span>
                            <p class="pickup-text">Proceed to <strong>${pickupLocation}</strong> with your university student ID card.</p>
                            
                            <div style="margin-top: 12px; border-top: 1px dashed rgba(0,0,0,0.1); padding-top: 10px;">
                                ${!claim.claimant_confirmed ? `
                                    <button class="dashboard-action-btn accept" style="background: #2b4530; color: white; border: none; padding: 10px 16px; border-radius: 8px; width: 100%; font-weight: bold; cursor: pointer;" onclick="window.handleClaimantReceipt('${claim.id}')"><i class="fa-solid fa-box-open" style="margin-right: 5px;"></i> I Have Received My Item</button>
                                    <p style="font-size: 0.75rem; color: #555; margin-top: 4px; text-align: center;"><i class="fa-solid fa-triangle-exclamation"></i> Note: Complete this step within 1 minute or the reservation expires.</p>
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
    // FIXED: Added event listener to run the grid renderer whenever user types
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', renderClaimsGrid);
    }

    // Category Filter Buttons
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            currentFilter = btn.getAttribute('data-filter');
            renderClaimsGrid();
        });
    });
}

// --- Database Operations ---
window.handleClaimantReceipt = async (claimId) => {
    if (!confirm("Confirming means you have physically received your lost item. Proceed?")) return;

    const { error } = await _supabase
        .from('claims')
        .update({ claimant_confirmed: true })
        .eq('id', claimId);

    if (error) {
        alert("Transaction Error: " + error.message);
    } else {
        alert("Reception confirmed! Thank you for using the portal.");
        location.reload();
    }
};