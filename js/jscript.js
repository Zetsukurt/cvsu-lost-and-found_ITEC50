// 1. INITIALIZE SUPABASE
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const reportForm = document.getElementById('reportForm');
const itemGallery = document.getElementById('itemGallery');
const userStatusDiv = document.getElementById('userStatus');

// --- GLOBAL STATE ---
let currentCategory = 'All';
let currentSearch = '';
let currentView = 'gallery'; 
let isAdmin = false; // Track admin status globally

// --- AUTH LOGIC ---
async function checkUser() {
    const { data: { user } } = await _supabase.auth.getUser();
    if (user) {
        // Fetch profile to check for Admin role
        const { data: profile } = await _supabase
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .single();

        isAdmin = profile?.role === 'admin';

        userStatusDiv.innerHTML = `
            <span>Logged in as: <strong>${user.user_metadata.full_name || user.email}</strong> ${isAdmin ? '<span class="ml-1 text-[10px] bg-red-600 text-white px-2 py-0.5 rounded-full shadow-sm">ADMIN</span>' : ''}</span>
            <button onclick="handleLogout()" class="ml-2 underline text-xs text-gray-400 hover:text-red-500 transition-colors">Logout</button>
        `;

        // Reveal the Admin button if they have the role
        const adminBtn = document.getElementById('viewAdminBtn');
        if (isAdmin && adminBtn) adminBtn.classList.remove('hidden');

        return user;
    } else {
        window.location.href = 'auth.html';
    }
}

async function handleLogout() {
    await _supabase.auth.signOut();
    window.location.reload();
}

// --- VIEW & FILTER LOGIC ---
function handleCategoryClick(category) {
    currentCategory = category;
    if (currentView === 'gallery') {
        fetchItems(category, currentSearch);
    } else if (currentView === 'myReports') {
        fetchMyReports(category);
    } else if (currentView === 'admin') {
        fetchAdminReports(category);
    }
}

function toggleView(view) {
    currentView = view;
    currentCategory = 'All'; 
    
    const galleryBtn = document.getElementById('viewGalleryBtn');
    const reportsBtn = document.getElementById('viewMyReportsBtn');
    const claimsBtn = document.getElementById('viewMyClaimsBtn'); 
    const adminBtn = document.getElementById('viewAdminBtn'); 
    const searchContainer = document.querySelector('#searchInput').parentElement.parentElement;

    [galleryBtn, reportsBtn, claimsBtn, adminBtn].forEach(btn => {
        if (btn) btn.className = "pb-2 border-b-2 border-transparent text-gray-400 hover:text-green-600 font-bold transition-all whitespace-nowrap";
    });

    if (view === 'gallery') {
        galleryBtn.className = "pb-2 border-b-2 border-green-600 text-green-700 font-bold transition-all whitespace-nowrap";
        searchContainer.classList.remove('hidden');
        fetchItems('All');
    } else if (view === 'myReports') {
        reportsBtn.className = "pb-2 border-b-2 border-green-600 text-green-700 font-bold transition-all whitespace-nowrap";
        searchContainer.classList.add('hidden');
        fetchMyReports('All');
    } else if (view === 'myClaims') {
        claimsBtn.className = "pb-2 border-b-2 border-green-600 text-green-700 font-bold transition-all whitespace-nowrap";
        searchContainer.classList.add('hidden');
        fetchMyClaims();
    } else if (view === 'admin') {
        adminBtn.className = "pb-2 border-b-2 border-red-600 text-red-700 font-bold transition-all whitespace-nowrap";
        searchContainer.classList.add('hidden');
        fetchAdminReports('All');
    }
}

function updateFilterButtonStyles(activeCategory) {
    const buttons = document.querySelectorAll('#filterBar button');
    buttons.forEach(btn => {
        if (btn.innerText.trim() === activeCategory) {
            btn.className = "whitespace-nowrap px-4 py-1.5 rounded-full text-sm font-medium shadow-sm transition-all bg-green-700 text-white border-transparent hover:bg-green-800";
        } else {
            btn.className = "whitespace-nowrap px-4 py-1.5 rounded-full text-sm font-medium shadow-sm transition-all border border-gray-300 bg-white text-gray-600 hover:bg-green-50 hover:text-green-700 hover:border-green-500";
        }
    });
}

function handleSearch() {
    currentSearch = document.getElementById('searchInput').value;
    fetchItems(currentCategory, currentSearch);
}

// --- DATA FETCHING ---

// 1. PUBLIC GALLERY
async function fetchItems(categoryFilter = 'All', searchTerm = '') {
    currentCategory = categoryFilter;
    updateFilterButtonStyles(categoryFilter);

    const timeLimit = new Date(Date.now() - 100 * 1000).toISOString();

    let query = _supabase.from('items')
        .select('*')
        .or(`status.eq.available,and(status.eq.returned,returned_at.gt.${timeLimit})`)
        .order('created_at', { ascending: false });

    if (categoryFilter !== 'All') query = query.eq('category', categoryFilter);
    if (searchTerm.trim() !== '') query = query.or(`title.ilike.%${searchTerm}%,description.ilike.%${searchTerm}%`);

    const { data, error } = await query;
    if (error) return console.error(error);

    if (data.length === 0) {
        itemGallery.innerHTML = `<div class="col-span-full text-center py-20 text-gray-500">No active items.</div>`;
        return;
    }

    itemGallery.innerHTML = data.map(item => `
        <div class="bg-white rounded-lg shadow-md overflow-hidden border border-gray-200 flex flex-col relative transition-all ${item.status === 'returned' ? 'opacity-60 saturate-50' : 'hover:shadow-lg'}">
            
            ${item.status === 'returned' ? `
                <div class="absolute top-2 right-2 bg-green-600 text-white text-[10px] font-bold px-2 py-1 rounded-full z-10 shadow-sm animate-pulse">
                    CLAIMED 🎉
                </div>` : ''}

            ${item.image_url ? `<img src="${item.image_url}" class="h-40 w-full object-cover">` : '<div class="h-40 bg-gray-200 flex items-center justify-center text-gray-400">No Image</div>'}
            
            <div class="p-4 flex-1 flex flex-col">
                <div class="flex justify-between items-start mb-1">
                    <h3 class="font-bold text-lg leading-tight truncate pr-2" title="${item.title}">${item.title}</h3>
                    <span class="text-[10px] bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full font-bold uppercase whitespace-nowrap">${item.category || 'Others'}</span>
                </div>
                <p class="text-xs font-semibold text-green-700 mb-2 italic">📍 Found: ${item.location_found}</p>
                <p class="text-sm text-gray-500 line-clamp-2 mb-4 flex-1">${item.description || 'No description provided.'}</p>
                <div class="flex justify-between items-center mt-auto">
                    <span class="px-2 py-1 bg-green-100 text-green-800 text-[10px] font-bold rounded capitalize">${item.status}</span>
                    ${item.status === 'available' ? 
                        `<button onclick="openClaimModal('${item.id}', '${item.title.replace(/'/g, "\\'")}')" class="bg-green-600 text-white px-3 py-1 rounded text-xs font-bold hover:bg-green-700 shadow-md">That's Mine!</button>` : 
                        `<span class="text-xs text-gray-500 font-bold italic">Handed Over</span>`}
                </div>
            </div>
        </div>
    `).join('');
}

// 2. MANAGEMENT DASHBOARD (For Finders)
async function fetchMyReports(categoryFilter = 'All') {
    currentCategory = categoryFilter;
    updateFilterButtonStyles(categoryFilter);
    const { data: { user } } = await _supabase.auth.getUser();
    
    let query = _supabase.from('items').select(`*, claims (*)`).eq('finder_id', user.id);
    if (categoryFilter !== 'All') query = query.eq('category', categoryFilter);

    const { data, error } = await query.order('created_at', { ascending: false });
    if (error) return console.error(error);

    if (data.length === 0) {
        itemGallery.innerHTML = `<p class="col-span-full text-center py-20 text-gray-500">No reports found.</p>`;
        return;
    }

    itemGallery.innerHTML = data.map(item => renderManagementCard(item)).join('');
}

// 3. ADMIN OVERSIGHT (View everything)
async function fetchAdminReports(categoryFilter = 'All') {
    currentCategory = categoryFilter;
    updateFilterButtonStyles(categoryFilter);
    
    // Admins see EVERYTHING
    let query = _supabase.from('items').select(`*, claims (*), profiles:finder_id(full_name)`);
    if (categoryFilter !== 'All') query = query.eq('category', categoryFilter);

    const { data, error } = await query.order('created_at', { ascending: false });
    if (error) return console.error(error);

    itemGallery.innerHTML = data.map(item => `
        <div class="relative">
            <button onclick="adminDeleteItem('${item.id}')" class="absolute -top-2 -right-2 bg-red-600 text-white p-1.5 rounded-full shadow-lg z-10 hover:bg-red-700 transition-colors" title="Admin Delete">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
            <p class="text-[9px] font-black text-red-600 uppercase mb-1">Found by: ${item.profiles?.full_name || 'System'}</p>
            ${renderManagementCard(item)}
        </div>
    `).join('');
}

// Helper to render the management card (shared by Finder and Admin)
function renderManagementCard(item) {
    return `
        <div class="bg-white rounded-xl shadow-md p-4 border border-gray-200 flex flex-col ${item.status === 'returned' ? 'opacity-75 grayscale-[0.3]' : ''}">
            <div class="flex justify-between mb-4">
                <div>
                    <h3 class="font-bold text-lg text-green-800 leading-tight">${item.title}</h3>
                    <p class="text-[10px] text-gray-400 uppercase font-bold tracking-widest">${item.category}</p>
                </div>
                <span class="h-fit text-[10px] px-2 py-1 rounded font-bold uppercase ${item.status === 'returned' ? 'bg-gray-200 text-gray-600' : 'bg-green-100 text-green-800'}">
                    ${item.status}
                </span>
            </div>
            <div class="space-y-3">
                <h4 class="text-[10px] font-bold uppercase text-gray-400 border-b border-gray-100 pb-1">Claims received</h4>
                ${item.claims.filter(c => c.status !== 'rejected').length === 0 ? 
                    '<p class="text-xs text-gray-400 italic py-2">No active claims.</p>' : 
                    item.claims.filter(c => c.status !== 'rejected').map(claim => `
                        <div class="bg-gray-50 p-3 rounded-lg border border-gray-100">
                            <p class="text-sm text-gray-700 mb-3 font-medium underline decoration-green-200 underline-offset-4 decoration-2">Proof: "${claim.proof_text}"</p>
                            ${item.status === 'available' && claim.status === 'pending' ? `
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-gray-400 uppercase">Select Drop-off Station:</label>
                                    <select id="location_select_${claim.id}" class="w-full text-xs border border-gray-300 rounded p-1.5 outline-none bg-white">
                                        <option value="DIT Guardhouse">DIT Guardhouse</option>
                                        <option value="OSAS Office">OSAS Office</option>
                                        <option value="Main Library Ground Floor">Main Library</option>
                                    </select>
                                    <div class="flex gap-2">
                                        <button onclick="resolveClaim('${claim.id}', '${item.id}', 'approved')" class="flex-1 py-1.5 bg-green-600 text-white text-xs font-bold rounded hover:bg-green-700 shadow-sm transition">Approve</button>
                                        <button onclick="resolveClaim('${claim.id}', '${item.id}', 'rejected')" class="flex-1 py-1.5 bg-red-500 text-white text-xs font-bold rounded hover:bg-red-600 shadow-sm transition">Reject</button>
                                    </div>
                                </div>
                            ` : `
                                <div class="flex items-center gap-2">
                                    <div class="w-1.5 h-1.5 rounded-full ${claim.status === 'approved' ? 'bg-green-500' : 'bg-blue-400'}"></div>
                                    <p class="text-[10px] font-bold uppercase ${claim.status === 'approved' ? 'text-green-600' : 'text-blue-500'}">Result: ${claim.status}</p>
                                </div>
                            `}
                        </div>
                    `).join('')
                }
            </div>
        </div>
    `;
}

// 4. CLAIMS DASHBOARD
async function fetchMyClaims() {
    updateFilterButtonStyles('All');
    const { data: { user } } = await _supabase.auth.getUser();
    
    const { data, error } = await _supabase
        .from('claims')
        .select(`*, items (title, location_found, status, pickup_location)`)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

    if (error) return console.error(error);

    if (data.length === 0) {
        itemGallery.innerHTML = `<p class="col-span-full text-center py-20 text-gray-500">No claims submitted.</p>`;
        return;
    }

    itemGallery.innerHTML = data.map(claim => `
        <div class="bg-white rounded-xl shadow-md p-4 border border-gray-200">
            <div class="flex justify-between items-start mb-2">
                <h3 class="font-bold text-lg text-green-800">${claim.items.title}</h3>
                <span class="text-[10px] px-2 py-1 rounded font-bold uppercase 
                    ${claim.status === 'approved' ? 'bg-green-100 text-green-700' : 
                      claim.status === 'rejected' ? 'bg-red-100 text-red-700' : 'bg-yellow-100 text-yellow-700'}">
                    ${claim.status}
                </span>
            </div>
            <p class="text-xs text-gray-500 mb-3 italic">📍 Initially found at: ${claim.items.location_found}</p>
            <div class="bg-gray-50 p-3 rounded-lg border border-gray-100 mb-3">
                <p class="text-[10px] font-bold text-gray-400 uppercase mb-1">Your Proof Submitted:</p>
                <p class="text-sm text-gray-600 italic">"${claim.proof_text}"</p>
            </div>
            ${claim.status === 'approved' ? `
                <div class="p-3 bg-green-50 border border-green-200 rounded-lg shadow-inner">
                    <p class="text-xs text-green-800 font-bold mb-1 uppercase tracking-tight">🎉 Ready for Pickup!</p>
                    <p class="text-[11px] text-green-700 leading-tight">Proceed to <span class="font-black underline">${claim.items.pickup_location}</span> with your ID.</p>
                </div>` : ''}
        </div>
    `).join('');
}

// --- ADMIN ACTIONS ---
async function adminDeleteItem(itemId) {
    if (!confirm("ADMIN ACTION: Permanently delete this report and all associated claims?")) return;
    
    const { error } = await _supabase.from('items').delete().eq('id', itemId);
    if (error) return alert("Delete failed: " + error.message);
    
    alert("Item removed from database.");
    fetchAdminReports(currentCategory);
}

// --- CLAIM RESOLUTION ---
async function resolveClaim(claimId, itemId, decision) {
    let pickupPoint = null;

    if (decision === 'approved') {
        const selectElement = document.getElementById(`location_select_${claimId}`);
        pickupPoint = selectElement.value;
        if (!confirm(`Confirm approval? Ensure item is at ${pickupPoint}.`)) return;
    } else {
        if (!confirm("Reject this claim?")) return;
    }

    try {
        const { error: claimErr } = await _supabase.from('claims').update({ status: decision }).eq('id', claimId);
        if (claimErr) throw claimErr;

        if (decision === 'approved') {
            const { error: itemErr } = await _supabase.from('items')
                .update({ 
                    status: 'returned',
                    pickup_location: pickupPoint,
                    returned_at: new Date().toISOString() 
                })
                .eq('id', itemId);
            if (itemErr) throw itemErr;
        }

        alert(`Claim ${decision}!`);
        currentView === 'admin' ? fetchAdminReports(currentCategory) : fetchMyReports(currentCategory); 
    } catch (err) {
        alert("Action failed: " + err.message);
    }
}

// --- MODAL & FORM LOGIC ---
let selectedItemId = null;
function openClaimModal(id, title) {
    selectedItemId = id;
    document.getElementById('modalItemTitle').innerText = `Item: ${title}`;
    document.getElementById('claimModal').classList.remove('hidden');
}
function closeClaimModal() {
    document.getElementById('claimModal').classList.add('hidden');
    document.getElementById('proofText').value = '';
}

document.getElementById('confirmClaimBtn').addEventListener('click', async () => {
    const proof = document.getElementById('proofText').value;
    const { data: { user } } = await _supabase.auth.getUser();
    if (!proof.trim()) return alert("Proof details are required.");

    const { error } = await _supabase.from('claims').insert([{
        item_id: selectedItemId,
        user_id: user.id,
        proof_text: proof,
        status: 'pending'
    }]);

    if (error) return alert(error.message);
    alert("Claim submitted successfully!");
    closeClaimModal();
    fetchItems(currentCategory, currentSearch);
});

reportForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const { data: { user } } = await _supabase.auth.getUser();
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitBtn.innerText = "Reporting...";

    const file = document.getElementById('itemImage').files[0];
    let imageUrl = null;

    try {
        if (file) {
            const fileName = `${Date.now()}_${file.name.replace(/\s/g, '_')}`;
            const { error: upErr } = await _supabase.storage.from('item-images').upload(fileName, file);
            if (upErr) throw upErr;
            imageUrl = _supabase.storage.from('item-images').getPublicUrl(fileName).data.publicUrl;
        }

        const { error: dbErr } = await _supabase.from('items').insert([{
            title: document.getElementById('title').value,
            description: document.getElementById('description').value,
            location_found: document.getElementById('location').value,
            category: document.getElementById('category').value,
            image_url: imageUrl,
            finder_id: user.id
        }]);

        if (dbErr) throw dbErr;
        alert("Item reported successfully!");
        reportForm.reset();
        toggleView('gallery');
    } catch (err) {
        alert(err.message);
    } finally {
        submitBtn.disabled = false;
        submitBtn.innerText = "Submit Report";
    }
});

// INITIAL LOAD
checkUser().then(() => fetchItems());