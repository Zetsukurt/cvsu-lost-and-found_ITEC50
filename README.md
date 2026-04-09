The Lost & Found MVP Checklist
1. User Authentication (The "Who")
Sign Up/Login: Using Supabase Auth (Email/Password).

Session Management: The app should "remember" who is logged in so their name appears in the navbar.

Secure Reporting: Only logged-in students can report an item.

2. Item Reporting (The "What") — [DONE ✅]


Data Entry: Title, description, and location (no category yet)

Image Hosting: Files successfully uploading to Supabase Storage.

Database Record: Rows successfully appearing in the items table.

3. Public Gallery (The "Where") — [DONE ✅]

Display: A clean grid showing recent finds.

Status Indicators: Visual tags showing if an item is "Available" or "Returned."

4. Claiming Mechanism (The "How")
This is the "interaction" part of the app.

"That's Mine" Button: Each item card needs a button.

Proof Submission: A small text area where the owner describes a secret detail (e.g., "There’s a scratched sticker on the back").

Database Entry: This sends a row to your claims table.

5. Status Management (The "Resolution")
The loop needs to close so the item disappears from "Available."

Finder's Dashboard: A private page where the finder can see who claimed their item.

Approve/Reject: The finder clicks "Approve," which updates the items status to 'returned'.

