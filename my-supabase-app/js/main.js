// js/main.js

async function fetchProfiles() {
    const { data, error } = await supabaseClient.from('profiles').select('*');

    if (error) {
        console.error("Fetch Error:", error);
        document.getElementById('user-display').innerText = "Error: " + error.message;
        return;
    }

    if (data && data.length > 0) {
        document.getElementById('user-display').innerHTML = data.map(profile => `
            <div style="border: 1px solid #ddd; padding: 10px; margin-bottom: 10px; border-radius: 8px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <strong>Username:</strong> ${profile.username} <br>
                    <strong>Bio:</strong> ${profile.bio || 'No bio yet'}
                </div>
                <button onclick="deleteProfile('${profile.uuid}')" style="background: #ff4d4d; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">
                    Delete
                </button>
            </div>
        `).join('');
    } else {
        document.getElementById('user-display').innerText = "No users found.";
    }
}

async function addProfile() {
    const usernameInput = document.getElementById('new-username');
    const bioInput = document.getElementById('new-bio');

    if (!usernameInput.value) {
        alert("Username is required!");
        return;
    }

    const { error } = await supabaseClient
        .from('profiles')
        .insert([{ username: usernameInput.value, bio: bioInput.value }]);

    if (error) {
        alert("Error saving: " + error.message);
    } else {
        usernameInput.value = '';
        bioInput.value = '';
        fetchProfiles();
    }
}

async function deleteProfile(profileId) {
    if (!confirm("Delete this profile?")) return;
    const { error } = await supabaseClient.from('profiles').delete().eq('uuid', profileId);
    if (error) alert("Error: " + error.message);
    else fetchProfiles();
}

// Start the app
fetchProfiles();