-- 1. Clear the old version
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- 2. Create the "Bulletproof" function
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email, role, student_id)
  VALUES (
    new.id, 
    COALESCE(new.raw_user_meta_data->>'full_name', 'New Student'), 
    new.email, 
    'user',
    '' -- Provides an empty string for student_id to satisfy NOT NULL constraints
  )
  ON CONFLICT (id) DO NOTHING; -- Prevents errors if a profile already exists
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 3. Re-apply the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();