-- Title: Emergency Sync Reset Routine
-- Description: Unlocks any testing items currently trapped in out-of-sync states.

-- 1. If an item is pending but has no active approved claims, reset it to 'found' so buttons reappear
UPDATE public.items
SET status = 'found',
    pickup_location = NULL
WHERE status = 'pending'
  AND id NOT IN (SELECT item_id FROM public.claims WHERE claim_status = 'approved');

-- 2. If a claim has dual confirmations complete, force its parent item to 'claimed' status right now
UPDATE public.items
SET status = 'claimed',
    claimed_at = NOW()
WHERE id IN (SELECT item_id FROM public.claims WHERE finder_confirmed = TRUE AND claimant_confirmed = TRUE);