
  create table "public"."claims" (
    "id" uuid not null default gen_random_uuid(),
    "item_id" uuid,
    "claimer_id" uuid,
    "proof_text" text not null,
    "claim_status" text default 'pending'::text,
    "created_at" timestamp with time zone default now(),
    "claimant_contact" text,
    "finder_confirmed" boolean default false,
    "claimant_confirmed" boolean default false,
    "approved_at" timestamp with time zone,
    "is_archived_by_claimer" boolean default false
      );


alter table "public"."claims" enable row level security;


  create table "public"."enrolled_students" (
    "student_id" text not null,
    "full_name" text not null
      );


alter table "public"."enrolled_students" enable row level security;


  create table "public"."items" (
    "id" uuid not null default gen_random_uuid(),
    "reporter_id" uuid,
    "title" text not null,
    "description" text,
    "category" text,
    "location_found" text,
    "status" text default 'found'::text,
    "image_url" text,
    "created_at" timestamp with time zone default now(),
    "pickup_location" text,
    "claimed_at" timestamp with time zone,
    "is_archived_by_finder" boolean default false
      );


alter table "public"."items" enable row level security;


  create table "public"."profiles" (
    "id" uuid not null,
    "student_id" text not null,
    "full_name" text,
    "security_question" text,
    "security_answer" text,
    "role" text default 'user'::text,
    "created_at" timestamp with time zone default now(),
    "contact_info" text
      );


alter table "public"."profiles" enable row level security;

CREATE UNIQUE INDEX claims_pkey ON public.claims USING btree (id);

CREATE UNIQUE INDEX enrolled_students_pkey ON public.enrolled_students USING btree (student_id);

CREATE UNIQUE INDEX items_pkey ON public.items USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX profiles_student_id_key ON public.profiles USING btree (student_id);

CREATE UNIQUE INDEX unique_student_id ON public.profiles USING btree (student_id);

CREATE UNIQUE INDEX unique_user_item_claim ON public.claims USING btree (item_id, claimer_id);

alter table "public"."claims" add constraint "claims_pkey" PRIMARY KEY using index "claims_pkey";

alter table "public"."enrolled_students" add constraint "enrolled_students_pkey" PRIMARY KEY using index "enrolled_students_pkey";

alter table "public"."items" add constraint "items_pkey" PRIMARY KEY using index "items_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."claims" add constraint "claims_claim_status_check" CHECK ((claim_status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text, 'accepted'::text]))) not valid;

alter table "public"."claims" validate constraint "claims_claim_status_check";

alter table "public"."claims" add constraint "claims_claimer_id_fkey" FOREIGN KEY (claimer_id) REFERENCES public.profiles(id) ON DELETE CASCADE not valid;

alter table "public"."claims" validate constraint "claims_claimer_id_fkey";

alter table "public"."claims" add constraint "claims_item_id_fkey" FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE not valid;

alter table "public"."claims" validate constraint "claims_item_id_fkey";

alter table "public"."claims" add constraint "unique_user_item_claim" UNIQUE using index "unique_user_item_claim";

alter table "public"."items" add constraint "items_reporter_id_fkey" FOREIGN KEY (reporter_id) REFERENCES public.profiles(id) ON DELETE CASCADE not valid;

alter table "public"."items" validate constraint "items_reporter_id_fkey";

alter table "public"."items" add constraint "items_status_check" CHECK ((status = ANY (ARRAY['found'::text, 'pending'::text, 'claimed'::text, 'returned'::text]))) not valid;

alter table "public"."items" validate constraint "items_status_check";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."profiles" add constraint "profiles_student_id_key" UNIQUE using index "profiles_student_id_key";

alter table "public"."profiles" add constraint "unique_student_id" UNIQUE using index "unique_student_id";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.enforce_claim_expiration_windows()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$BEGIN
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
END;$function$
;

CREATE OR REPLACE FUNCTION public.is_admin()
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  RETURN (
    SELECT (role = 'admin')
    FROM public.profiles
    WHERE id = auth.uid()
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.process_dual_claim_completion()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    IF NEW.finder_confirmed = TRUE AND NEW.claimant_confirmed = TRUE THEN
        UPDATE public.items 
        SET status = 'claimed',
            claimed_at = NOW()
        WHERE id = NEW.item_id;
    END IF;
    RETURN NEW;
END;
$function$
;

create or replace view "public"."public_recovery_questions" as  SELECT student_id,
    security_question
   FROM public.profiles;


CREATE OR REPLACE FUNCTION public.reset_password_via_security_question(target_student_id text, provided_answer text, new_password_text text)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

grant delete on table "public"."claims" to "anon";

grant insert on table "public"."claims" to "anon";

grant references on table "public"."claims" to "anon";

grant select on table "public"."claims" to "anon";

grant trigger on table "public"."claims" to "anon";

grant truncate on table "public"."claims" to "anon";

grant update on table "public"."claims" to "anon";

grant delete on table "public"."claims" to "authenticated";

grant insert on table "public"."claims" to "authenticated";

grant references on table "public"."claims" to "authenticated";

grant select on table "public"."claims" to "authenticated";

grant trigger on table "public"."claims" to "authenticated";

grant truncate on table "public"."claims" to "authenticated";

grant update on table "public"."claims" to "authenticated";

grant delete on table "public"."claims" to "service_role";

grant insert on table "public"."claims" to "service_role";

grant references on table "public"."claims" to "service_role";

grant select on table "public"."claims" to "service_role";

grant trigger on table "public"."claims" to "service_role";

grant truncate on table "public"."claims" to "service_role";

grant update on table "public"."claims" to "service_role";

grant delete on table "public"."enrolled_students" to "anon";

grant insert on table "public"."enrolled_students" to "anon";

grant references on table "public"."enrolled_students" to "anon";

grant select on table "public"."enrolled_students" to "anon";

grant trigger on table "public"."enrolled_students" to "anon";

grant truncate on table "public"."enrolled_students" to "anon";

grant update on table "public"."enrolled_students" to "anon";

grant delete on table "public"."enrolled_students" to "authenticated";

grant insert on table "public"."enrolled_students" to "authenticated";

grant references on table "public"."enrolled_students" to "authenticated";

grant select on table "public"."enrolled_students" to "authenticated";

grant trigger on table "public"."enrolled_students" to "authenticated";

grant truncate on table "public"."enrolled_students" to "authenticated";

grant update on table "public"."enrolled_students" to "authenticated";

grant delete on table "public"."enrolled_students" to "service_role";

grant insert on table "public"."enrolled_students" to "service_role";

grant references on table "public"."enrolled_students" to "service_role";

grant select on table "public"."enrolled_students" to "service_role";

grant trigger on table "public"."enrolled_students" to "service_role";

grant truncate on table "public"."enrolled_students" to "service_role";

grant update on table "public"."enrolled_students" to "service_role";

grant delete on table "public"."items" to "anon";

grant insert on table "public"."items" to "anon";

grant references on table "public"."items" to "anon";

grant select on table "public"."items" to "anon";

grant trigger on table "public"."items" to "anon";

grant truncate on table "public"."items" to "anon";

grant update on table "public"."items" to "anon";

grant delete on table "public"."items" to "authenticated";

grant insert on table "public"."items" to "authenticated";

grant references on table "public"."items" to "authenticated";

grant select on table "public"."items" to "authenticated";

grant trigger on table "public"."items" to "authenticated";

grant truncate on table "public"."items" to "authenticated";

grant update on table "public"."items" to "authenticated";

grant delete on table "public"."items" to "service_role";

grant insert on table "public"."items" to "service_role";

grant references on table "public"."items" to "service_role";

grant select on table "public"."items" to "service_role";

grant trigger on table "public"."items" to "service_role";

grant truncate on table "public"."items" to "service_role";

grant update on table "public"."items" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";


  create policy "Admins can update claim status"
  on "public"."claims"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "Allow claimants to update their own claims"
  on "public"."claims"
  as permissive
  for update
  to authenticated
using ((( SELECT auth.uid() AS uid) = claimer_id));



  create policy "Allow finders to update claims on their items"
  on "public"."claims"
  as permissive
  for update
  to authenticated
using ((item_id IN ( SELECT items.id
   FROM public.items
  WHERE (items.reporter_id = ( SELECT auth.uid() AS uid)))));



  create policy "Allow finders to view claims on their items"
  on "public"."claims"
  as permissive
  for select
  to authenticated
using ((item_id IN ( SELECT items.id
   FROM public.items
  WHERE (items.reporter_id = ( SELECT auth.uid() AS uid)))));



  create policy "Optimized update access for claims"
  on "public"."claims"
  as permissive
  for update
  to authenticated
using (((( SELECT auth.uid() AS uid) = claimer_id) OR (item_id IN ( SELECT items.id
   FROM public.items
  WHERE (items.reporter_id = ( SELECT auth.uid() AS uid)))) OR (( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = ( SELECT auth.uid() AS uid))) = 'admin'::text)));



  create policy "Optimized view access for claims"
  on "public"."claims"
  as permissive
  for select
  to authenticated
using (((( SELECT auth.uid() AS uid) = claimer_id) OR (item_id IN ( SELECT items.id
   FROM public.items
  WHERE (items.reporter_id = ( SELECT auth.uid() AS uid)))) OR (( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = ( SELECT auth.uid() AS uid))) = 'admin'::text)));



  create policy "Prevent finders from claiming their own items"
  on "public"."claims"
  as permissive
  for insert
  to public
with check ((auth.uid() <> ( SELECT items.reporter_id
   FROM public.items
  WHERE (items.id = claims.item_id))));



  create policy "Users and Admins can view claims"
  on "public"."claims"
  as permissive
  for select
  to public
using (((( SELECT auth.uid() AS uid) = claimer_id) OR ( SELECT public.is_admin() AS is_admin)));



  create policy "Users can submit claims"
  on "public"."claims"
  as permissive
  for insert
  to public
with check ((( SELECT auth.uid() AS uid) = claimer_id));



  create policy "Allow public read access to enrollment verification"
  on "public"."enrolled_students"
  as permissive
  for select
  to anon, authenticated
using (true);



  create policy "Admins can delete items"
  on "public"."items"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "Allow finders to update their own items"
  on "public"."items"
  as permissive
  for update
  to authenticated
using ((( SELECT auth.uid() AS uid) = reporter_id));



  create policy "Optimized update access for items"
  on "public"."items"
  as permissive
  for update
  to authenticated
using (((( SELECT auth.uid() AS uid) = reporter_id) OR (( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = ( SELECT auth.uid() AS uid))) = 'admin'::text)));



  create policy "Public can view found items"
  on "public"."items"
  as permissive
  for select
  to public
using (true);



  create policy "Public items are viewable by everyone"
  on "public"."items"
  as permissive
  for select
  to public
using (true);



  create policy "Reporters and Admins can update items"
  on "public"."items"
  as permissive
  for update
  to public
using (((( SELECT auth.uid() AS uid) = reporter_id) OR ( SELECT public.is_admin() AS is_admin)))
with check (((( SELECT auth.uid() AS uid) = reporter_id) OR ( SELECT public.is_admin() AS is_admin)));



  create policy "Users can report found items"
  on "public"."items"
  as permissive
  for insert
  to authenticated
with check ((( SELECT auth.uid() AS uid) = reporter_id));



  create policy "Users can update their own reports"
  on "public"."items"
  as permissive
  for update
  to authenticated
using ((( SELECT auth.uid() AS uid) = reporter_id));



  create policy "Allow public read access for profiles"
  on "public"."profiles"
  as permissive
  for select
  to public
using (true);



  create policy "Public profiles are viewable by everyone"
  on "public"."profiles"
  as permissive
  for select
  to public
using (true);



  create policy "Users can update own profile"
  on "public"."profiles"
  as permissive
  for update
  to public
using ((( SELECT auth.uid() AS uid) = id))
with check ((( SELECT auth.uid() AS uid) = id));



  create policy "Users can view own profile"
  on "public"."profiles"
  as permissive
  for select
  to public
using ((( SELECT auth.uid() AS uid) = id));


CREATE TRIGGER trigger_sync_claim_completion BEFORE UPDATE ON public.claims FOR EACH ROW EXECUTE FUNCTION public.process_dual_claim_completion();

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


  create policy "Admins can delete images"
  on "storage"."objects"
  as permissive
  for delete
  to public
using (((bucket_id = 'item-images'::text) AND (( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'admin'::text)));



  create policy "Authenticated users can upload"
  on "storage"."objects"
  as permissive
  for insert
  to public
with check (((bucket_id = 'item-images'::text) AND (auth.role() = 'authenticated'::text)));



  create policy "Public Access"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'item-images'::text));



