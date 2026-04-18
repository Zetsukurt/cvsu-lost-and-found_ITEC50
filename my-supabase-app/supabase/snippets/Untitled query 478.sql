-- Enable RLS
ALTER TABLE public.items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.claims ENABLE ROW LEVEL SECURITY;

-- Allow anyone to see lost items
CREATE POLICY "Anyone can view items" ON public.items FOR SELECT USING (true);

-- Only logged-in students can report items
CREATE POLICY "Students can report items" ON public.items FOR INSERT WITH CHECK (auth.uid() = finder_id);

-- Only the claimer can see their own claims
CREATE POLICY "Users can view own claims" ON public.claims FOR SELECT USING (auth.uid() = user_id);

-- Students can submit claims
CREATE POLICY "Students can submit claims" ON public.claims FOR INSERT WITH CHECK (auth.uid() = user_id);