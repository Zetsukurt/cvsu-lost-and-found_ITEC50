CREATE POLICY "Admins can delete items" 
ON public.items 
FOR DELETE 
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);