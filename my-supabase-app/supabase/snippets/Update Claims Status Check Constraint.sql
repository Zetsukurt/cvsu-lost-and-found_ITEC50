-- Title: Update Claims Status Check Constraint
-- Description: Replaces the status check constraint to allow 'approved' as a valid database value.

ALTER TABLE public.claims 
DROP CONSTRAINT IF EXISTS claims_claim_status_check;

ALTER TABLE public.claims 
ADD CONSTRAINT claims_claim_status_check 
CHECK (claim_status IN ('pending', 'approved', 'rejected', 'accepted'));