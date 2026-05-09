-- Allow everyone (Public/Students) to see all items for the gallery
CREATE POLICY "Public items are viewable by everyone" 
ON items FOR SELECT 
USING (true);

-- Only allow the person who reported it to delete or edit it
CREATE POLICY "Users can update their own reports" 
ON items FOR UPDATE 
USING (auth.uid() = id);