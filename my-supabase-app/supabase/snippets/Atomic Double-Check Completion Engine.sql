-- Title: Atomic Double-Check Completion Engine
-- Description: Automatically marks items as fully claimed once both parties sign off.
CREATE OR REPLACE FUNCTION public.process_dual_claim_completion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.finder_confirmed = TRUE AND NEW.claimant_confirmed = TRUE THEN
        -- Move parent item state to claimed to update the dashboard counters
        UPDATE public.items 
        SET status = 'claimed'
        WHERE id = NEW.item_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_sync_claim_completion
BEFORE UPDATE ON public.claims
FOR EACH ROW
EXECUTE FUNCTION public.process_dual_claim_completion();