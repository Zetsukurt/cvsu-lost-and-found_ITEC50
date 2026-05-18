// Initialize Supabase
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// UI Elements
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

// FIXED: Added references to control your contact number wrapper container elements
const contactField = document.getElementById('contactField');
const contactNumberInput = document.getElementById('contactNumber');

// Recovery Elements
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
    
    // Field Visibility
    nameField.style.display = 'none';
    recoveryFields.style.display = 'none';
    privacyGroup.style.display = 'none';
    forgotPasswordContainer.style.display = 'block'; 
    
    // FIXED: Hides contact container and switches validation rules off for standard logins
    if (contactField) contactField.style.display = 'none';
    if (contactNumberInput) contactNumberInput.required = false;
    
    // Tab Styling
    loginTab.classList.add('active');
    signupTab.classList.remove('active');
    
    // Text Content
    formTitle.innerText = "Welcome Back";
    formSubtitle.innerText = "Login with your Student ID";
    authBtn.innerText = "Login";
    message.innerText = "";
    
    // --- DYNAMIC TOGGLE HINT (LOGIN VIEW) ---
    toggleHint.childNodes[0].textContent = "Don't have an account? ";
    toggleLink.innerText = "Sign Up";
    
    // Layout Reset
    recoverySection.style.display = 'none';
    authForm.style.display = 'flex';
    tabContainer.style.display = 'flex';
    formDivider.style.display = 'block';
    toggleHint.style.display = 'block';
};

const showSignup = () => {
    isLogin = false;
    
    // Field Visibility
    nameField.style.display = 'flex';
    recoveryFields.style.display = 'flex';
    privacyGroup.style.display = 'flex';
    forgotPasswordContainer.style.display = 'none'; 
    
    // FIXED: Shows contact container and activates registration form requirements
    if (contactField) contactField.style.display = 'flex';
    if (contactNumberInput) contactNumberInput.required = true;
    
    // Tab Styling
    signupTab.classList.add('active');
    loginTab.classList.remove('active');
    
    // Text Content
    formTitle.innerText = "Create an Account";
    formSubtitle.innerText = "Sign up to start your journey";
    authBtn.innerText = "Create Account";
    message.innerText = "";

    // --- DYNAMIC TOGGLE HINT (SIGNUP VIEW) ---
    toggleHint.childNodes[0].textContent = "Already have an account? ";
    toggleLink.innerText = "Login";
};

const showRecovery = () => {
    authForm.style.display = 'none';
    tabContainer.style.display = 'none';
    formDivider.style.display = 'none';
    toggleHint.style.display = 'none';
    recoverySection.style.display = 'flex';
    
    // FIXED: Safety validation reset while viewing recovery layout
    if (contactNumberInput) contactNumberInput.required = false;
    
    formTitle.innerText = "Recover Password";
    formSubtitle.innerText = "Enter Your Student ID to retrieve your security question";
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

    if (studentId.length !== 9) {
        return message.innerText = "Student ID must be exactly 9 digits.";
    }

    message.innerText = "Verifying...";
    const { data, error } = await _supabase
        .from('public_recovery_questions')
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
    
    const { data: success, error } = await _supabase.rpc('reset_password_via_security_question', {
        target_student_id: recoveryTargetId,
        provided_answer: answer,
        new_password_text: newPassword
    });

    if (error) {
        message.innerText = "Error: " + error.message;
    } else if (success) {
        alert("Password reset successful! You can now log in.");
        location.reload(); 
    } else {
        message.innerText = "Incorrect answer. Please try again.";
    }
};

// Toggle recovery password visibility
const recoverNewPasswordInput = document.getElementById('recoveryNewPassword');
const toggleRecoveryPassword = document.getElementById('toggleRecoveryPassword');

if (toggleRecoveryPassword && recoverNewPasswordInput) {
    toggleRecoveryPassword.addEventListener('click', function () {
        const isPassword = recoverNewPasswordInput.getAttribute('type') === 'password';
        recoverNewPasswordInput.setAttribute('type', isPassword ? 'text' : 'password');
        this.textContent = isPassword ? 'Hide' : 'Show';
    });
}

// --- AUTHENTICATION & SIGNUP LOGIC ---
authForm.onsubmit = async (e) => {
    e.preventDefault();
    message.innerText = "Processing...";
    
    const studentId = document.getElementById('studentId').value.trim();
    const password = document.getElementById('password').value;

    if (studentId.length !== 9) {
        return message.innerText = "Student ID must be exactly 9 digits.";
    }

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
        const fullName = document.getElementById('fullName').value.trim();
        const contactNumber = document.getElementById('contactNumber').value.trim();
        const question = document.getElementById('securityQuestion').value;
        const answer = document.getElementById('securityAnswer').value.trim().toLowerCase();
        const privacyChecked = document.getElementById('privacyPolicy').checked;

        if (!fullName || !contactNumber || !question || !answer) {
            return message.innerText = "Please fill in all fields.";
        }
        
        if (!privacyChecked) {
            return message.innerText = "You must agree to the Data Privacy Act.";
        }

        // Check if Student ID is already registered
        const { data: existingProfile } = await _supabase
            .from('profiles')
            .select('student_id')
            .eq('student_id', studentId)
            .single();

        if (existingProfile) {
            return message.innerText = "Error: This Student ID is already registered.";
        }

        const { error } = await _supabase.auth.signUp({
            email: maskedEmail,
            password: password,
            options: {
                data: {
                    full_name: fullName,
                    student_id: studentId,
                    contact_info: contactNumber,
                    security_question: question,
                    security_answer: answer
                }
            }
        });

        if (error) {
            if (error.message.includes("User already registered")) {
                message.innerText = "An account with this Student ID already exists.";
            } else {
                message.innerText = error.message;
            }
        } else {
            alert("Registration successful! You can now log in.");
            showLogin();
        }
    }
};

const passwordInput = document.getElementById('password');
const togglePassword = document.getElementById('togglePassword');

togglePassword.addEventListener('click', function () {
    const isPassword = passwordInput.getAttribute('type') === 'password';
    passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
    this.textContent = isPassword ? 'Hide' : 'Show';
});

// --- RECENT ITEMS CAROUSEL ---
const carouselItems = [
    document.getElementById('item1'),
    document.getElementById('item2'),
    document.getElementById('item3')
];

let positions = ['left', 'center', 'right'];
let autoPlayInterval;
const rotationSpeed = 4000; // 4 seconds per rotation

function updateCarousel() {
    carouselItems.forEach((item, index) => {
        if (item) {
            item.classList.remove('left', 'center', 'right');
            item.classList.add(positions[index]);
        }
    });
}

const nextSlide = () => {
    positions.unshift(positions.pop());
    updateCarousel();
};

const prevSlide = () => {
    positions.push(positions.shift());
    updateCarousel();
};

const startAutoPlay = () => {
    autoPlayInterval = setInterval(nextSlide, rotationSpeed);
};

const stopAutoPlay = () => {
    clearInterval(autoPlayInterval);
};

// Manual Navigation
const nextBtn = document.getElementById('nextBtn');
if (nextBtn) {
    nextBtn.onclick = () => {
        stopAutoPlay();
        nextSlide();
        startAutoPlay();
    };
}

const prevBtn = document.getElementById('prevBtn');
if (prevBtn) {
    prevBtn.onclick = () => {
        stopAutoPlay();
        prevSlide();
        startAutoPlay();
    };
}

// Pause on Hover
const carouselContainer = document.querySelector('.carousel-container');
if (carouselContainer) {
    carouselContainer.onmouseenter = stopAutoPlay;
    carouselContainer.onmouseleave = startAutoPlay;
}

// Initialize
updateCarousel();
startAutoPlay();