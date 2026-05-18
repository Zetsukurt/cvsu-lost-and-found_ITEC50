// --- Global State ---
let myItems = [];
let currentCategory = 'all';

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/auth-gods.html';
        return;
    }

    setupReviewModalDOM();
    await fetchMyReportedItems(user.id);
    setupDashboardListeners();
});

// --- Dynamic Modal Structural Injector ---
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

// --- 1. Fetch Items with Detailed Claimant Profiles ---
async function fetchMyReportedItems(userId) {
    toggleLoading(true);
    try {
        await _supabase.rpc('enforce_claim_expiration_windows');
    } catch (e) {
        console.warn("Cleanup engine message:", e.message);
    }

    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            profiles:reporter_id (full_name),
            claims (
                id,
                proof_text,
                claimant_contact,
                claim_status,
                created_at,
                finder_confirmed,
                claimant_confirmed,
                profiles:claimer_id (full_name)
            )
        `)
        .eq('reporter_id', userId) 
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

// --- 2. Live Stat Calculator ---
function updateDashboardCounters() {
    const available = myItems.filter(item => item.status === 'found').length;
    const returned = myItems.filter(item => item.status === 'claimed').length;
    const pending = myItems.filter(item => item.status === 'pending').length;

    document.getElementById('availableCount').innerText = available;
    document.getElementById('returnedCount').innerText = returned;
    document.getElementById('pendingCount').innerText = pending;
}

// --- 3. Render Clean Compact Card Grid ---
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
        grid.innerHTML = `<p class="no-items" style="grid-column: 1/-1; text-align: center; color: #555; padding: 40px 0;">No reported items found in this category.</p>`;
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

        // FIXED: Cleaned up dynamic string zones with local Font Awesome identifiers
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
                        <span><i class="fa-solid fa-envelope-open-text" style="margin-right: 5px;"></i> <strong>${totalClaimsCount}</strong> student${totalClaimsCount === 1 ? '' : 's'} filed a claim.</span>
                        <button class="review-queue-trigger-btn" onclick="window.openReviewModal('${item.id}')">Review Claims Queue</button>
                    </div>`;
            }
        } else if (item.status === 'pending' && item.pickup_location) {
            const activeClaim = item.claims?.find(c => c.claim_status === 'approved');
            const isBothConfirmed = activeClaim?.finder_confirmed && activeClaim?.claimant_confirmed;

            dynamicControlZoneHTML = `
                <div class="pickup-alert-zone" style="background-color: ${isBothConfirmed ? '#e8f5e9' : '#fce29f'}; color: ${isBothConfirmed ? '#1b5e20' : '#856404'};">
                    ${isBothConfirmed ? `
                        <strong><i class="fa-solid fa-circle-check"></i> ITEM RETURNED SUCCESSFULLY</strong>
                        <p>The claimant has signed off on receipt. This item case file is closed.</p>
                    ` : !activeClaim?.finder_confirmed ? `
                        <strong><i class="fa-solid fa-hourglass-half"></i> PENDING PHYSICAL HAND-OFF</strong>
                        <p>Assigned Pickup Hub: <b>${item.pickup_location}</b></p>
                        <button class="handover-confirmation-btn" onclick="window.handleFinderHandover('${activeClaim.id}')"><i class="fa-solid fa-handshake"></i> Confirm Item Handed Over</button>
                    ` : `
                        <strong><i class="fa-solid fa-signature"></i> PENDING CLAIMANT SIGNATURE</strong>
                        <p>Hand-off verified by you. Waiting for the student to confirm reception...</p>
                    `}
                </div>`;
        } else if (item.status === 'claimed') {
            dynamicControlZoneHTML = `
                <div class="pickup-alert-zone complete" style="background-color: #e8f5e9; color: #1b5e20;">
                    <strong><i class="fa-solid fa-file-circle-check"></i> CLOSED CASE: RETURNED TO OWNER</strong>
                    <p>Successfully verified and logged. Thank you for keeping our campus honest!</p>
                </div>`;
        }

        return `
            <div class="item-card">
                <div class="card-header">
                    <h2>${item.title}</h2>
                    <span class="status-tag ${statusClass}">${displayStatusText}</span>
                </div>
                <p class="loc-info"><i class="fa-solid fa-location-dot" style="color: #3d5a3d; margin-right: 5px;"></i> Initially found at: <strong>${item.location_found}</strong></p>
                
                ${dynamicControlZoneHTML}
            </div>
        `;
    }).join('');
}

// --- 4. Modal Open & Render Queue Controls ---
window.openReviewModal = (itemId) => {
    const item = myItems.find(i => i.id === itemId);
    if (!item) return;

    document.getElementById('reviewModalItemTitle').innerText = `Review Claims: ${item.title}`;
    document.getElementById('reviewModalItemSubtitle').innerHTML = `<i class="fa-solid fa-location-dot"></i> Lost Location: ${item.location_found} | Carefully evaluate user proofs below.`;

    const pendingClaims = item.claims ? item.claims.filter(c => c.claim_status === 'pending') : [];
    const container = document.getElementById('reviewModalClaimsList');

    if (pendingClaims.length === 0) {
        container.innerHTML = `<p style="text-align: center; color: #666; padding: 30px 0;">No pending claims available for review.</p>`;
    } else {
        container.innerHTML = pendingClaims.map((claim, index) => {
            const studentName = claim.profiles?.full_name || "Unknown Student";
            return `
                <div class="modal-claim-row-card">
                    <div class="modal-claim-meta-row">
                        <strong>#${index + 1} Applicant: ${studentName}</strong>
                        <span class="modal-contact-badge"><i class="fa-solid fa-phone"></i> Contact: ${claim.claimant_contact || 'N/A'}</span>
                    </div>
                    <div class="modal-proof-quote-box">
                        "${claim.proof_text}"
                    </div>
                    <div class="modal-action-controls-row">
                        <select id="modal-pickup-loc-${claim.id}" class="modal-dropdown-menu">
                            <option value="">-- Choose Pickup Center --</option>
                            <option value="DIT Guardhouse">DIT Guardhouse</option>
                            <option value="CEIT Lobby">CEIT Lobby</option>
                            <option value="CvSU Main Library">CvSU Main Library</option>
                        </select>
                        <button class="modal-btn approve" onclick="window.handleAcceptClaim('${claim.id}', '${item.id}')">Approve</button>
                        <button class="modal-btn reject" onclick="window.handleRejectClaim('${claim.id}')">Reject</button>
                    </div>
                </div>
            `;
        }).join('');
    }

    document.getElementById('reviewModalOverlay').classList.add('active');
};

window.closeReviewModal = () => {
    const overlay = document.getElementById('reviewModalOverlay');
    if (overlay) overlay.classList.remove('active');
};

// --- 5. Database Operations ---
window.handleAcceptClaim = async (claimId, itemId) => {
    const locationMenu = document.getElementById(`modal-pickup-loc-${claimId}`);
    const selectedLocation = locationMenu ? locationMenu.value : '';

    if (!selectedLocation) {
        alert("Please specify a validation pickup location center before approving.");
        return;
    }

    if (!confirm("Are you sure you want to approve this student's claim? This locks the item reservation.")) return;

    const { error: claimError } = await _supabase
        .from('claims')
        .update({ 
            claim_status: 'approved',
            approved_at: new Date().toISOString()
        })
        .eq('id', claimId);

    if (claimError) return alert("Database Error: " + claimError.message);

    const { error: itemError } = await _supabase
        .from('items')
        .update({ 
            status: 'pending',
            pickup_location: selectedLocation
        })
        .eq('id', itemId);

    if (itemError) {
        alert("Database Error: " + itemError.message);
    } else {
        alert("Claim approved successfully! Grid synchronized.");
        window.closeReviewModal();
        const { data: { user } } = await _supabase.auth.getUser();
        await fetchMyReportedItems(user.id);
    }
};

window.handleRejectClaim = async (claimId) => {
    if (!confirm("Reject this claim request submission?")) return;

    const { error } = await _supabase
        .from('claims')
        .update({ claim_status: 'rejected' })
        .eq('id', claimId);

    if (error) {
        alert("Database Error: " + error.message);
    } else {
        alert("Claim submission rejected.");
        const { data: { user } } = await _supabase.auth.getUser();
        await fetchMyReportedItems(user.id);
        
        const activeItem = myItems.find(item => item.claims?.some(c => c.id === claimId));
        if (activeItem) {
            window.openReviewModal(activeItem.id);
        } else {
            window.closeReviewModal();
        }
    }
};

window.handleFinderHandover = async (claimId) => {
    if (!confirm("Confirming indicates you have physically handed this item over. Proceed?")) return;

    const { error } = await _supabase
        .from('claims')
        .update({ finder_confirmed: true })
        .eq('id', claimId);

    if (error) {
        alert("Database Error: " + error.message);
    } else {
        alert("Hand-off confirmed successfully!");
        const { data: { user } } = await _supabase.auth.getUser();
        await fetchMyReportedItems(user.id);
    }
};

function setupDashboardListeners() {
    const searchEl = document.getElementById('searchInput');
    if (searchEl) searchEl.addEventListener('input', renderMyItemsGrid);

    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = btn.getAttribute('data-category') || 'all';
            renderMyItemsGrid();
        });
    });
}

function toggleLoading(isLoading) {
    const loader = document.getElementById('loadingState');
    if (loader) loader.style.display = isLoading ? 'block' : 'none';
}