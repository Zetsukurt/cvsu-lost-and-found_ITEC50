-- Allow admins to see ALL claims, but users can still only see their own
DROP POLICY IF EXISTS "Users can view own claims" ON public.claims;

CREATE POLICY "Users and Admins can view claims" 
ON public.claims FOR SELECT 
USING (auth.uid() = claimer_id OR is_admin());

-- Allow admins to approve or deny claims
CREATE POLICY "Admins can update claim status" 
ON public.claims FOR UPDATE 
USING (is_admin());