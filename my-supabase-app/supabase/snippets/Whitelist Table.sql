-- Create a table representing the university registrar's enrolled list
CREATE TABLE public.enrolled_students (
    student_id TEXT PRIMARY KEY,
    full_name TEXT NOT NULL
);

-- Turn off RLS for this specific table so the signup page can read it publicly
ALTER TABLE public.enrolled_students ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read access to enrollment verification" 
ON public.enrolled_students FOR SELECT TO anon, authenticated USING (true);

-- Seed it with a few valid IDs for your live demo
INSERT INTO public.enrolled_students (student_id, full_name) VALUES
('202610123', 'Gerard Jariel'),
('202611111', 'Test Student One'),
('202622222', 'Test Student Two');