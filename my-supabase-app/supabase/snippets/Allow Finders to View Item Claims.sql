-- Title: Allow Finders to View Item Claims
-- Description: Enables users who reported an item to view incoming claims submitted for it.

CREATE POLICY "Allow finders to view claims on their items" ON public.claims
FOR SELECT
TO authenticated
USING (
    auth.uid() IN (
        SELECT reporter_id 
        FROM public.items 
        WHERE items.id = claims.item_id
    )
);