// --- 1. SUPABASE DATABASE COUNT LOGIC ---

async function updateCategoryCount(categoryName, elementId) {
    let query = _supabase
        .from('items')
        .select('*', { count: 'exact', head: true })
        .eq('status', 'found');

    if (categoryName !== 'all') {
        query = query.eq('category', categoryName);
    }

    const { count, error } = await query;

    if (!error) {
        document.getElementById(elementId).innerText = `See ${count || 0} post${count === 1 ? '' : 's'}`;
    } else {
        console.error(`Error loading counts for ${categoryName}:`, error.message);
    }
}

async function refreshAllCounts() {
    await updateCategoryCount('all', 'count-all');
    await updateCategoryCount('Personal', 'count-personal');
    await updateCategoryCount('Electronics', 'count-electronics');
    await updateCategoryCount('Documents', 'count-documents');
}

// Real-time updates handler
const itemsSubscription = _supabase
    .channel('public:items')
    .on('postgres_changes', { 
        event: '*', 
        schema: 'public', 
        table: 'items' 
    }, (payload) => {
        refreshAllCounts();
    })
    .subscribe();


// --- 2. CATEGORY REDIRECT ROUTING LOGIC ---

function setupHomeNavigation() {
    // Listen exclusively for view button clicks to open specific gallery filters
    document.querySelectorAll('.category-card').forEach(card => {
        const viewBtn = card.querySelector('.view-btn');
        const targetCategory = card.getAttribute('data-category');

        if (viewBtn && targetCategory) {
            viewBtn.addEventListener('click', () => {
                window.location.href = `/html/Gallery.html?category=${encodeURIComponent(targetCategory)}`;
            });
        }
    });
}


// --- 3. INITIALIZATION WINDOW LOADING BLOCK ---
document.addEventListener('DOMContentLoaded', () => {
    refreshAllCounts();
    setupHomeNavigation();
});


// --- 4. CAROUSEL VISUAL COMPONENT LOGIC ---
const carouselItems = [
    document.getElementById('item1'),
    document.getElementById('item2'),
    document.getElementById('item3')
];

let positions = ['left', 'center', 'right'];
let autoPlayInterval;
const rotationSpeed = 4000;

function updateCarousel() {
    carouselItems.forEach((item, index) => {
        if (item) {
            item.classList.remove('left', 'center', 'right');
            item.classList.add(positions[index]);
        }
    });

    const centerIndex = positions.indexOf('center');
    const dots = document.querySelectorAll('.dot');
    
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === centerIndex);
    });
}

window.jumpToSlide = (targetIndex) => {
    stopAutoPlay();
    const states = [
        ['center', 'right', 'left'],
        ['left', 'center', 'right'],
        ['right', 'left', 'center']
    ];
    positions = states[targetIndex];
    updateCarousel();
    startAutoPlay();
};

const nextSlide = () => {
    positions.unshift(positions.pop());
    updateCarousel();
};

const startAutoPlay = () => {
    clearInterval(autoPlayInterval);
    autoPlayInterval = setInterval(nextSlide, rotationSpeed);
};

const stopAutoPlay = () => {
    clearInterval(autoPlayInterval);
};

const carouselVisual = document.querySelector('.carousel-visual');
if (carouselVisual) {
    carouselVisual.onmouseenter = stopAutoPlay;
    carouselVisual.onmouseleave = startAutoPlay;
}

updateCarousel();
startAutoPlay();