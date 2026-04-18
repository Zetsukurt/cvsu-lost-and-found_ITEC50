-- 1. Create the claims table
CREATE TABLE claims (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    item_id UUID REFERENCES items(id) ON DELETE CASCADE,
    claimer_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    proof_text TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE claims ENABLE ROW LEVEL SECURITY;

-- 3. Policy: Users can see their own claims
CREATE POLICY "Users can view their own claims" 
ON claims FOR SELECT 
USING (auth.uid() = claimer_id);

-- 4. Policy: Users can insert their own claims
CREATE POLICY "Users can create claims" 
ON claims FOR INSERT 
WITH CHECK (auth.uid() = claimer_id);