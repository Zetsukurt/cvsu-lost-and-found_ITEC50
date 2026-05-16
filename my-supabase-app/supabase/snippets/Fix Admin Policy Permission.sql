-- 1. Upgrade the function's execution privilege security clearance
ALTER FUNCTION public.is_admin() SECURITY DEFINER;

-- 2. Explicitly allow authenticated students to trigger the check via the API
GRANT EXECUTE ON FUNCTION public.is_admin() TO anon, authenticated, service_role;