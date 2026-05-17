-- Title: Upgrade Trigger Security Clearance
-- Description: Re-creates the completion function with SECURITY DEFINER so it executes with bypass admin privileges.

CREATE OR REPLACE FUNCTION public.process_dual_claim_completion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.finder_confirmed = TRUE AND NEW.claimant_confirmed = TRUE THEN
        UPDATE public.items 
        SET status = 'claimed',
            claimed_at = NOW()
        WHERE id = NEW.item_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER; -- Forces the trigger to run with admin rights, bypassing client RLS restrictions safely
