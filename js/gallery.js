// --- Global State ---
let allItems = [];
let currentCategory = 'all';

// --- Initialization ---
document.addEventListener('DOMContentLoaded', async () => {
    await fetchGalleryItems();
    setupEventListeners();
});

// --- 1. Fetching Data (With Profile Links) ---
async function fetchGalleryItems() {
    toggleLoading(true);
    
    // Fetching items and 'joining' with profiles to get the finder's name
    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            profiles:reporter_id (full_name, contact_info)
        `)
        .order('created_at', { ascending: false });

    toggleLoading(false);

    if (error) {
        console.error("Fetch Error:", error.message);
        return;
    }

    allItems = data;
    renderGallery();
}

// --- 2. Filtering & Search UI Logic ---
function renderGallery() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const grid = document.getElementById('itemsGrid');
    const emptyState = document.getElementById('emptyState');

    const filtered = allItems.filter(item => {
        // Matches the 'Personal' vs 'Personal Items' mismatch we fixed
        const matchesCategory = currentCategory === 'all' || item.category.includes(currentCategory);
        const matchesSearch = item.title.toLowerCase().includes(searchTerm);
        return matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
        grid.innerHTML = '';
        emptyState.style.display = 'block';
        return;
    }

    emptyState.style.display = 'none';
    grid.innerHTML = filtered.map(item => createItemCard(item)).join('');
}

// --- 3. Creating the Card Component ---
function createItemCard(item) {
    const isAvailable = item.status === 'found';
    const statusText = isAvailable ? 'Available' : (item.status.charAt(0).toUpperCase() + item.status.slice(1));
    const statusClass = item.status.toLowerCase();

    return `
        <div class="item-card">
            <div class="item-image ${!item.image_url ? 'placeholder' : ''}">
                ${item.image_url ? `<img src="${item.image_url}" alt="${item.title}">` : '<span>No Image Provided</span>'}
            </div>
            <div class="item-details">
                <div class="item-header">
                    <h4 class="item-name">${item.title}</h4>
                    <span class="item-category">${item.category}</span>
                </div>
                <p class="item-location">Found: ${item.location_found}</p>
                <p class="item-finder">By: ${item.profiles?.full_name || 'Anonymous User'}</p>
                <div class="item-footer">
                    <span class="item-status ${statusClass}">${statusText}</span>
                    <button class="claim-btn" 
                            ${!isAvailable ? 'disabled' : ''} 
                            onclick="openClaimModal('${item.id}', '${item.title.replace(/'/g, "\\'")}')">
                        ${isAvailable ? 'Claim' : 'Unavailable'}
                    </button>
                </div>
            </div>
        </div>
    `;
}

// --- 4. The Pre-filled Claim Modal ---
window.openClaimModal = async (id, name) => {
    const modal = document.getElementById('claimModal');
    const contactInput = document.getElementById('claimContact');
    
    document.getElementById('claimItemId').value = id;
    document.getElementById('modalItemName').innerText = `Item: ${name}`;

    // PRE-FILLING LOGIC: Grabbing student info from their profile
    const { data: { user } } = await _supabase.auth.getUser();
    if (user) {
        const { data: profile } = await _supabase
            .from('profiles')
            .select('contact_info')
            .eq('id', user.id)
            .single();

        if (profile?.contact_info) {
            contactInput.value = profile.contact_info;
        }
    }

    modal.classList.add('active');
};

// --- 5. Submit Claim to Database ---
document.getElementById('claimForm').onsubmit = async (e) => {
    e.preventDefault();
    const { data: { user } } = await _supabase.auth.getUser();
    
    if (!user) return alert("Please log in first.");

    const claimData = {
        item_id: document.getElementById('claimItemId').value,
        claimer_id: user.id,
        proof_text: document.getElementById('claimDescription').value,
        claimant_contact: document.getElementById('claimContact').value, // Matches your new column
        claim_status: 'pending'
    };

    const { error } = await _supabase.from('claims').insert([claimData]);

    if (!error) {
        alert("Claim submitted! The finder will review your proof.");
        document.getElementById('claimModal').classList.remove('active');
        e.target.reset();
        fetchGalleryItems(); 
    } else {
        alert("Error: " + error.message);
    }
};

// --- Utilities ---
function setupEventListeners() {
    document.getElementById('searchInput').addEventListener('input', renderGallery);
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.onclick = () => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = btn.getAttribute('data-category');
            renderGallery();
        };
    });
    document.getElementById('closeModal').onclick = () => document.getElementById('claimModal').classList.remove('active');
}

function toggleLoading(isLoading) {
    document.getElementById('loadingState').style.display = isLoading ? 'block' : 'none';
}