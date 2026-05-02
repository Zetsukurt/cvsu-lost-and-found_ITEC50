ALTER POLICY "Users can update own profile" ON public.profiles
USING ( (SELECT auth.uid()) = id )
WITH CHECK ( (SELECT auth.uid()) = id );

ALTER POLICY "Users can submit claims" ON public.claims
WITH CHECK ( (SELECT auth.uid()) = user_id);

ALTER POLICY "Reporters and Admins can update items" ON public.items
USING ( (SELECT auth.uid()) = reporter_id OR (SELECT is_admin()) )
WITH CHECK ( (SELECT auth.uid()) = reporter_id OR (SELECT is_admin()) );

ALTER POLICY "Users and Admins can view claims" ON public.claims
USING ( (SELECT auth.uid()) = user_id OR (SELECT is_admin()) );