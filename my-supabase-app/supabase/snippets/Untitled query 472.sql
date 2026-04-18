-- Add the pickup location column to the items table
ALTER TABLE public.items 
ADD COLUMN IF NOT EXISTS pickup_location TEXT;