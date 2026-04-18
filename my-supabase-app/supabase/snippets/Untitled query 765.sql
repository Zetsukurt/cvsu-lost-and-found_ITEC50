-- Allow the finder of an item to update the status of related claims
CREATE POLICY "Finders can update claim status" 
ON public.claims 
FOR UPDATE 
USING (
  EXISTS (
    SELECT 1 FROM public.items 
    WHERE items.id = claims.item_id 
    AND items.finder_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.items 
    WHERE items.id = claims.item_id 
    AND items.finder_id = auth.uid()
  )
);