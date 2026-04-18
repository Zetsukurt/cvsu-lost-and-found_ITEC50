  -- Allow finders to update the status of items they reported
  CREATE POLICY "Finders can update their reported items" 
  ON public.items 
  FOR UPDATE 
  USING (auth.uid() = finder_id)
  WITH CHECK (auth.uid() = finder_id);