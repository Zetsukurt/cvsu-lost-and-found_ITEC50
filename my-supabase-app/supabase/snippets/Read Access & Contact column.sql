-- Adds the column to your existing profiles table
ALTER TABLE profiles 
ADD COLUMN contact_info TEXT;

-- CRITICAL: Ensure everyone can read this column so it shows up in the gallery
-- This fixes the "Anonymous" / Hidden data issue
CREATE POLICY "Allow public read access for profiles" 
ON profiles FOR SELECT 
USING (true);