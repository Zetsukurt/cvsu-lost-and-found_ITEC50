-- 1. Clear the old stuff
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- 2. Create the fixed function that matches your SCHEMA
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email, role)
  VALUES (
    new.id, 
    COALESCE(new.raw_user_meta_data->>'full_name', 'New Student'), 
    new.email, -- Pulls directly from auth.users
    'user'     -- Hardcoded default to protect the CIA triad
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 3. Re-link the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();