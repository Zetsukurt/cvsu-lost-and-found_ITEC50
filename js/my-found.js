// --- Global State ---
let myItems = [];
let currentCategory = 'all';
let isArchiveView = false; // tracks vault state
let currentUser = null;    // global user storage

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/auth-gods.html';
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
// --- 4. Modal Controls & DB Actions ---

window.openReviewModal = (itemId) => {
    // Find the item in the global array
    const item = myItems.find(i => i.id === itemId);
    if (!item) return;

    // Filter for only pending claims
    const pendingClaims = item.claims ? item.claims.filter(c => c.claim_status === 'pending') : [];

    document.getElementById('reviewModalItemTitle').innerText = `Claims for: ${item.title}`;
    document.getElementById('reviewModalItemSubtitle').innerText = `${pendingClaims.length} students are claiming this item.`;

    const claimsListHtml = pendingClaims.map(claim => `
        <div class="claim-review-card" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 10px; border-radius: 8px;">
            <p><strong>Claimant:</strong> ${claim.profiles?.full_name || 'Unknown'}</p>
            <p><strong>Contact:</strong> ${claim.claimant_contact}</p>
            <p><strong>Proof:</strong> "${claim.proof_text}"</p>
            <div style="margin-top: 10px; display: flex; gap: 10px;">
                <button style="background: #1b5e20; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer;" onclick="window.handleAcceptClaim('${claim.id}', '${itemId}')">Approve Request</button>
                <button style="background: #d32f2f; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer;" onclick="window.handleRejectClaim('${claim.id}')">Reject</button>
            </div>
        </div>
    `).join('');

    document.getElementById('reviewModalClaimsList').innerHTML = claimsListHtml;
    document.getElementById('reviewModalOverlay').style.display = 'flex';
};

window.closeReviewModal = () => {
    document.getElementById('reviewModalOverlay').style.display = 'none';
};

// Approves one claim and updates the item status to 'pending' (waiting for physical handoff)
window.handleAcceptClaim = async (claimId, itemId) => {
    if (!confirm("Approve this claim? Other pending claims will be automatically rejected.")) return;

    // 1. Update the specific claim to approved
    await _supabase.from('claims').update({ claim_status: 'approved' }).eq('id', claimId);
    
    // 2. Reject all other claims for this item
    await _supabase.from('claims').update({ claim_status: 'rejected' }).eq('item_id', itemId).eq('claim_status', 'pending');

    // 3. Update the item status to pending (waiting for handoff)
    await _supabase.from('items').update({ status: 'pending' }).eq('id', itemId);

    alert("Claim approved! Coordinate with the student for the physical hand-off.");
    window.closeReviewModal();
    fetchMyReportedItems(currentUser.id);
};

window.handleRejectClaim = async (claimId) => {
    if (!confirm("Reject this claim request?")) return;
    await _supabase.from('claims').update({ claim_status: 'rejected' }).eq('id', claimId);
    window.closeReviewModal();
    fetchMyReportedItems(currentUser.id);
};

// Logs the physical handoff from the Finder's side
window.handleFinderHandover = async (claimId) => {
    if (!confirm("Confirm that you have physically handed this item to the claimant?")) return;
    
    const { error } = await _supabase.from('claims').update({ finder_confirmed: true }).eq('id', claimId);
    
    if (error) {
        alert("Error: " + error.message);
    } else {
        alert("Hand-off confirmed! Waiting for claimant to verify on their end.");
        fetchMyReportedItems(currentUser.id);
    }
};

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

    // Archive Toggle Button Logic
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