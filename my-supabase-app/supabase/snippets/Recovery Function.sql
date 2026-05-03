CREATE OR REPLACE FUNCTION reset_password_via_security_question(
    target_student_id TEXT,
    provided_answer TEXT,
    new_password_text TEXT
)
RETURNS BOOLEAN AS $$
DECLARE
    user_uuid UUID;
BEGIN
    -- 1. Verify the student ID and answer match in the profiles table
    SELECT id INTO user_uuid 
    FROM public.profiles 
    WHERE student_id = target_student_id 
    AND LOWER(security_answer) = LOWER(provided_answer);

    -- 2. If a match is found, update the actual authentication password
    IF user_uuid IS NOT NULL THEN
        UPDATE auth.users 
        SET encrypted_password = crypt(new_password_text, gen_salt('bf'))
        WHERE id = user_uuid;
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;