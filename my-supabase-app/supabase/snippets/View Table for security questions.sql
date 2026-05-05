-- 1. Create or update the view to match your JS naming
CREATE OR REPLACE VIEW public_security_questions AS
SELECT student_id, security_question
FROM profiles;

-- 2. Give the public (anon) role permission to see it
GRANT SELECT ON public_security_questions TO anon;

-- 3. Force the API to refresh its permissions
NOTIFY pgrst, 'reload schema';