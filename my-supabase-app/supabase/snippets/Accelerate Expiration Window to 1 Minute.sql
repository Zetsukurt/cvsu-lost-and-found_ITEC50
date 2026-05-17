-- Title: Accelerate Expiration Window to 1 Minute
-- Description: Replaces the 24-hour expiration interval with a 1-minute window for accelerated development testing.

CREATE OR REPLACE FUNCTION public.enforce_claim_expiration_windows()
RETURNS void AS $$
BEGIN
    -- 1. Revert parent items back to available status
    UPDATE public.items
    SET status = 'found',
        pickup_location = NULL
    WHERE id IN (
        SELECT item_id 
        FROM public.claims 
        WHERE claim_status = 'approved' 
          AND (finder_confirmed = FALSE OR claimant_confirmed = FALSE)
          AND approved_at < NOW() - INTERVAL '1 minute'
    );

    -- 2. Reset the stalled claim records back to pending review
    UPDATE public.claims
    SET claim_status = 'pending',
        finder_confirmed = FALSE,
        claimant_confirmed = FALSE,
        approved_at = NULL
    WHERE claim_status = 'approved'
      AND (finder_confirmed = FALSE OR claimant_confirmed = FALSE)
      AND approved_at < NOW() - INTERVAL '1 minute';
end;
$$ LANGUAGE plpgsql;