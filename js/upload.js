const uploadForm = document.getElementById('uploadForm');
const fileInput = document.getElementById('itemPhoto');
const fileNameDisplay = document.getElementById('fileNameDisplay');

// Update filename display when a user picks a file
fileInput.addEventListener('change', () => {
    fileNameDisplay.innerText = fileInput.files[0] ? fileInput.files[0].name : "No file chosen";
});

uploadForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitBtn.innerText = "Uploading...";

    try {
        // --- NEW: Get the logged-in user's data first ---
        const { data: { user }, error: userError } = await _supabase.auth.getUser();
        
        if (userError || !user) {
            throw new Error("You must be logged in to report an item.");
        }

        const file = fileInput.files[0];
        const itemName = document.getElementById('itemName').value;
        const category = document.getElementById('category').value;
        const description = document.getElementById('description').value;
        const location = document.getElementById('location').value;

        // 1. Upload to Supabase Storage
        const fileExt = file.name.split('.').pop();
        const fileName = `${Date.now()}.${fileExt}`;
        const { error: uploadError } = await _supabase.storage
            .from('item-images')
            .upload(fileName, file);

        if (uploadError) throw uploadError;

        // 2. Get the public URL
        const { data: urlData } = _supabase.storage
            .from('item-images')
            .getPublicUrl(fileName);

        // 3. Insert into Items Table (Now including reporter_id)
        const { error: insertError } = await _supabase
            .from('items')
            .insert([{
                title: itemName,
                category: category,
                description: description,
                location_found: location,
                image_url: urlData.publicUrl,
                status: 'found',
                reporter_id: user.id // <--- THIS FIXES THE RLS ERROR
            }]);

        if (insertError) throw insertError;

        alert("Item reported successfully!");
        uploadForm.reset();
        fileNameDisplay.innerText = "No file chosen";

        fetchUserRecentItems(); // Refresh the recent items section after a new upload

    } catch (error) {
        console.error("Detailed Error:", error);
        alert("Upload Error: " + error.message);
    } finally {
        submitBtn.disabled = false;
        submitBtn.innerText = "Submit Report";
    }
});

async function fetchUserRecentItems() {
    // 1. Get the currently logged-in user's information
    const { data: { user }, error: userError } = await _supabase.auth.getUser();

    if (userError || !user) {
        console.error("No logged-in user found.");
        return;
    }

    // 2. Query only items reported by THIS specific user
    const { data, error } = await _supabase
        .from('items')
        .select(`
            *,
            profiles (
                full_name
            )
        `)
        .eq('reporter_id', user.id) 
        // ----------------
        .order('created_at', { ascending: false })
        .limit(2);

    if (error) {
        console.error("Fetch error:", error.message);
        return;
    }

    const grid = document.getElementById('recentGrid');
    if (!grid) return;

    // 3. Render the personal items
    grid.innerHTML = data.length > 0 
        ? data.map(item => `
            <div class="item-card">
                <img src="${item.image_url}" class="card-img" alt="Found Item">
                <div class="card-info">
                    <div class="title-row">
                        <h4>${item.title}</h4>
                        <span class="cat-tag">${item.category}</span>
                    </div>
                    <span class="loc-text">📍 Found: ${item.location_found}</span>
                    <p class="reporter-name">Reported by: ${item.profiles?.full_name || 'You'}</p>
                    <div class="card-footer">
                        <span class="status-tag">${item.status === 'found' ? 'Available' : item.status}</span>
                    </div>
                </div>
            </div>
        `).join('')
        : `<p class="no-items">No recent reports found. Start helping the community!</p>`;
}

// 5. CALL ON LOAD
document.addEventListener('DOMContentLoaded', fetchUserRecentItems);