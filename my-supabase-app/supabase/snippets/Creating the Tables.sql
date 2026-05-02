-- 1. Create Profiles
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  student_id TEXT UNIQUE NOT NULL,
  full_name TEXT,
  security_question TEXT,
  security_answer TEXT,
  role TEXT DEFAULT 'user',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create Items
CREATE TABLE public.items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reporter_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  category TEXT,
  location_found TEXT,
  status TEXT DEFAULT 'found' CHECK (status IN ('lost', 'found', 'returned')),
  image_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Create Claims
CREATE TABLE public.claims (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  item_id UUID REFERENCES public.items(id) ON DELETE CASCADE,
  claimer_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  proof_text TEXT NOT NULL,
  claim_status TEXT DEFAULT 'pending' CHECK (claim_status IN ('pending', 'approved', 'denied')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. The Silent Trigger for Profiles (The v2 version)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, student_id, full_name, security_question, security_answer)
  VALUES (
    new.id, 
    new.raw_user_meta_data->>'student_id',
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'security_question',
    new.raw_user_meta_data->>'security_answer'
  );
  RETURN new;
EXCEPTION WHEN OTHERS THEN
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();