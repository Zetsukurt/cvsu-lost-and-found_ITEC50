-- Create a dedicated INSERT policy for items
CREATE POLICY "Users can report found items" 
ON public.items 
FOR INSERT 
TO authenticated 
WITH CHECK ( (SELECT auth.uid()) = reporter_id );