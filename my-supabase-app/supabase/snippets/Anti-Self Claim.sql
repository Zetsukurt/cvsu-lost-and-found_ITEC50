-- 1. Ensure Row Level Security is turned on for the claims table
ALTER TABLE claims ENABLE ROW LEVEL SECURITY;

-- 2. Create the firewall policy
CREATE POLICY "Prevent finders from claiming their own items"
ON claims
FOR INSERT
WITH CHECK (
    auth.uid() != (
        SELECT reporter_id
        FROM items
        WHERE id = item_id
    )
);