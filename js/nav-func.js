const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function initNavbar() {
    const nameDisplay = document.getElementById('userNameDisplay');
    const menuToggle = document.getElementById('menuToggle');
    const userDropdown = document.getElementById('userDropdown');
    const logoutBtn = document.getElementById('logoutBtn');
    const adminLink = document.getElementById('adminPortalLink'); // Hook the new hidden link

    // --- STEP 1: Instant Load from Cache ---
    const cachedName = sessionStorage.getItem('user_full_name');
    const cachedRole = sessionStorage.getItem('user_role');
    
    if (cachedName) {
        nameDisplay.innerText = cachedName;
    }
    
    // Instantly show admin link if cached role is admin
    if (cachedRole === 'admin' && adminLink) {
        adminLink.style.display = 'block';
    }

    // --- STEP 2: Background Verification ---
    // We still call the server to ensure the session hasn't expired
    const { data: { user }, error } = await _supabase.auth.getUser();

    if (user) {
        const fullName = user.user_metadata.full_name || "Student";
        
        // Update the UI if the cache was empty or different
        nameDisplay.innerText = fullName;
        sessionStorage.setItem('user_full_name', fullName);

        // Fetch the user's role from the profiles table
        const { data: profile } = await _supabase
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .single();

        if (profile) {
            // Save role to cache for the next page load
            sessionStorage.setItem('user_role', profile.role);
            
            // Reveal or hide the admin link based on verified database role
            if (profile.role === 'admin' && adminLink) {
                adminLink.style.display = 'block';
            } else if (adminLink) {
                adminLink.style.display = 'none';
            }
        }
    } else {
        // Clear cache and kick to login if session is dead
        sessionStorage.removeItem('user_full_name');
        sessionStorage.removeItem('user_role');
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
            sessionStorage.removeItem('user_full_name'); 
            sessionStorage.removeItem('user_role'); // Clear role cache on logout
            window.location.href = '../html/auth-gods.html';
        }
    };

    window.onclick = () => {
        userDropdown.classList.remove('active');
    };
}

document.addEventListener('DOMContentLoaded', initNavbar);