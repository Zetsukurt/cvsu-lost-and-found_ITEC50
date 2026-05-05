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


const items = [
    document.getElementById('item1'),
    document.getElementById('item2'),
    document.getElementById('item3')
];

// Initial positions: item2 is center by default
let positions = ['left', 'center', 'right'];
let autoPlayInterval;
const rotationSpeed = 4000;

function updateCarousel() {
    items.forEach((item, index) => {
        item.classList.remove('left', 'center', 'right');
        item.classList.add(positions[index]);
    });

    // --- DOT LOGIC ---
    // Find which item index is currently 'center' and highlight that dot
    const centerIndex = positions.indexOf('center');
    const dots = document.querySelectorAll('.dot');
    
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === centerIndex);
    });
}

// Jump to a specific slide when a dot is clicked
const jumpToSlide = (targetIndex) => {
    stopAutoPlay();
    
    // Define the exact position arrays for each target
    const states = [
        ['center', 'right', 'left'], // Slide 0 is center
        ['left', 'center', 'right'], // Slide 1 is center
        ['right', 'left', 'center']  // Slide 2 is center
    ];
    
    positions = states[targetIndex];
    updateCarousel();
    startAutoPlay();
};

const nextSlide = () => {
    positions.unshift(positions.pop());
    updateCarousel();
};

// --- AUTO-PLAY CONTROLS ---
const startAutoPlay = () => {
    // Clear any existing interval first to prevent double-speeding
    clearInterval(autoPlayInterval);
    autoPlayInterval = setInterval(nextSlide, rotationSpeed);
};

const stopAutoPlay = () => {
    clearInterval(autoPlayInterval);
};

// Pause on Hover
const carouselVisual = document.querySelector('.carousel-visual');
carouselVisual.onmouseenter = stopAutoPlay;
carouselVisual.onmouseleave = startAutoPlay;

// Initialize
updateCarousel();
startAutoPlay();


