// --- Global Admin State ---
let adminData = {
    logistics: [],
    moderation: [],
    stuckClaims: []
};

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    // 1. Authenticate user session
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        window.location.href = '/html/auth-gods.html';
        return;
    }

    const { data: profile } = await _supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();
    
    if (profile?.role !== 'admin') {
        alert("Access Denied: Administrator privileges required.");
        window.location.href = '/html/home-gods.html';
        return;
    }

    await fetchAllAdminData();
});

// --- Master Data Fetcher ---
async function fetchAllAdminData() {
    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            reporter:reporter_id (full_name),
            claims (
                id,
                proof_text,
                claim_status,
                claimant_contact,
                created_at,
                finder_confirmed,
                claimant_confirmed,
                claimer:claimer_id (full_name)
            )
        `)
        .order('created_at', { ascending: false });

    if (error) {
        console.error("Admin Fetch Error:", error.message);
        return;
    }

    adminData.logistics = data.filter(item => item.status === 'pending' && item.pickup_location);
    adminData.moderation = data.filter(item => item.status === 'found');
    adminData.stuckClaims = data.filter(item =>
        item.status === 'found' &&
        item.claims &&
        item.claims.some(c => c.claim_status === 'pending')
    );

    renderLogisticsColumn();
    renderModerationColumn();
    renderOverridesColumn();
}

// --- 1. Render Handoff Logistics ---
window.renderLogisticsColumn = function() {
    const container = document.getElementById('logistics-container');
    const searchInput = document.getElementById('searchLogistics');
    if (!container) return;

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';

    const filteredLogistics = adminData.logistics.filter(item => {
        const approvedClaim = item.claims?.find(c => c.claim_status === 'approved');
        const finderName = item.reporter?.full_name || '';
        const claimantName = approvedClaim?.claimer?.full_name || '';
        const itemName = item.title || '';
        const location = item.pickup_location || '';

        // Omni-search checks all fields
        const searchString = `${itemName} ${finderName} ${claimantName} ${location}`.toLowerCase();
        return searchString.includes(searchTerm);
    });

    if (filteredLogistics.length === 0) {
        container.innerHTML = `<p style="text-align:center; color:#718096; padding: 20px;">No pending physical handoffs.</p>`;
        return;
    }

    container.innerHTML = filteredLogistics.map(item => {
        const approvedClaim = item.claims?.find(c => c.claim_status === 'approved');
        if (!approvedClaim) return '';

        const finderName = item.reporter?.full_name || 'Unknown Finder';
        const claimantName = approvedClaim.claimer?.full_name || 'Unknown Claimant';

        if (!approvedClaim.finder_confirmed) {
            return `
                <div class="entry-card">
                    <div class="entry-header">
                        <div>
                            <div class="entry-title">${item.title}</div>
                            <div class="entry-meta">
                                <span><i class="fa-solid fa-location-dot" style="color: var(--cvsu-green);"></i> ${item.pickup_location}</span>
                                <span>Finder: <strong>${finderName}</strong></span>
                                <span>Claimant: <strong>${claimantName}</strong></span>
                            </div>
                        </div>
                        <span class="status-tag status-claimed">Awaiting Drop</span>
                    </div>
                    <button class="btn-action btn-primary" onclick="confirmIntake('${approvedClaim.id}')">
                        <i class="fa-solid fa-check-circle"></i> Confirm Intake
                    </button>
                </div>
            `;
        }

        // If it's at the desk waiting for the claimant to pick it up
        return `
            <div class="entry-card">
                <div class="entry-header">
                    <div>
                        <div class="entry-title">${item.title}</div>
                        <div class="entry-meta">
                            <span><i class="fa-solid fa-box-archive" style="color: var(--cvsu-green);"></i> In Custody</span>
                            <span>Finder: <strong>${finderName}</strong></span>
                            <span>Claimant: <strong>${claimantName}</strong></span>
                        </div>
                    </div>
                    <span class="status-tag status-pending">Release Ready</span>
                </div>
                <button class="btn-action btn-primary" style="background-color: #1565c0;" onclick="finalizeHandoff('${approvedClaim.id}', '${item.id}')">
                    <i class="fa-solid fa-handshake"></i> Finalize Handoff
                </button>
            </div>
        `;
    }).join('');
}

// --- 2. Render Content Moderation ---
window.renderModerationColumn = function() {
    const container = document.getElementById('moderation-container');
    const searchInput = document.getElementById('searchModeration');
    if (!container) return;

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';

    const filteredModeration = adminData.moderation.filter(item => {
        const reporterName = item.reporter?.full_name || 'Anonymous';
        const itemName = item.title || '';
        const desc = item.description || '';
        
        const searchString = `${itemName} ${reporterName} ${desc}`.toLowerCase();
        return searchString.includes(searchTerm);
    });

    if (filteredModeration.length === 0) {
        container.innerHTML = `<p style="text-align:center; color:#718096; padding: 20px;">Gallery is clean. No active items matching search.</p>`;
        return;
    }

    container.innerHTML = filteredModeration.map(item => {
        const postDate = new Date(item.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
        const reporterName = item.reporter?.full_name || 'Anonymous';

        // NOTE: Passed item.image_url into the deletePost function call here
        return `
            <div class="entry-card">
                <div class="entry-header">
                    <div>
                        <div class="entry-title">${item.title}</div>
                        <div class="entry-meta">
                            <span>By: ${reporterName} • ${postDate}</span>
                        </div>
                    </div>
                    <span class="status-tag status-found">Live</span>
                </div>
                <div class="admin-quote-box">
                    "${item.description || 'No description provided.'}"
                </div>
                <button class="btn-action btn-destructive" onclick="deletePost('${item.id}', '${item.image_url || ''}')">
                    <i class="fa-solid fa-trash-can"></i> Delete Post
                </button>
            </div>
        `;
    }).join('');
}

// --- 3. Render Ghost Overrides ---
window.renderOverridesColumn = function() {
    const container = document.getElementById('overrides-container');
    const searchInput = document.getElementById('searchOverrides');
    if (!container) return;

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';

    const filteredOverrides = adminData.stuckClaims.filter(item => {
        const pendingClaim = item.claims.find(c => c.claim_status === 'pending');
        if (!pendingClaim) return false;

        const claimantName = pendingClaim.claimer?.full_name || '';
        const itemName = item.title || '';
        const proof = pendingClaim.proof_text || '';

        const searchString = `${itemName} ${claimantName} ${proof}`.toLowerCase();
        return searchString.includes(searchTerm);
    });

    if (filteredOverrides.length === 0) {
        container.innerHTML = `<p style="text-align:center; color:#718096; padding: 20px;">No stuck claims matching search.</p>`;
        return;
    }

    container.innerHTML = filteredOverrides.map(item => {
        const pendingClaim = item.claims.find(c => c.claim_status === 'pending');
        if (!pendingClaim) return '';

        const claimantName = pendingClaim.claimer?.full_name || 'Unknown Student';
        const claimDate = new Date(pendingClaim.created_at).getTime();
        const now = new Date().getTime();
        const daysStuck = Math.floor((now - claimDate) / (1000 * 3600 * 24));

        return `
            <div class="entry-card">
                <div class="entry-header">
                    <div>
                        <div class="entry-title">${item.title}</div>
                        <div class="entry-meta">
                            <span style="color: #ef6c00; font-weight: 600;">
                                <i class="fa-solid fa-clock"></i> Unresolved for ${daysStuck === 0 ? 'Today' : daysStuck + ' days'}
                            </span>
                            <span>Claimed By: ${claimantName}</span>
                        </div>
                    </div>
                    <span class="status-tag status-pending">Stuck</span>
                </div>
                
                <div style="margin-top: 10px; margin-bottom: 15px;">
                    <span style="font-size: 0.75rem; font-weight: 700; color: var(--text-main); text-transform: uppercase;">Proof Submitted:</span>
                    <div class="admin-quote-box" style="margin-top: 5px;">
                        "${pendingClaim.proof_text}"
                    </div>
                </div>
                <button class="btn-action btn-primary" style="background-color: #ef6c00;" onclick="forceApproveClaim('${pendingClaim.id}', '${item.id}')">
                    <i class="fa-solid fa-bolt"></i> Force Approve Claim
                </button>
            </div>
        `;
    }).join('');
}

window.confirmIntake = async (claimId) => {
    if (!confirm("Log this item as physically received by campus security?")) return;
    const { error } = await _supabase.from('claims').update({ finder_confirmed: true }).eq('id', claimId);
    if (error) return alert("Database Error: " + error.message);
    alert("Item logged into university custody.");
    fetchAllAdminData();
};

window.finalizeHandoff = async (claimId, itemId) => {
    if (!confirm("Verify student ID and finalize handoff? This will permanently close the case.")) return;
    await _supabase.from('claims').update({ claimant_confirmed: true }).eq('id', claimId);
    const { error } = await _supabase.from('items').update({ status: 'claimed', claimed_at: new Date().toISOString() }).eq('id', itemId);
    if (error) return alert("Database Error: " + error.message);
    alert("Handoff complete! Case closed.");
    fetchAllAdminData();
};

// NOTE: Updated function accepts imageUrl and deletes from storage first
window.deletePost = async (itemId, imageUrl) => {
    if (!confirm("Permanently delete this public post? This cannot be undone.")) return;
    
    // 1. Delete image from Supabase storage if an image URL exists
    if (imageUrl) {
        try {
            const fileName = imageUrl.substring(imageUrl.lastIndexOf('/') + 1);
            await _supabase.storage.from('item-images').remove([fileName]);
        } catch (storageError) {
            console.warn("Could not delete image from storage:", storageError);
        }
    }

    // 2. Delete the row from the items table
    const { error } = await _supabase.from('items').delete().eq('id', itemId);
    if (error) return alert("Deletion failed: " + error.message);
    
    alert("Post and associated image removed from the campus feed.");
    fetchAllAdminData();
};

window.forceApproveClaim = async (claimId, itemId) => {
    if (!confirm("FORCE APPROVE: Are you sure you want to bypass the finder and award this item to the claimant?")) return;
    await _supabase.from('claims').update({
        claim_status: 'approved',
        approved_at: new Date().toISOString(),
        finder_confirmed: true,
        claimant_confirmed: true
    }).eq('id', claimId);
    
    const { error } = await _supabase.from('items').update({ status: 'claimed', claimed_at: new Date().toISOString() }).eq('id', itemId);
    if (error) return alert("Override failed: " + error.message);
    alert("Emergency override successful. Item officially transferred.");
    fetchAllAdminData();
};