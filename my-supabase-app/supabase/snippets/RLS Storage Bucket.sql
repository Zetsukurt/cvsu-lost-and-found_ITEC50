-- 1. Allow anyone to view images (Public Read)
CREATE POLICY "Public Access" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'item-images');

-- 2. Allow only logged-in students to upload images
CREATE POLICY "Authenticated users can upload" 
ON storage.objects FOR INSERT 
WITH CHECK (
  bucket_id = 'item-images' AND 
  auth.role() = 'authenticated'
);

-- 3. Only the Admin can delete images
CREATE POLICY "Admins can delete images" 
ON storage.objects FOR DELETE 
USING (
  bucket_id = 'item-images' AND 
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);