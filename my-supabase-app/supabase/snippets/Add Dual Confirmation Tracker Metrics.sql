-- Title: Add Dual Confirmation Tracker Metrics
-- Description: Creates verification flags and timestamp thresholds on the claims relation.

ALTER TABLE public.claims 
ADD COLUMN IF NOT EXISTS finder_confirmed BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS claimant_confirmed BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS approved_at TIMESTAMPTZ;

