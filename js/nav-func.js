const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
async function initNavbar() {
    const nameDisplay = document.getElementById('userNameDisplay');
    const menuToggle = document.getElementById('menuToggle');
    const userDropdown = document.getElementById('userDropdown');
    const logoutBtn = document.getElementById('logoutBtn');

    // --- STEP 1: Instant Load from Cache ---
    const cachedName = sessionStorage.getItem('user_full_name');
    if (cachedName) {
        nameDisplay.innerText = cachedName;
    }

    // --- STEP 2: Background Verification ---
    // We still call the server to ensure the session hasn't expired
    const { data: { user }, error } = await _supabase.auth.getUser();

    if (user) {
        const fullName = user.user_metadata.full_name || "Student";
        
        // Update the UI if the cache was empty or different
        nameDisplay.innerText = fullName;
        
        // Save to cache for the next page load
        sessionStorage.setItem('user_full_name', fullName);
    } else {
        // Clear cache and kick to login if session is dead
        sessionStorage.removeItem('user_full_name');
        window.location.href = '/html/auth-gods.html';
    }

    // --- UI Listeners ---
    menuToggle.onclick = (e) => {
        e.stopPropagation();
        userDropdown.classList.toggle('active');
    };

    logoutBtn.onclick = async () => {
        const { error } = await _supabase.auth.signOut();
        if (!error) {
            sessionStorage.removeItem('user_full_name'); // Clear cache on logout
            window.location.href = '../html/auth-gods.html';
        }
    };

    window.onclick = () => {
        userDropdown.classList.remove('active');
    };
}

document.addEventListener('DOMContentLoaded', initNavbar);