// Initialize Supabase (Ensure these are in your config.js)
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const authForm = document.getElementById('authForm');
const loginTab = document.getElementById('loginTab');
const signupTab = document.getElementById('signupTab');
const nameField = document.getElementById('nameField');
const recoveryFields = document.getElementById('recoveryFields');
const privacyGroup = document.getElementById('privacyGroup');
const authBtn = document.getElementById('authBtn');
const message = document.getElementById('message');
const formTitle = document.getElementById('formTitle');
const formSubtitle = document.getElementById('formSubtitle');
const toggleLink = document.getElementById('toggleLink');

let isLogin = false; // Initial view is Sign Up

// --- UI TOGGLE LOGIC ---
const showLogin = () => {
    isLogin = true;
    nameField.style.display = 'none';
    recoveryFields.style.display = 'none';
    privacyGroup.style.display = 'none';
    loginTab.classList.add('active');
    signupTab.classList.remove('active');
    formTitle.innerText = "Welcome Back";
    formSubtitle.innerText = "Login with your Student ID";
    authBtn.innerText = "Login";
    message.innerText = "";
};

const showSignup = () => {
    isLogin = false;
    nameField.style.display = 'flex';
    recoveryFields.style.display = 'flex';
    privacyGroup.style.display = 'flex';
    signupTab.classList.add('active');
    loginTab.classList.remove('active');
    formTitle.innerText = "Create an Account";
    formSubtitle.innerText = "Sign up to start your journey";
    authBtn.innerText = "Create Account";
    message.innerText = "";
};

loginTab.onclick = showLogin;
signupTab.onclick = showSignup;
toggleLink.onclick = () => isLogin ? showSignup() : showLogin();

// --- AUTHENTICATION LOGIC ---
authForm.onsubmit = async (e) => {
    e.preventDefault();
    message.innerText = "Processing...";
    
    const studentId = document.getElementById('studentId').value.trim();
    const password = document.getElementById('password').value;
    const maskedEmail = `${studentId}@cvsu.edu.ph`; // Background utility

    if (isLogin) {
        // Handle Login
        const { error } = await _supabase.auth.signInWithPassword({
            email: maskedEmail,
            password: password
        });

        if (error) {
            message.innerText = "Invalid Student ID or Password.";
        } else {
            window.location.href = 'index.html';
        }

    } else {
        // Handle Sign Up
        const fullName = document.getElementById('fullName').value.trim();
        const question = document.getElementById('securityQuestion').value;
        const answer = document.getElementById('securityAnswer').value.trim().toLowerCase();
        const privacyChecked = document.getElementById('privacyPolicy').checked;

        // Validations
        if (!fullName || !question || !answer) {
            return message.innerText = "Please fill in all fields.";
        }
        if (!privacyChecked) {
            return message.innerText = "You must agree to the Data Privacy Act.";
        }

        const { error } = await _supabase.auth.signUp({
            email: maskedEmail,
            password: password,
            options: {
                data: {
                    full_name: fullName,
                    student_id: studentId,
                    security_question: question,
                    security_answer: answer
                }
            }
        });

        if (error) {
            message.innerText = error.message;
        } else {
            alert("Registration successful! You can now log in.");
            showLogin();
        }
    }
};