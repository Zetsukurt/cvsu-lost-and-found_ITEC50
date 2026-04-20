const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const authForm = document.getElementById('authForm');
const loginTab = document.getElementById('loginTab');
const signupTab = document.getElementById('signupTab');
const nameField = document.getElementById('nameField');
const authBtn = document.getElementById('authBtn');
const message = document.getElementById('message');

let isLogin = true;

// Tab Switching Logic
loginTab.onclick = () => {
    isLogin = true;
    nameField.classList.add('hidden');
    loginTab.classList.add('border-green-600', 'text-green-700');
    signupTab.classList.remove('border-green-600', 'text-green-700');
    authBtn.innerText = "Login";
};

signupTab.onclick = () => {
    isLogin = false;
    nameField.classList.remove('hidden');
    signupTab.classList.add('border-green-600', 'text-green-700');
    loginTab.classList.remove('border-green-600', 'text-green-700');
    authBtn.innerText = "Create Account";
};

// Form Submission
authForm.onsubmit = async (e) => {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const fullName = document.getElementById('fullName').value;

    if (isLogin) {
        // LOGIN
        const { error } = await _supabase.auth.signInWithPassword({ email, password });
        if (error) return message.innerText = error.message;
        window.location.href = 'index.html';
    } else {
        // SIGN UP
        const { data, error } = await _supabase.auth.signUp({
            email,
            password,
            options: { data: { full_name: fullName } }
        });

        if (error) return message.innerText = error.message;

        // 1. Sign them out immediately so the session is cleared
        await _supabase.auth.signOut();

        // 2. Clear the fields and alert the user
        document.getElementById('email').value = '';
        document.getElementById('password').value = '';
        document.getElementById('fullName').value = '';
        
        alert("Account created successfully! Please log in with your new credentials.");

        // 3. Manually trigger the login tab click to switch the UI
        loginTab.click(); 
    }
};