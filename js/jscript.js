// 1. INITIALIZE SUPABASE
const SUPABASE_URL = 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const reportForm = document.getElementById('reportForm');
const itemGallery = document.getElementById('itemGallery');

// 2. FETCH AND DISPLAY ITEMS
async function fetchItems() {
    const { data, error } = await _supabase
        .from('items')
        .select('*')
        .order('created_at', { ascending: false });

    if (error) return console.error(error);

    itemGallery.innerHTML = data.map(item => `
        <div class="bg-white rounded-lg shadow overflow-hidden border border-gray-200">
            ${item.image_url ? `<img src="${item.image_url}" class="h-40 w-full object-cover">` : '<div class="h-40 bg-gray-200 flex items-center justify-center">No Image</div>'}
            <div class="p-4">
                <h3 class="font-bold text-lg">${item.title}</h3>
                <p class="text-sm text-gray-600">${item.location_found}</p>
                <span class="inline-block mt-2 px-2 py-1 bg-green-100 text-green-800 text-xs font-semibold rounded capitalize">${item.status}</span>
            </div>
        </div>
    `).join('');
}

// 3. HANDLE FORM SUBMISSION (With Image Upload)
reportForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitBtn.innerText = "Uploading...";

    const file = document.getElementById('itemImage').files[0];
    const title = document.getElementById('title').value;
    const description = document.getElementById('description').value;
    const location = document.getElementById('location').value;
    let imageUrl = null;

    try {
        // Upload Image if present
        if (file) {
            const fileExt = file.name.split('.').pop();
            const fileName = `${Math.random()}.${fileExt}`;
            const { error: uploadError } = await _supabase.storage
                .from('item-images')
                .upload(fileName, file);

            if (uploadError) throw uploadError;
            
            const { data } = _supabase.storage.from('item-images').getPublicUrl(fileName);
            imageUrl = data.publicUrl;
        }

        // Insert into Database
        const { error: dbError } = await _supabase.from('items').insert([{
            title,
            description,
            location_found: location,
            image_url: imageUrl,
            finder_id: 'df0fa703-6e2a-4804-af6c-4b2b34f3ef30' // Temporary for demo
        }]);

        if (dbError) throw dbError;

        alert("Item reported successfully!");
        reportForm.reset();
        fetchItems(); // Refresh the gallery
    } catch (err) {
        alert(err.message);
    } finally {
        submitBtn.disabled = false;
        submitBtn.innerText = "Submit Report";
    }
});

// Initial Load
fetchItems();