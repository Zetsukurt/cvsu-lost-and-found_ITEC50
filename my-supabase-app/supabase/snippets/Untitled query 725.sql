-- Adds the timestamp column so we can calculate the grace period
ALTER TABLE public.items 
ADD COLUMN IF NOT EXISTS returned_at TIMESTAMP WITH TIME ZONE;