// --- Global State ---
let myItems = [];
let currentCategory = 'all';
let isArchiveView = false; // NEW: Tracks vault state
let currentUser = null;    // NEW: Global user storage

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/login.html';
        return;
    }

    currentUser = user;
    setupReviewModalDOM();
    await fetchMyReportedItems(currentUser.id);
    setupDashboardListeners();
});

function setupReviewModalDOM() {
    if (!document.getElementById('reviewModalOverlay')) {
        const modalDiv = document.createElement('div');
        modalDiv.id = 'reviewModalOverlay';
        modalDiv.className = 'review-modal-overlay';
        modalDiv.innerHTML = `
            <div class="review-modal-content">
                <button class="review-modal-close" onclick="window.closeReviewModal()">&times;</button>
                <h2 id="reviewModalItemTitle"></h2>
                <p id="reviewModalItemSubtitle"></p>
                <div id="reviewModalClaimsList"></div>
            </div>
        `;
        document.body.appendChild(modalDiv);
    }
}

// --- 1. Fetch Items ---
async function fetchMyReportedItems(userId) {
    toggleLoading(true);

    try { await _supabase.rpc('enforce_claim_expiration_windows'); } catch (e) {}

    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            profiles:reporter_id (full_name),
            claims (
                id, proof_text, claimant_contact, claim_status, created_at, finder_confirmed, claimant_confirmed,
                profiles:claimer_id (full_name)
            )
        `)
        .eq('reporter_id', userId) 
        .eq('is_archived_by_finder', isArchiveView) // SMART TOGGLE
        .order('created_at', { ascending: false });

    toggleLoading(false);

    if (error) {
        console.error("Fetch error:", error.message);
        return;
    }

    myItems = data || [];
    updateDashboardCounters();
    renderMyItemsGrid();
}

function updateDashboardCounters() {
    const available = myItems.filter(item => item.status === 'found').length;
    const returned = myItems.filter(item => item.status === 'claimed').length;
    const pending = myItems.filter(item => item.status === 'pending').length;

    document.getElementById('availableCount').innerText = available;
    document.getElementById('returnedCount').innerText = returned;
    document.getElementById('pendingCount').innerText = pending;
}

// --- 3. Render Grid ---
function renderMyItemsGrid() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const grid = document.getElementById('itemsGrid');
    const emptyState = document.getElementById('emptyState');

    const filtered = myItems.filter(item => {
        const matchesCategory = currentCategory === 'all' || item.category.includes(currentCategory);
        const matchesSearch = item.title.toLowerCase().includes(searchTerm);
        return matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
        grid.innerHTML = `<p class="no-items" style="grid-column: 1/-1; text-align: center; color: #555; padding: 40px 0;">${isArchiveView ? 'Your archive is currently empty.' : 'No reported items found in this category.'}</p>`;
        return;
    }

    if (emptyState) emptyState.style.display = 'none';
    
    grid.innerHTML = filtered.map(item => {
        const statusClass = item.status.toLowerCase();
        let displayStatusText = item.status.toUpperCase();
        if (item.status === 'found') displayStatusText = 'AVAILABLE';
        if (item.status === 'pending') displayStatusText = 'PENDING';
        if (item.status === 'claimed') displayStatusText = 'RETURNED';

        const pendingClaimsOnly = item.claims ? item.claims.filter(claim => claim.claim_status === 'pending') : [];
        const totalClaimsCount = pendingClaimsOnly.length;

        const approvedClaim = item.claims?.find(c => c.claim_status === 'approved' || item.status === 'claimed');
        let claimantMetaHTML = '';
        
        if (approvedClaim) {
            const claimantName = approvedClaim.profiles?.full_name || "Unknown Student";
            const claimantContact = approvedClaim.claimant_contact || "N/A";
            claimantMetaHTML = `
                <p class="claim-finder-meta" style="font-size: 0.85rem; color: #555; margin-top: -4px; margin-bottom: 14px;">
                    <i class="fa-solid fa-user" style="color: #3d5a3d; margin-right: 4px;"></i> Claimed By: <b>${claimantName}</b> | <i class="fa-solid fa-phone" style="color: #3d5a3d; margin-right: 4px;"></i> Contact: <b>${claimantContact}</b>
                </p>
            `;
        }

        const foundDate = item.created_at ? new Date(item.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : 'Unknown Date';
        const returnedDate = item.claimed_at ? new Date(item.claimed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : 'Recent Date';

        let dynamicControlZoneHTML = '';

        if (item.status === 'found') {
            if (totalClaimsCount === 0) {
                dynamicControlZoneHTML = `
                    <div class="claims-summary-box empty">
                        <span><i class="fa-solid fa-inbox" style="margin-right: 5px;"></i> No active claim requests submitted yet.</span>
                    </div>`;
            } else {
                dynamicControlZoneHTML = `
                    <div class="claims-summary-box active">
                        <span><i class="fa-solid fa-envelope-open-text" style="margin-right: 5px;"></i> <strong>${totalClaimsCount}</strong> student${totalClaimsCount === 1 ? '' : 's'} filed a claim for this item.</span>
                        <button class="review-queue-trigger-btn" onclick="window.openReviewModal('${item.id}')">Review Claims Queue</button>
                    </div>`;
            }
        } else if (item.status === 'pending' && item.pickup_location) {
            const isBothConfirmed = approvedClaim?.finder_confirmed && approvedClaim?.claimant_confirmed;

            dynamicControlZoneHTML = `
                <div class="pickup-alert-zone" style="background-color: ${isBothConfirmed ? '#e8f5e9' : '#fce29f'}; color: ${isBothConfirmed ? '#1b5e20' : '#856404'};">
                    ${isBothConfirmed ? `
                        <strong><i class="fa-solid fa-circle-check"></i> ITEM RETURNED SUCCESSFULLY</strong>
                        <p>The claimant signed off on receipt on ${returnedDate}. This item case file is closed.</p>
                    ` : !approvedClaim?.finder_confirmed ? `
                        <strong><i class="fa-solid fa-hourglass-half"></i> PENDING PHYSICAL HAND-OFF</strong>
                        <p>Assigned Pickup Hub: <b>${item.pickup_location}</b></p>
                        <button class="handover-confirmation-btn" onclick="window.handleFinderHandover('${approvedClaim.id}')">🤝 Confirm Item Handed Over</button>
                    ` : `
                        <strong><i class="fa-solid fa-signature"></i> PENDING CLAIMANT SIGNATURE</strong>
                        <p>Hand-off verified by you. Waiting for the student to confirm reception...</p>
                    `}
                </div>`;
        } else if (item.status === 'claimed') {
            dynamicControlZoneHTML = `
                <div class="pickup-alert-zone complete" style="background-color: #e8f5e9; color: #1b5e20;">
                    <strong><i class="fa-solid fa-file-circle-check"></i> CLOSED CASE: RETURNED TO OWNER</strong>
                    <p style="margin-bottom: 15px;">Successfully verified and logged on ${returnedDate}.</p>
                    
                    ${isArchiveView ? `
                        <button style="background: transparent; border: 1px solid #1b5e20; color: #1b5e20; padding: 10px; border-radius: 8px; width: 100%; cursor: pointer; font-weight: bold;" onclick="window.unarchiveItem('${item.id}')">
                            <i class="fa-solid fa-trash-can-arrow-up"></i> Restore to Dashboard
                        </button>
                    ` : `
                        <button style="background: transparent; border: 1px solid #1b5e20; color: #1b5e20; padding: 10px; border-radius: 8px; width: 100%; cursor: pointer; font-weight: bold;" onclick="window.archiveItem('${item.id}')">
                            <i class="fa-solid fa-box-archive"></i> Remove from Dashboard
                        </button>
                    `}
                </div>`;
        }

            return `
                <div class="item-card" style="${isArchiveView ? 'opacity: 0.85; filter: grayscale(20%);' : ''}">
                    <div class="card-header">
                        <h2>${item.title}</h2>
                        <span class="status-tag ${statusClass}">${displayStatusText}</span>
                    </div>
                    
                    <p class="loc-info" style="margin-bottom: 8px;"><i class="fa-solid fa-location-dot" style="color: #3d5a3d; margin-right: 5px;"></i> Initially found at: <strong>${item.location_found} • ${foundDate}</strong></p>

                    ${claimantMetaHTML}       
                    <p class="item-desc-display" style="font-size: 0.9rem; color: #4a5568; margin: 4px 0 12px 0; font-style: italic; background-color: rgba(0,0,0,0.02); padding: 8px 12px; border-radius: 8px; border-left: 3px solid #3d5a3d;">
                        "${item.description || 'No description notes provided.'}"
                    </p>
                    ${dynamicControlZoneHTML}
                </div>
            `;
    }).join('');
}

// --- 4. Modal Controls & DB Actions ---
window.openReviewModal = (itemId) => { /* ... existing modal code ... */ };
window.closeReviewModal = () => { /* ... existing modal code ... */ };
window.handleAcceptClaim = async (claimId, itemId) => { /* ... existing code ... */ };
window.handleRejectClaim = async (claimId) => { /* ... existing code ... */ };
window.handleFinderHandover = async (claimId) => { /* ... existing code ... */ };

window.archiveItem = async (itemId) => {
    if (!confirm("Hide this completed record from your dashboard?")) return;
    const { error } = await _supabase.from('items').update({ is_archived_by_finder: true }).eq('id', itemId);
    if (!error) fetchMyReportedItems(currentUser.id);
};

// NEW: Restore function
window.unarchiveItem = async (itemId) => {
    const { error } = await _supabase.from('items').update({ is_archived_by_finder: false }).eq('id', itemId);
    if (!error) fetchMyReportedItems(currentUser.id);
};

function setupDashboardListeners() {
    const searchEl = document.getElementById('searchInput');
    if (searchEl) searchEl.addEventListener('input', renderMyItemsGrid);

    document.querySelectorAll('.filter-btn:not(#toggleArchiveBtn)').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn:not(#toggleArchiveBtn)').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = btn.getAttribute('data-category') || 'all';
            renderMyItemsGrid();
        });
    });

    // NEW: Archive Toggle Button Logic
    const archiveBtn = document.getElementById('toggleArchiveBtn');
    if (archiveBtn) {
        archiveBtn.addEventListener('click', () => {
            isArchiveView = !isArchiveView;
            
            if (isArchiveView) {
                archiveBtn.innerHTML = `<i class="fa-solid fa-arrow-left"></i> Back to Active`;
                archiveBtn.style.backgroundColor = '#1e293b';
                archiveBtn.style.color = '#ffffff';
            } else {
                archiveBtn.innerHTML = `<i class="fa-solid fa-box-archive"></i> View Archives`;
                archiveBtn.style.backgroundColor = '#f1f5f9';
                archiveBtn.style.color = '#475569';
            }
            
            fetchMyReportedItems(currentUser.id);
        });
    }
}

function toggleLoading(isLoading) {
    const loader = document.getElementById('loadingState');
    if (loader) loader.style.display = isLoading ? 'block' : 'none';
}