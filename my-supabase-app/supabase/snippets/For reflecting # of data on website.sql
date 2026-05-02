-- Allow everyone (logged in or not) to see found items
CREATE POLICY "Public can view found items" 
ON public.items 
FOR SELECT 
USING (true);