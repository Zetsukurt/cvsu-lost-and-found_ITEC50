-- Let the finder hide the item from 'My Found Items'
ALTER TABLE items 
ADD COLUMN is_archived_by_finder BOOLEAN DEFAULT false;

-- Let the claimant hide the claim from 'My Claims'
ALTER TABLE claims 
ADD COLUMN is_archived_by_claimer BOOLEAN DEFAULT false;