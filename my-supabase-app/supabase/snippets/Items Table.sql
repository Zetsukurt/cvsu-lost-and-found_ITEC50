-- 1. Everyone (even guests) can see the lost/found items
CREATE POLICY "Public Read Access" 
ON public.items FOR SELECT 
USING (true);

-- 2. Only logged-in students can report an item
CREATE POLICY "Authenticated users can report items" 
ON public.items FOR INSERT 
WITH CHECK (auth.uid() IS NOT NULL);

-- 3. Only the person who reported it can edit or delete it
CREATE POLICY "Reporters can update own items" 
ON public.items FOR UPDATE 
USING (auth.uid() = reporter_id);