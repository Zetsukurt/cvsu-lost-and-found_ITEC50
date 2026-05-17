-- Title: Allow Claimants to Update Their Own Claims
-- Description: Permits the creator of a claim to toggle confirmation check flags.

CREATE POLICY "Allow claimants to update their own claims" ON public.claims
FOR UPDATE
TO authenticated
USING (auth.uid() = claimer_id)
WITH CHECK (auth.uid() = claimer_id);