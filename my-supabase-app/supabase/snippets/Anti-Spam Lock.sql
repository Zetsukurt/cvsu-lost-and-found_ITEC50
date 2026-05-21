-- Prevents a user from submitting more than one claim per item
ALTER TABLE claims 
ADD CONSTRAINT unique_user_item_claim UNIQUE (item_id, claimer_id);