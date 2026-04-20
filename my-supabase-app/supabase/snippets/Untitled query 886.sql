ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_email_key UNIQUE (email);