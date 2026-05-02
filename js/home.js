const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// FETCH COUNT OF ITEMS IN EACH CATEGORY
// Function to update a specific category UI
async function updateCategoryCount(categoryName, elementId) {
    const { count, error } = await _supabase
        .from('items')
        .select('*', { count: 'exact', head: true })
        .eq('category', categoryName)
        .eq('status', 'found'); // Only count items that are still "found"

    if (!error) {
        document.getElementById(elementId).innerText = `See ${count || 0} post`;
    }
}

// Function to refresh all counts
async function refreshAllCounts() {
    await updateCategoryCount('Personal', 'count-personal');
    await updateCategoryCount('Electronics', 'count-electronics');
    await updateCategoryCount('Documents', 'count-documents');
}

// --- REALTIME SUBSCRIPTION ---
const itemsSubscription = _supabase
    .channel('public:items')
    .on('postgres_changes', { 
        event: '*', 
        schema: 'public', 
        table: 'items' 
    }, (payload) => {
        console.log('Change received!', payload);
        // If a new item is added or deleted, refresh the counts
        refreshAllCounts();
    })
    .subscribe();

// Initial load
document.addEventListener('DOMContentLoaded', refreshAllCounts);