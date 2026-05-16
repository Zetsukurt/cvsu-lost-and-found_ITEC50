-- Title: Fix Items Table Status Check Constraint
-- Description: Expands the valid statuses for items to allow 'pending' during verification pickups.

ALTER TABLE public.items 
DROP CONSTRAINT IF EXISTS items_status_check;

ALTER TABLE public.items 
ADD CONSTRAINT items_status_check 
CHECK (status IN ('found', 'pending', 'claimed', 'returned'));