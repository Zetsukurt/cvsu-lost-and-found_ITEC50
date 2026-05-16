// --- Global State ---
let myItems = [];
let currentCategory = 'all';

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/login.html';
        return;
    }

    await fetchMyReportedItems(user.id);
    setupDashboardListeners();
});

// --- 1. Fetch Items with Detailed Claimant Profiles ---
async function fetchMyReportedItems(userId) {
    toggleLoading(true);

    // Deep sub-join query path: Grabs claims and looks up the full name of each claimer
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

// --- 3. Render Card Grid (Handles Multiple Claims) ---
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
        grid.innerHTML = `<p class="no-items" style="grid-column: 1/-1; text-align: center; color: #555; padding: 40px 0;">No claim records found in this category.</p>`;
        return;
    }

    emptyState.style.display = 'none';
    
    grid.innerHTML = filtered.map(item => {
        const statusClass = item.status.toLowerCase();
        
    const pendingClaimsOnly = item.claims 
        ? item.claims.filter(claim => claim.claim_status === 'pending') 
        : [];

    const totalClaimsCount = pendingClaimsOnly.length;

    const prioritizedClaims = pendingClaimsOnly
        .sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
        .slice(0, 3);

        // Generate the claims review window markup block
        let claimsHTML = `<div class="claims-management-zone">`;
        if (prioritizedClaims.length === 0) {
            claimsHTML += `
                <div class="proof-box">
                    <span class="proof-label">User Proof Submitted:</span>
                    <p class="proof-text">"No proof submitted by a claimant yet."</p>
                </div>`;
        } else {
            claimsHTML += `<h4 class="claims-header-title">Incoming Claims (${totalClaimsCount}) - Top 3 Prioritized:</h4>`;
            prioritizedClaims.forEach((claim, index) => {
                const claimantName = claim.profiles?.full_name || "Unknown Student";
                const isClaimPending = claim.claim_status === 'pending';

                claimsHTML += `
                    <div class="proof-box multiple-claims-card ${claim.claim_status}">
                        <div class="claimant-meta">
                            <strong>#${index + 1} Claimant: ${claimantName}</strong>
                            <span class="meta-phone">📞 Contact: ${claim.claimant_contact || 'N/A'}</span>
                        </div>
                        <p class="proof-text">"${claim.proof_text}"</p>
                        
                        ${isClaimPending && item.status === 'found' ? `
                            <div class="action-controls-row">
                                <select id="pickup-loc-${claim.id}" class="pickup-dropdown-menu">
                                    <option value="">-- Choose Pickup Hub --</option>
                                    <option value="DIT Guardhouse">DIT Guardhouse</option>
                                    <option value="CEIT Lobby">CEIT Lobby</option>
                                    <option value="CvSU Main Library">CvSU Main Library</option>
                                </select>
                                <button class="dashboard-action-btn accept" onclick="window.handleAcceptClaim('${claim.id}', '${item.id}')">Accept</button>
                                <button class="dashboard-action-btn reject" onclick="window.handleRejectClaim('${claim.id}')">Reject</button>
                            </div>
                        ` : `
                            <div class="claim-resolution-tag ${claim.claim_status}">Status: ${claim.claim_status.toUpperCase()}</div>
                        `}
                    </div>
                `;
            });
        }
        claimsHTML += `</div>`;

        return `
            <div class="item-card">
                <div class="card-header">
                    <h2>${item.title}</h2>
                    <span class="status-tag ${statusClass}">${item.status === 'found' ? 'Available' : item.status}</span>
                </div>
                
                <p class="loc-info">📍 Initially found at: <strong>${item.location_found}</strong></p>

                ${claimsHTML}

                ${item.status === 'pending' && item.pickup_location ? `
                    <div class="pickup-alert">
                        <strong>READY FOR PICKUP!</strong>
                        <p>Proceed to <b>${item.pickup_location}</b> with your university identification ID.</p>
                    </div>
                ` : ''}
            </div>
        `;
    }).join('');
}

// --- 4. Database Transaction Control Functions ---
window.handleAcceptClaim = async (claimId, itemId) => {
    const locationMenu = document.getElementById(`pickup-loc-${claimId}`);
    const selectedLocation = locationMenu ? locationMenu.value : '';

    if (!selectedLocation) {
        alert("Please specify a pickup location before accepting the claim verification process.");
        return;
    }

    if (!confirm("Are you sure you want to approve this claim? Other concurrent entries will remain under review or rejected manually.")) return;

    // A. Set claim status to approved
    const { error: claimError } = await _supabase
        .from('claims')
        .update({ claim_status: 'approved' })
        .eq('id', claimId);

    if (claimError) return alert("Transaction Error: " + claimError.message);

    // B. Set item status to pending and register the selected layout pickup hub location
    const { error: itemError } = await _supabase
        .from('items')
        .update({ 
            status: 'pending',
            pickup_location: selectedLocation
        })
        .eq('id', itemId);

    if (itemError) {
        alert("Transaction Error: " + itemError.message);
    } else {
        alert("Claim approved successfully! The item is now set to ready for pickup.");
        // Refresh page view dynamically
        const { data: { user } } = await _supabase.auth.getUser();
        await fetchMyReportedItems(user.id);
    }
};

window.handleRejectClaim = async (claimId) => {
    if (!confirm("Are you sure you want to reject this claim submission?")) return;

    const { error } = await _supabase
        .from('claims')
        .update({ claim_status: 'rejected' })
        .eq('id', claimId);

    if (error) {
        alert("Transaction Error: " + error.message);
    } else {
        alert("Claim submission successfully rejected.");
        const { data: { user } } = await _supabase.auth.getUser();
        await fetchMyReportedItems(user.id);
    }
};

function setupDashboardListeners() {
    document.getElementById('searchInput').addEventListener('input', renderMyItemsGrid);

    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = btn.getAttribute('data-category');
            renderMyItemsGrid();
        });
    });
}

function toggleLoading(isLoading) {
    const loader = document.getElementById('loadingState');
    if (loader) loader.style.display = isLoading ? 'block' : 'none';
}