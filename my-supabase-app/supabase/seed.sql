SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict tMOxDab375ytoAukhNSbomMRxAxuZJs12l2wjzgzDFs7TgRiorAwli7EZLledlU

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', 'effaf416-1da0-4159-be02-f00a4ac4e10c', '{"action":"user_signedup","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-04-30 14:20:59.248328+00', ''),
	('00000000-0000-0000-0000-000000000000', '8d713148-03f3-4500-9b7a-1a5ec2dcc7bf', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-04-30 14:20:59.282727+00', ''),
	('00000000-0000-0000-0000-000000000000', '187c0bd4-e7aa-4aa2-8d06-145d34ce5405', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-04-30 14:21:04.223909+00', ''),
	('00000000-0000-0000-0000-000000000000', '4dfb8682-2ab3-47f3-92ed-f154abda9757', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-04-30 15:29:50.712069+00', ''),
	('00000000-0000-0000-0000-000000000000', '1df59782-4a76-448c-91eb-fe5bc3c8a3cc', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-04-30 15:29:50.724601+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a0fb5625-cb89-4bda-a6b6-28f8359496d5', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 06:31:36.2682+00', ''),
	('00000000-0000-0000-0000-000000000000', '8615a44c-a372-49df-9dae-93b1c985d17f', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 06:31:36.289394+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd15ed53-d938-42ea-b4c9-48dddd30b751', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 08:43:51.193288+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c6d8f63f-de14-49ac-83ae-48a4ba5e6797', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 08:43:51.206942+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bde8f36f-fbb9-4e30-b322-851617740bc2', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 12:50:13.686716+00', ''),
	('00000000-0000-0000-0000-000000000000', '1d97c45a-1366-4cd5-a34a-df479cb8f44d', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-02 12:50:13.691194+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd79b24b-8ec0-4bd9-b954-585e4bc53cc2', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-02 13:28:49.020339+00', ''),
	('00000000-0000-0000-0000-000000000000', '0394ee3a-2b6b-4bad-9f45-f6af10974ef3', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-03 09:38:34.987655+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4bc45f7-37f6-4559-bf02-d236371d3be2', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-03 09:38:34.998201+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de486b3d-223e-470b-865f-431de45db9fa', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-03 09:44:28.987635+00', ''),
	('00000000-0000-0000-0000-000000000000', '91a54273-ad44-4eb8-a3d2-9659901e17ad', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-03 09:44:33.635124+00', ''),
	('00000000-0000-0000-0000-000000000000', '99ea4a21-b6e1-43e4-9964-361af1280a4f', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-03 09:46:15.781235+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dcc0b33a-7776-4071-bd1e-2b966b1d6c5e', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-03 09:46:23.555655+00', ''),
	('00000000-0000-0000-0000-000000000000', '49396764-5be7-4530-aeb0-80470e0a8999', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-03 10:08:44.464166+00', '');


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'authenticated', 'authenticated', '251011821@cvsu.edu.ph', '$2a$06$uT.7MsL0PdjTue7p4E02nO9bVe/4QkKdVW3NQzjfTQAezFuH/WZpm', '2026-04-30 14:20:59.254362+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-03 10:08:44.471288+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "d35efff1-94f0-45f4-8027-d385344bb40c", "email": "251011821@cvsu.edu.ph", "full_name": "zeto cabahug", "student_id": "251011821", "email_verified": true, "phone_verified": false, "security_answer": "manila", "security_question": "city"}', NULL, '2026-04-30 14:20:59.130828+00', '2026-05-03 10:08:44.500866+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('d35efff1-94f0-45f4-8027-d385344bb40c', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{"sub": "d35efff1-94f0-45f4-8027-d385344bb40c", "email": "251011821@cvsu.edu.ph", "full_name": "zeto cabahug", "student_id": "251011821", "email_verified": false, "phone_verified": false, "security_answer": "manila", "security_question": "city"}', 'email', '2026-04-30 14:20:59.227836+00', '2026-04-30 14:20:59.227923+00', '2026-04-30 14:20:59.227923+00', '9e1bb474-27db-4eb2-a716-08aa6bb58cf5');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('8da1f7d2-3da0-4b11-88ae-3319be7feea4', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-03 10:08:44.471627+00', '2026-05-03 10:08:44.471627+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0', '172.18.0.1', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('8da1f7d2-3da0-4b11-88ae-3319be7feea4', '2026-05-03 10:08:44.503513+00', '2026-05-03 10:08:44.503513+00', 'password', '061af476-6bf3-43ab-9c3f-66f223c055d7');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 11, 'vq5miez2p2g6', 'd35efff1-94f0-45f4-8027-d385344bb40c', false, '2026-05-03 10:08:44.492417+00', '2026-05-03 10:08:44.492417+00', NULL, '8da1f7d2-3da0-4b11-88ae-3319be7feea4');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "student_id", "full_name", "security_question", "security_answer", "role", "created_at") VALUES
	('d35efff1-94f0-45f4-8027-d385344bb40c', '251011821', 'zeto cabahug', 'city', 'manila', 'admin', '2026-04-30 14:20:59.123516+00');


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."items" ("id", "reporter_id", "title", "description", "category", "location_found", "status", "image_url", "created_at") VALUES
	('2219bd5b-e73a-47a9-a124-972e9050857f', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'Phone', 'iphone 14', 'Electronics', 'DIT Lobby', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1777711704884.png', '2026-05-02 08:48:24.976074+00'),
	('7d6d30e0-9c7a-4c01-a4ab-dcad1a7e0f87', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'Wallet', 'CK, black wallet', 'Personal', 'CEIT', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1777803013578.jpg', '2026-05-03 10:10:14.547481+00');


--
-- Data for Name: claims; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('item-images', 'item-images', NULL, '2026-04-30 15:19:41.047994+00', '2026-04-30 15:19:41.047994+00', true, false, NULL, NULL, NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('3943f592-800c-4279-bc81-c5bb285358ad', 'item-images', '1777711468250.png', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-02 08:44:28.512601+00', '2026-05-02 08:44:28.512601+00', '2026-05-02 08:44:28.512601+00', '{"eTag": "\"4a2f5287ee10b42519b69417c7128bca\"", "size": 132127, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-02T08:44:28.497Z", "contentLength": 132127, "httpStatusCode": 200}', '57b9ef27-1204-4328-83aa-5b439983c683', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{}'),
	('6561a440-ffc9-42a7-a470-3f0e5fa7740a', 'item-images', '1777711578370.png', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-02 08:46:18.425972+00', '2026-05-02 08:46:18.425972+00', '2026-05-02 08:46:18.425972+00', '{"eTag": "\"4a2f5287ee10b42519b69417c7128bca\"", "size": 132127, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-02T08:46:18.420Z", "contentLength": 132127, "httpStatusCode": 200}', '4a114f1c-1c8a-40ab-b426-a22e457342e3', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{}'),
	('3325e3d9-18e2-45bd-92cb-0a389e5acba7', 'item-images', '1777711704884.png', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-02 08:48:24.927348+00', '2026-05-02 08:48:24.927348+00', '2026-05-02 08:48:24.927348+00', '{"eTag": "\"4a2f5287ee10b42519b69417c7128bca\"", "size": 132127, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-02T08:48:24.919Z", "contentLength": 132127, "httpStatusCode": 200}', '26943413-5f27-437a-a8dc-a6a35e104c97', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{}'),
	('512a4cbb-779e-41e5-ba87-eab403771e66', 'item-images', '1777803013578.jpg', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-03 10:10:14.322005+00', '2026-05-03 10:10:14.322005+00', '2026-05-03 10:10:14.322005+00', '{"eTag": "\"18d5c64d2bfb606540294f5c1e57b20d\"", "size": 18120, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-03T10:10:14.298Z", "contentLength": 18120, "httpStatusCode": 200}', '094ae0c9-df0f-4262-9df5-dc6bf29205a3', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{}');


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 11, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict tMOxDab375ytoAukhNSbomMRxAxuZJs12l2wjzgzDFs7TgRiorAwli7EZLledlU

RESET ALL;
