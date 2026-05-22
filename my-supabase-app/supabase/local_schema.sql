


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."enforce_claim_expiration_windows"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- 1. Revert parent items back to available status
    UPDATE public.items
    SET status = 'found',
        pickup_location = NULL
    WHERE id IN (
        SELECT item_id 
        FROM public.claims 
        WHERE claim_status = 'approved' 
          AND (finder_confirmed = FALSE OR claimant_confirmed = FALSE)
          AND approved_at < NOW() - INTERVAL '5 minute'
    );

    -- 2. Reset the stalled claim records back to pending review
    UPDATE public.claims
    SET claim_status = 'pending',
        finder_confirmed = FALSE,
        claimant_confirmed = FALSE,
        approved_at = NULL
    WHERE claim_status = 'approved'
      AND (finder_confirmed = FALSE OR claimant_confirmed = FALSE)
      AND approved_at < NOW() - INTERVAL '1 minute';
end;
$$;


ALTER FUNCTION "public"."enforce_claim_expiration_windows"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$BEGIN
  INSERT INTO public.profiles (id, student_id, full_name, security_question, security_answer, contact_info)
  VALUES (
    new.id, 
    new.raw_user_meta_data->>'student_id',
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'security_question',
    new.raw_user_meta_data->>'security_answer',
    new.raw_user_meta_data->>'contact_info'    
  );
  RETURN new;
EXCEPTION WHEN OTHERS THEN
  RETURN new;
END;$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  RETURN (
    SELECT (role = 'admin')
    FROM public.profiles
    WHERE id = auth.uid()
  );
END;
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."process_dual_claim_completion"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    IF NEW.finder_confirmed = TRUE AND NEW.claimant_confirmed = TRUE THEN
        UPDATE public.items 
        SET status = 'claimed',
            claimed_at = NOW()
        WHERE id = NEW.item_id;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."process_dual_claim_completion"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."reset_password_via_security_question"("target_student_id" "text", "provided_answer" "text", "new_password_text" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."reset_password_via_security_question"("target_student_id" "text", "provided_answer" "text", "new_password_text" "text") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."claims" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "item_id" "uuid",
    "claimer_id" "uuid",
    "proof_text" "text" NOT NULL,
    "claim_status" "text" DEFAULT 'pending'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "claimant_contact" "text",
    "finder_confirmed" boolean DEFAULT false,
    "claimant_confirmed" boolean DEFAULT false,
    "approved_at" timestamp with time zone,
    "is_archived_by_claimer" boolean DEFAULT false,
    CONSTRAINT "claims_claim_status_check" CHECK (("claim_status" = ANY (ARRAY['pending'::"text", 'approved'::"text", 'rejected'::"text", 'accepted'::"text"])))
);


ALTER TABLE "public"."claims" OWNER TO "postgres";


COMMENT ON TABLE "public"."claims" IS '@graphql({"enabled": false})';



CREATE TABLE IF NOT EXISTS "public"."enrolled_students" (
    "student_id" "text" NOT NULL,
    "full_name" "text" NOT NULL
);


ALTER TABLE "public"."enrolled_students" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."items" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "reporter_id" "uuid",
    "title" "text" NOT NULL,
    "description" "text",
    "category" "text",
    "location_found" "text",
    "status" "text" DEFAULT 'found'::"text",
    "image_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "pickup_location" "text",
    "claimed_at" timestamp with time zone,
    "is_archived_by_finder" boolean DEFAULT false,
    CONSTRAINT "items_status_check" CHECK (("status" = ANY (ARRAY['found'::"text", 'pending'::"text", 'claimed'::"text", 'returned'::"text"])))
);


ALTER TABLE "public"."items" OWNER TO "postgres";


COMMENT ON TABLE "public"."items" IS '@graphql({"enabled": false})';



CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "student_id" "text" NOT NULL,
    "full_name" "text",
    "security_question" "text",
    "security_answer" "text",
    "role" "text" DEFAULT 'user'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "contact_info" "text"
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


COMMENT ON TABLE "public"."profiles" IS '@graphql({"enabled": false})';



CREATE OR REPLACE VIEW "public"."public_recovery_questions" AS
 SELECT "student_id",
    "security_question"
   FROM "public"."profiles";


ALTER VIEW "public"."public_recovery_questions" OWNER TO "postgres";


ALTER TABLE ONLY "public"."claims"
    ADD CONSTRAINT "claims_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."enrolled_students"
    ADD CONSTRAINT "enrolled_students_pkey" PRIMARY KEY ("student_id");



ALTER TABLE ONLY "public"."items"
    ADD CONSTRAINT "items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_student_id_key" UNIQUE ("student_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "unique_student_id" UNIQUE ("student_id");



ALTER TABLE ONLY "public"."claims"
    ADD CONSTRAINT "unique_user_item_claim" UNIQUE ("item_id", "claimer_id");



CREATE OR REPLACE TRIGGER "trigger_sync_claim_completion" BEFORE UPDATE ON "public"."claims" FOR EACH ROW EXECUTE FUNCTION "public"."process_dual_claim_completion"();



ALTER TABLE ONLY "public"."claims"
    ADD CONSTRAINT "claims_claimer_id_fkey" FOREIGN KEY ("claimer_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."claims"
    ADD CONSTRAINT "claims_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."items"
    ADD CONSTRAINT "items_reporter_id_fkey" FOREIGN KEY ("reporter_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Admins can delete items" ON "public"."items" FOR DELETE USING ("public"."is_admin"());



CREATE POLICY "Admins can update claim status" ON "public"."claims" FOR UPDATE USING ("public"."is_admin"());



CREATE POLICY "Allow claimants to update their own claims" ON "public"."claims" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "claimer_id"));



CREATE POLICY "Allow finders to update claims on their items" ON "public"."claims" FOR UPDATE TO "authenticated" USING (("item_id" IN ( SELECT "items"."id"
   FROM "public"."items"
  WHERE ("items"."reporter_id" = ( SELECT "auth"."uid"() AS "uid")))));



CREATE POLICY "Allow finders to update their own items" ON "public"."items" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "reporter_id"));



CREATE POLICY "Allow finders to view claims on their items" ON "public"."claims" FOR SELECT TO "authenticated" USING (("item_id" IN ( SELECT "items"."id"
   FROM "public"."items"
  WHERE ("items"."reporter_id" = ( SELECT "auth"."uid"() AS "uid")))));



CREATE POLICY "Allow public read access for profiles" ON "public"."profiles" FOR SELECT USING (true);



CREATE POLICY "Allow public read access to enrollment verification" ON "public"."enrolled_students" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Optimized update access for claims" ON "public"."claims" FOR UPDATE TO "authenticated" USING (((( SELECT "auth"."uid"() AS "uid") = "claimer_id") OR ("item_id" IN ( SELECT "items"."id"
   FROM "public"."items"
  WHERE ("items"."reporter_id" = ( SELECT "auth"."uid"() AS "uid")))) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = ( SELECT "auth"."uid"() AS "uid"))) = 'admin'::"text")));



CREATE POLICY "Optimized update access for items" ON "public"."items" FOR UPDATE TO "authenticated" USING (((( SELECT "auth"."uid"() AS "uid") = "reporter_id") OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = ( SELECT "auth"."uid"() AS "uid"))) = 'admin'::"text")));



CREATE POLICY "Optimized view access for claims" ON "public"."claims" FOR SELECT TO "authenticated" USING (((( SELECT "auth"."uid"() AS "uid") = "claimer_id") OR ("item_id" IN ( SELECT "items"."id"
   FROM "public"."items"
  WHERE ("items"."reporter_id" = ( SELECT "auth"."uid"() AS "uid")))) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = ( SELECT "auth"."uid"() AS "uid"))) = 'admin'::"text")));



CREATE POLICY "Prevent finders from claiming their own items" ON "public"."claims" FOR INSERT WITH CHECK (("auth"."uid"() <> ( SELECT "items"."reporter_id"
   FROM "public"."items"
  WHERE ("items"."id" = "claims"."item_id"))));



CREATE POLICY "Public can view found items" ON "public"."items" FOR SELECT USING (true);



CREATE POLICY "Public items are viewable by everyone" ON "public"."items" FOR SELECT USING (true);



CREATE POLICY "Public profiles are viewable by everyone" ON "public"."profiles" FOR SELECT USING (true);



CREATE POLICY "Reporters and Admins can update items" ON "public"."items" FOR UPDATE USING (((( SELECT "auth"."uid"() AS "uid") = "reporter_id") OR ( SELECT "public"."is_admin"() AS "is_admin"))) WITH CHECK (((( SELECT "auth"."uid"() AS "uid") = "reporter_id") OR ( SELECT "public"."is_admin"() AS "is_admin")));



CREATE POLICY "Users and Admins can view claims" ON "public"."claims" FOR SELECT USING (((( SELECT "auth"."uid"() AS "uid") = "claimer_id") OR ( SELECT "public"."is_admin"() AS "is_admin")));



CREATE POLICY "Users can report found items" ON "public"."items" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "reporter_id"));



CREATE POLICY "Users can submit claims" ON "public"."claims" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "claimer_id"));



CREATE POLICY "Users can update own profile" ON "public"."profiles" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "id"));



CREATE POLICY "Users can update their own reports" ON "public"."items" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "reporter_id"));



CREATE POLICY "Users can view own profile" ON "public"."profiles" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "id"));



ALTER TABLE "public"."claims" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."enrolled_students" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."items";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";































































































































































GRANT ALL ON FUNCTION "public"."enforce_claim_expiration_windows"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_claim_expiration_windows"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_claim_expiration_windows"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."handle_new_user"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."is_admin"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";



GRANT ALL ON FUNCTION "public"."process_dual_claim_completion"() TO "anon";
GRANT ALL ON FUNCTION "public"."process_dual_claim_completion"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."process_dual_claim_completion"() TO "service_role";



GRANT ALL ON FUNCTION "public"."reset_password_via_security_question"("target_student_id" "text", "provided_answer" "text", "new_password_text" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."reset_password_via_security_question"("target_student_id" "text", "provided_answer" "text", "new_password_text" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."reset_password_via_security_question"("target_student_id" "text", "provided_answer" "text", "new_password_text" "text") TO "service_role";


















GRANT ALL ON TABLE "public"."claims" TO "anon";
GRANT ALL ON TABLE "public"."claims" TO "authenticated";
GRANT ALL ON TABLE "public"."claims" TO "service_role";



GRANT ALL ON TABLE "public"."enrolled_students" TO "anon";
GRANT ALL ON TABLE "public"."enrolled_students" TO "authenticated";
GRANT ALL ON TABLE "public"."enrolled_students" TO "service_role";



GRANT ALL ON TABLE "public"."items" TO "anon";
GRANT ALL ON TABLE "public"."items" TO "authenticated";
GRANT ALL ON TABLE "public"."items" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."public_recovery_questions" TO "anon";
GRANT ALL ON TABLE "public"."public_recovery_questions" TO "authenticated";
GRANT ALL ON TABLE "public"."public_recovery_questions" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































