-- 1. First, let's look at the CLAIMS table policies.
-- We need to allow the FINDER of an item to see the claims for that item.

CREATE POLICY "Finders can view claims for their items" 
ON public.claims 
FOR SELECT 
USING (
  EXISTS (
    SELECT 1 FROM public.items 
    WHERE items.id = claims.item_id 
    AND items.finder_id = auth.uid()
  )
);