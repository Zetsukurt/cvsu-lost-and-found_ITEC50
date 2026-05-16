
-- Title: Allow Finders to Update Item Status
-- Description: Permits the creator of an item to change status to pending and set pickup locations.

CREATE POLICY "Allow finders to update their own items" ON public.items
FOR UPDATE
TO authenticated
USING (auth.uid() = reporter_id);