// --- CONFIGURATION TOGGLE ---
const IS_PRODUCTION = false; // Set to true when pushing to GitHub/Vercel

const LOCAL_CONFIG = {
    URL: "http://127.0.0.1:54321",
    KEY: "sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH"
};

const PROD_CONFIG = {
    URL: "https://dejpkzyrveibkyqqvtns.supabase.co",
    KEY: "sb_publishable_Xd0exvtjAYxoWB6SV0sheg_EyFIzXyB"
};

// Auto-select based on the toggle
const SUPABASE_URL = IS_PRODUCTION ? PROD_CONFIG.URL : LOCAL_CONFIG.URL;
const SUPABASE_ANON_KEY = IS_PRODUCTION ? PROD_CONFIG.KEY : LOCAL_CONFIG.KEY;
