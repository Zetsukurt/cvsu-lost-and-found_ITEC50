-- Title: Track Hand-off Completion Timestamps
-- Description: Adds a timestamp column and updates the dual-confirmation function to log the exact completion moment.

ALTER TABLE public.items 
ADD COLUMN IF NOT EXISTS claimed_at TIMESTAMPTZ;

CREATE OR REPLACE FUNCTION public.process_dual_claim_completion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.finder_confirmed = TRUE AND NEW.claimant_confirmed = TRUE THEN
        -- Mark item as claimed and drop the timestamp anchor right now
        UPDATE public.items 
        SET status = 'claimed',
            claimed_at = NOW()
        WHERE id = NEW.item_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;