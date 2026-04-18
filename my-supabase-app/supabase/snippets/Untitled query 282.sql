-- 1. Create a policy for Admins to see EVERY item
CREATE POLICY "Admins can view all items" 
ON public.items 
FOR SELECT 
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);

-- 2. Create a policy for Admins to see EVERY claim
CREATE POLICY "Admins can view all claims" 
ON public.claims 
FOR SELECT 
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);