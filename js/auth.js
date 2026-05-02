// Initialize Supabase (Ensure these are in your config.js)
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Existing UI Elements
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

// --- NEW RECOVERY ELEMENTS ---
const forgotPasswordContainer = document.getElementById('forgotPasswordContainer');
const forgotPasswordLink = document.getElementById('forgotPasswordLink');
const recoverySection = document.getElementById('recoverySection');
const tabContainer = document.querySelector('.tab-container');
const formDivider = document.getElementById('formDivider');
const toggleHint = document.getElementById('toggleHint');
const backToLogin = document.getElementById('backToLogin');

let isLogin = false; // Initial view is Sign Up

// --- UI TOGGLE LOGIC ---
const showLogin = () => {
    isLogin = true;
    nameField.style.display = 'none';
    recoveryFields.style.display = 'none';
    privacyGroup.style.display = 'none';
    forgotPasswordContainer.style.display = 'block'; // Show "Forgot Pass" link
    loginTab.classList.add('active');
    signupTab.classList.remove('active');
    formTitle.innerText = "Welcome Back";
    formSubtitle.innerText = "Login with your Student ID";
    authBtn.innerText = "Login";
    message.innerText = "";
    
    // Reset Recovery View if coming back
    recoverySection.style.display = 'none';
    authForm.style.display = 'flex';
    tabContainer.style.display = 'flex';
    formDivider.style.display = 'block';
    toggleHint.style.display = 'block';
};

const showSignup = () => {
    isLogin = false;
    nameField.style.display = 'flex';
    recoveryFields.style.display = 'flex';
    privacyGroup.style.display = 'flex';
    forgotPasswordContainer.style.display = 'none'; // Hide "Forgot Pass" link
    signupTab.classList.add('active');
    loginTab.classList.remove('active');
    formTitle.innerText = "Create an Account";
    formSubtitle.innerText = "Sign up to start your journey";
    authBtn.innerText = "Create Account";
    message.innerText = "";
};

// Switch to Recovery View
const showRecovery = () => {
    authForm.style.display = 'none';
    tabContainer.style.display = 'none';
    formDivider.style.display = 'none';
    toggleHint.style.display = 'none';
    recoverySection.style.display = 'flex';
    message.innerText = "";
};

loginTab.onclick = showLogin;
signupTab.onclick = showSignup;
toggleLink.onclick = () => isLogin ? showSignup() : showLogin();
forgotPasswordLink.onclick = showRecovery;
backToLogin.onclick = showLogin;

// --- RECOVERY LOGIC ---
let recoveryTargetId = "";

document.getElementById('getQuestionBtn').onclick = async () => {
    const studentId = document.getElementById('recoveryStudentId').value.trim();
    if (!studentId) return message.innerText = "Please enter your Student ID.";

    message.innerText = "Verifying...";
    const { data, error } = await _supabase
        .from('profiles')
        .select('security_question')
        .eq('student_id', studentId)
        .single();

    if (error || !data) {
        message.innerText = "Student ID not found.";
    } else {
        recoveryTargetId = studentId;
        document.getElementById('displayQuestion').innerText = data.security_question;
        document.getElementById('recoveryStep1').style.display = 'none';
        document.getElementById('recoveryStep2').style.display = 'block';
        message.innerText = "";
    }
};

document.getElementById('resetPassBtn').onclick = async () => {
    const answer = document.getElementById('recoveryAnswer').value.trim().toLowerCase();
    const newPassword = document.getElementById('recoveryNewPassword').value;

    if (!answer || newPassword.length < 6) {
        return message.innerText = "Answer required and password must be 6+ chars.";
    }

    message.innerText = "Updating password...";
    
    // Call the Postgres Function (RPC) you created in Step 1
    const { data: success, error } = await _supabase.rpc('reset_password_via_security_question', {
        target_student_id: recoveryTargetId,
        provided_answer: answer,
        new_password_text: newPassword
    });

    if (error) {
        message.innerText = "Error: " + error.message;
    } else if (success) {
        alert("Password reset successful! You can now log in.");
        location.reload(); // Refresh to clean state
    } else {
        message.innerText = "Incorrect answer. Please try again.";
    }
};

// --- EXISTING AUTHENTICATION LOGIC ---
authForm.onsubmit = async (e) => {
    e.preventDefault();
    message.innerText = "Processing...";
    
    const studentId = document.getElementById('studentId').value.trim();
    const password = document.getElementById('password').value;
    const maskedEmail = `${studentId}@cvsu.edu.ph`;

    if (isLogin) {
        const { error } = await _supabase.auth.signInWithPassword({
            email: maskedEmail,
            password: password
        });

        if (error) {
            message.innerText = "Invalid Student ID or Password.";
        } else {
            window.location.href = '../html/home-gods.html';
        }

    } else {
        // Handle Sign Up
        const fullName = document.getElementById('fullName').value.trim();
        const question = document.getElementById('securityQuestion').value;
        const answer = document.getElementById('securityAnswer').value.trim().toLowerCase();
        const privacyChecked = document.getElementById('privacyPolicy').checked;

        // 1. Basic Field Validation
        if (!fullName || !question || !answer) {
            return message.innerText = "Please fill in all fields.";
        }

        // 2. Data Privacy Act Validation
        if (!privacyChecked) {
            return message.innerText = "You must agree to the Data Privacy Act.";
        }

        // 3. Call Supabase Auth[cite: 3]
        const { error } = await _supabase.auth.signUp({
            email: maskedEmail, // Uses the studentId@cvsu.edu.ph utility[cite: 3]
            password: password,
            options: {
                // This data is stored in the user's metadata[cite: 3]
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
            showLogin(); // Automatically switch the student to the Login view[cite: 3]
        }
    }// ... (Keep existing signup logic here)
};