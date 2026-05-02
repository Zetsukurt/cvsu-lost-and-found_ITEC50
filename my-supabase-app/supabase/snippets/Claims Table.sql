-- Users can see only their own claims
CREATE POLICY "Users can view own claims" 
ON public.claims FOR SELECT 
USING (auth.uid() = claimer_id);

-- Users can submit a claim
CREATE POLICY "Users can submit claims" 
ON public.claims FOR INSERT 
WITH CHECK (auth.uid() IS NOT NULL);