-- Hardening the handle_new_user function
ALTER FUNCTION public.handle_new_user() 
SET search_path = public;

-- Hardening the is_admin function
ALTER FUNCTION public.is_admin() 
SET search_path = public;