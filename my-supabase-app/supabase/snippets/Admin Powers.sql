-- Allow admins to update or delete ANY item
DROP POLICY IF EXISTS "Reporters can update own items" ON public.items;

CREATE POLICY "Reporters and Admins can update items" 
ON public.items FOR UPDATE 
USING (auth.uid() = reporter_id OR is_admin());

CREATE POLICY "Admins can delete items" 
ON public.items FOR DELETE 
USING (is_admin());