-- 2. Create a policy that allows anyone to view any profile
-- This is necessary so the "By: [Name]" labels work for everyone
CREATE POLICY "Public profiles are viewable by everyone" 
ON profiles 
FOR SELECT 
USING (true);