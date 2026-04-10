// 1. INITIALIZE SUPABASE
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const reportForm = document.getElementById('reportForm');
const itemGallery = document.getElementById('itemGallery');
const userStatusDiv = document.getElementById('userStatus');

// --- GLOBAL STATE ---
let currentCategory = 'All';
let currentSearch = '';
let currentView = 'gallery'; 

// --- AUTH LOGIC ---
async function checkUser() {
    const { data: { user } } = await _supabase.auth.getUser();
    if (user) {
        userStatusDiv.innerHTML = `
            <span>Logged in as: ${user.user_metadata.full_name || user.email}</span>
            <button onclick="handleLogout()" class="ml-2 underline text-xs">Logout</button>
        `;
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
    }
}

function toggleView(view) {
    currentView = view;
    currentCategory = 'All'; 
    
    const galleryBtn = document.getElementById('viewGalleryBtn');
    const reportsBtn = document.getElementById('viewMyReportsBtn');
    const claimsBtn = document.getElementById('viewMyClaimsBtn'); 
    const searchContainer = document.querySelector('#searchInput').parentElement.parentElement;

    [galleryBtn, reportsBtn, claimsBtn].forEach(btn => {
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

// 1. PUBLIC GALLERY (With Grace Period Logic)
async function fetchItems(categoryFilter = 'All', searchTerm = '') {
    currentCategory = categoryFilter;
    updateFilterButtonStyles(categoryFilter);

    // Show items returned within the last 24 hours
    const timeLimit = new Date(Date.now() - 10 * 1000).toISOString();

    let query = _supabase.from('items')
        .select('*')
        // Filter: Status is available OR status is returned AND returned recently
        .or(`status.eq.available,and(status.eq.returned,returned_at.gt.${timeLimit})`)
        .order('created_at', { ascending: false });

    if (categoryFilter !== 'All') query = query.eq('category', categoryFilter);
    if (searchTerm.trim() !== '') query = query.or(`title.ilike.%${searchTerm}%,description.ilike.%${searchTerm}%`);

    const { data, error } = await query;
    if (error) return console.error(error);

    if (data.length === 0) {
        itemGallery.innerHTML = `<div class="col-span-full text-center py-20 text-gray-500">No active or recently claimed items.</div>`;
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
                <p class="text-xs font-semibold text-green-700 mb-2 italic">📍 ${item.location_found}</p>
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
        itemGallery.innerHTML = `<p class="col-span-full text-center py-20 text-gray-500">You haven't reported any items in this category.</p>`;
        return;
    }

    itemGallery.innerHTML = data.map(item => `
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
                                <div class="flex gap-2">
                                    <button onclick="resolveClaim('${claim.id}', '${item.id}', 'approved')" class="flex-1 py-1.5 bg-green-600 text-white text-xs font-bold rounded hover:bg-green-700 transition shadow-sm">Approve</button>
                                    <button onclick="resolveClaim('${claim.id}', '${item.id}', 'rejected')" class="flex-1 py-1.5 bg-red-500 text-white text-xs font-bold rounded hover:bg-red-600 transition shadow-sm">Reject</button>
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
    `).join('');
}

// 3. CLAIMS DASHBOARD (For Claimants)
async function fetchMyClaims() {
    updateFilterButtonStyles('All');
    const { data: { user } } = await _supabase.auth.getUser();
    
    const { data, error } = await _supabase
        .from('claims')
        .select(`*, items (title, location_found, status)`)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

    if (error) return console.error(error);

    if (data.length === 0) {
        itemGallery.innerHTML = `<p class="col-span-full text-center py-20 text-gray-500">You haven't made any claims yet.</p>`;
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
            <p class="text-xs text-gray-500 mb-3 italic">📍 Location: ${claim.items.location_found}</p>
            <div class="bg-gray-50 p-3 rounded-lg border border-gray-100">
                <p class="text-[10px] font-bold text-gray-400 uppercase mb-1">Your Proof:</p>
                <p class="text-sm text-gray-600">"${claim.proof_text}"</p>
            </div>
            ${claim.status === 'approved' ? `
                <div class="mt-4 p-3 bg-green-50 border border-green-200 rounded-lg text-xs text-green-800 font-bold animate-bounce">
                    🎉 Claim accepted! Please coordinate with the finder.
                </div>` : ''}
        </div>
    `).join('');
}

// --- CLAIM RESOLUTION ---
async function resolveClaim(claimId, itemId, decision) {
    if (!confirm(`Are you sure you want to ${decision} this claim?`)) return;

    try {
        // Update claim status
        const { error: claimErr } = await _supabase.from('claims').update({ status: decision }).eq('id', claimId);
        if (claimErr) throw claimErr;

        // If approved, update item status AND set the returned_at timestamp
        if (decision === 'approved') {
            const { error: itemErr } = await _supabase.from('items')
                .update({ 
                    status: 'returned',
                    returned_at: new Date().toISOString() 
                })
                .eq('id', itemId);
            if (itemErr) throw itemErr;
        }

        alert(`Claim ${decision} successfully!`);
        fetchMyReports(currentCategory); 
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
    if (!proof.trim()) return alert("Proof is required.");

    const { error } = await _supabase.from('claims').insert([{
        item_id: selectedItemId,
        user_id: user.id,
        proof_text: proof,
        status: 'pending'
    }]);

    if (error) return alert(error.message);
    alert("Claim submitted!");
    closeClaimModal();
    fetchItems(currentCategory, currentSearch);
});

reportForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const { data: { user } } = await _supabase.auth.getUser();
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitBtn.innerText = "Processing...";

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