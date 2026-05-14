// --- Global State ---
let allItems = [];
let currentCategory = 'all';

// Initialize Supabase
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// --- Initialization ---
document.addEventListener('DOMContentLoaded', () => {
    fetchGalleryItems();
    setupEventListeners();
});

// --- 1. Retrieve All Items ---
async function fetchGalleryItems() {
    toggleLoading(true);
    
    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            profiles (full_name)
        `)
        .order('created_at', { ascending: false });

    toggleLoading(false);

    if (error) {
        console.error("Gallery Fetch Error:", error.message);
        return;
    }

    allItems = data;
    renderGallery();
}

// --- 2. Filter & Search Logic ---
function renderGallery() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const grid = document.getElementById('itemsGrid');
    const emptyState = document.getElementById('emptyState');

    // Filter by category AND search name simultaneously
    const filtered = allItems.filter(item => {
        const matchesCategory = currentCategory === 'all' || item.category === currentCategory;
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

// --- 3. Component Creator ---
function createItemCard(item) {
    // Logic to check if item is claimable
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

// --- Event Listeners ---
function setupEventListeners() {
    // Search Input
    document.getElementById('searchInput').addEventListener('input', renderGallery);

    // Category Buttons
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            // UI Toggle
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            // Logic Toggle
            currentCategory = btn.getAttribute('data-category');
            renderGallery();
        });
    });

    // Modal Closing
    document.getElementById('closeModal').onclick = () => document.getElementById('claimModal').classList.remove('active');
}

// --- Claim Functionality ---
window.openClaimModal = (id, name) => {
    document.getElementById('claimItemId').value = id;
    document.getElementById('modalItemName').innerText = `Item: ${name}`;
    document.getElementById('claimModal').classList.add('active');
};

document.getElementById('claimForm').onsubmit = async (e) => {
    e.preventDefault();
    
    // 1. Get current user
    const { data: { user } } = await _supabase.auth.getUser();
    
    if (!user) {
        alert("You must be logged in to claim an item.");
        return;
    }

    // 2. Map data to your specific columns
    const claimData = {
        item_id: document.getElementById('claimItemId').value,
        claimer_id: user.id,                // Matches your 'claimer_id' column
        proof_text: document.getElementById('claimDescription').value, // Matches 'proof_text'
        claim_status: 'pending'            // Matches 'claim_status'
    };

    // 3. Insert into your existing 'claims' table
    const { error } = await _supabase
        .from('claims')
        .insert([claimData]);

    if (!error) {
        alert("Claim submitted successfully! The finder will review your proof.");
        document.getElementById('claimModal').classList.remove('active');
        // Optional: clear the form
        e.target.reset();
        fetchGalleryItems(); 
    } else {
        console.error("Supabase Error:", error.message);
        alert("Error: " + error.message);
    }
};

function toggleLoading(isLoading) {
    document.getElementById('loadingState').style.display = isLoading ? 'block' : 'none';
}