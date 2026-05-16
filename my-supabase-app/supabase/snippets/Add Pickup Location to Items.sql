-- Title: Add Pickup Location to Items
-- Description: Creates a storage column for verified claim pickup spots.

ALTER TABLE public.items 
ADD COLUMN IF NOT EXISTS pickup_location TEXT;