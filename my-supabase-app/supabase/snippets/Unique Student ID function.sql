ALTER TABLE public.profiles 
ADD CONSTRAINT unique_student_id UNIQUE (student_id);