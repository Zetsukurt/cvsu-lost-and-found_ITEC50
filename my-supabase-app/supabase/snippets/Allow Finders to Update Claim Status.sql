-- Title: Allow Finders to Update Claim Status
-- Description: Permits the creator of an item to approve or reject claims linked to it.

CREATE POLICY "Allow finders to update claims on their items" ON public.claims
FOR UPDATE
TO authenticated
USING (
    auth.uid() IN (
        SELECT reporter_id FROM public.items WHERE items.id = claims.item_id
    )
);
