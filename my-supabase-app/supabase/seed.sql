SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict SMFDjtaYm8mG68xapnX7HKFkQgne6oRWjRdCbR8g1YhKkrDwzI0OaZ8JfHELYwm

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
	('00000000-0000-0000-0000-000000000000', '49396764-5be7-4530-aeb0-80470e0a8999', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-03 10:08:44.464166+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd31ed77f-69a8-4dd6-98b3-4c47b4839a1e', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-05 08:18:59.688954+00', ''),
	('00000000-0000-0000-0000-000000000000', '2e4d4148-dd11-4c91-9df9-fd05abe5a241', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-05 08:18:59.71412+00', ''),
	('00000000-0000-0000-0000-000000000000', '78d0981c-0810-4916-84cb-343dbd4b82ca', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-05 09:38:05.716239+00', ''),
	('00000000-0000-0000-0000-000000000000', '3cbb02ce-e94f-4d2c-89e2-01d4a71416b0', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-05 09:38:05.739031+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b54dd1cc-e3f5-4fb4-90b5-09ccfc2728b4', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 10:25:31.610677+00', ''),
	('00000000-0000-0000-0000-000000000000', '4a920f23-7abf-49ea-b49b-583079dbbd34', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 11:00:59.73298+00', ''),
	('00000000-0000-0000-0000-000000000000', '5282697b-a359-4058-8725-82a6910eb007', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 11:01:04.389222+00', ''),
	('00000000-0000-0000-0000-000000000000', '3067fa79-60fa-48a5-a816-d160ab4b6beb', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 11:21:14.360211+00', ''),
	('00000000-0000-0000-0000-000000000000', '5ea0380f-bc59-471e-9831-97d6683047e1', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 11:21:18.086095+00', ''),
	('00000000-0000-0000-0000-000000000000', '87365e79-fa45-4a07-af9b-28bb13682617', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 11:29:37.217017+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d8a2ed4-cd03-4ffd-bef7-3245780e72ce', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 11:29:40.207928+00', ''),
	('00000000-0000-0000-0000-000000000000', '498d0cb3-8908-43ec-8559-ff1371de7ed5', '{"action":"user_signedup","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-05 13:30:27.745998+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd78bf80b-275d-4390-a155-c4749eb259f2', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 13:30:27.776065+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b57794b2-25e8-4ab2-8e5e-ceb69b939144', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 13:31:57.420287+00', ''),
	('00000000-0000-0000-0000-000000000000', '7803c52e-6187-4fef-a358-ba03ac2874fb', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 13:48:36.345488+00', ''),
	('00000000-0000-0000-0000-000000000000', '559c4a36-9c93-480e-9939-ee66a18c9b7f', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 13:48:46.247877+00', ''),
	('00000000-0000-0000-0000-000000000000', '98157780-3112-4c1a-9b33-f47f982ca362', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 13:48:55.606382+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c24e03c5-ce3b-4807-9506-623951834a84', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 13:49:20.85898+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd67014da-7363-40a8-8644-13910eaf1e81', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 13:52:38.013779+00', ''),
	('00000000-0000-0000-0000-000000000000', '351cd31b-6492-40db-ba32-162504b00577', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 16:00:24.376025+00', ''),
	('00000000-0000-0000-0000-000000000000', '08333638-9605-48f0-9d69-2ef3cafc4502', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 16:00:41.284021+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b57b15b-3c8d-457a-a420-b19a78df785d', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 16:00:49.33075+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fdbbbe4e-1694-418d-8eac-7f9afa94c44e', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 16:05:45.334303+00', ''),
	('00000000-0000-0000-0000-000000000000', '2dca37f7-4fa2-4bd5-a79c-3dac6607a32a', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-05 16:05:53.693525+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eb7974ec-bc18-4859-bae3-e8133f1ef11a', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-05 16:07:16.763806+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd30dfcb2-3fda-4e73-9405-a48525545e47', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-09 01:49:36.096234+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd852c54c-fd4a-411c-be5a-509b3d6cbe23', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-09 01:49:57.278394+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd5cb9ac-6567-405e-b2ef-ef1ccf3678e2', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-09 01:50:25.587627+00', ''),
	('00000000-0000-0000-0000-000000000000', '6ba6a312-8c35-4f97-a514-188aef8fcb78', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-09 01:50:59.724625+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b9af4eeb-6f2b-465e-afe5-0c4c84446685', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-14 06:28:41.847884+00', ''),
	('00000000-0000-0000-0000-000000000000', '7b859b6a-9460-4045-8242-17b0c6094c12', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-14 06:48:22.542734+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc8fb47d-f519-4390-b1ae-0ad45fcbc794', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-14 06:48:57.682798+00', ''),
	('00000000-0000-0000-0000-000000000000', '536fb4d6-d615-4a46-9717-433c34920462', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-14 06:55:35.94591+00', ''),
	('00000000-0000-0000-0000-000000000000', '283d5006-f815-4c52-acd4-2bbac6476af5', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-14 06:55:42.235906+00', ''),
	('00000000-0000-0000-0000-000000000000', '65de5c0f-52f1-48ea-9597-b4a6b7d83bf0', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-14 07:14:19.489216+00', ''),
	('00000000-0000-0000-0000-000000000000', '319841cf-f4b4-4a87-92e1-f0fc4cfbdcaf', '{"action":"user_signedup","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-14 07:33:28.997633+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd2179c4a-99c4-4c06-8984-7da037ab5c37', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-14 07:33:29.024472+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc6a2ef2-145e-44a4-8def-751dffa45585', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-14 07:34:41.425938+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ea6e1a90-3dde-4ba0-8629-d3557a7bdcaf', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-15 08:29:11.206819+00', ''),
	('00000000-0000-0000-0000-000000000000', '11d2ff99-b53d-45f3-802c-d9b7aaca72c9', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-15 08:29:11.214005+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e213328b-4011-4c1a-b19d-768b6a3683fa', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-15 09:27:47.904141+00', ''),
	('00000000-0000-0000-0000-000000000000', '5f1a24d6-36f8-464f-865e-33d24c8c6044', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-15 09:27:47.91087+00', '');


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
	('00000000-0000-0000-0000-000000000000', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', 'authenticated', 'authenticated', '251012345@cvsu.edu.ph', '$2a$10$3g6hFqkhQhn7GNq4ESEGHOlPfz/IVIrjCPFIlMZUzBjrfgxCOlZz2', '2026-05-14 07:33:29.00213+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-14 07:34:41.427637+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "7cb5831c-e9bd-4c87-804d-2b4c4c60737c", "email": "251012345@cvsu.edu.ph", "full_name": "Roise Samuel Martinez", "student_id": "251012345", "contact_number": "09159296144", "email_verified": true, "phone_verified": false, "security_answer": "cavite science high school", "security_question": "highschool"}', NULL, '2026-05-14 07:33:28.946686+00', '2026-05-15 09:27:47.926793+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '680a5c61-16d7-4e10-ac83-84592dab642f', 'authenticated', 'authenticated', '251012089@cvsu.edu.ph', '$2a$06$6GYUanYOuH.tVMQaOcaaA.ugevjP1wrVanfwtci6Zp2UV2Ru3p9MW', '2026-05-05 13:30:27.752813+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-14 06:48:57.684373+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "680a5c61-16d7-4e10-ac83-84592dab642f", "email": "251012089@cvsu.edu.ph", "full_name": "Ace Ibea", "student_id": "251012089", "email_verified": true, "phone_verified": false, "security_answer": "perpetual", "security_question": "highschool"}', NULL, '2026-05-05 13:30:27.714504+00', '2026-05-14 06:48:57.691401+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'authenticated', 'authenticated', '251011821@cvsu.edu.ph', '$2a$06$q5RcgST/vgqYrgspwTzOGe6vohBY3UEw/99oiPhnj7pyo5.sMe3bO', '2026-04-30 14:20:59.254362+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-14 06:55:42.237405+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "d35efff1-94f0-45f4-8027-d385344bb40c", "email": "251011821@cvsu.edu.ph", "full_name": "zeto cabahug", "student_id": "251011821", "email_verified": true, "phone_verified": false, "security_answer": "manila", "security_question": "city"}', NULL, '2026-04-30 14:20:59.130828+00', '2026-05-14 06:55:42.242844+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('d35efff1-94f0-45f4-8027-d385344bb40c', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{"sub": "d35efff1-94f0-45f4-8027-d385344bb40c", "email": "251011821@cvsu.edu.ph", "full_name": "zeto cabahug", "student_id": "251011821", "email_verified": false, "phone_verified": false, "security_answer": "manila", "security_question": "city"}', 'email', '2026-04-30 14:20:59.227836+00', '2026-04-30 14:20:59.227923+00', '2026-04-30 14:20:59.227923+00', '9e1bb474-27db-4eb2-a716-08aa6bb58cf5'),
	('680a5c61-16d7-4e10-ac83-84592dab642f', '680a5c61-16d7-4e10-ac83-84592dab642f', '{"sub": "680a5c61-16d7-4e10-ac83-84592dab642f", "email": "251012089@cvsu.edu.ph", "full_name": "Ace Ibea", "student_id": "251012089", "email_verified": false, "phone_verified": false, "security_answer": "perpetual", "security_question": "highschool"}', 'email', '2026-05-05 13:30:27.739136+00', '2026-05-05 13:30:27.739329+00', '2026-05-05 13:30:27.739329+00', 'd601c0fa-de84-4b69-ab89-b201a086576a'),
	('7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '{"sub": "7cb5831c-e9bd-4c87-804d-2b4c4c60737c", "email": "251012345@cvsu.edu.ph", "full_name": "Roise Samuel Martinez", "student_id": "251012345", "contact_number": "09159296144", "email_verified": false, "phone_verified": false, "security_answer": "cavite science high school", "security_question": "highschool"}', 'email', '2026-05-14 07:33:28.988788+00', '2026-05-14 07:33:28.988834+00', '2026-05-14 07:33:28.988834+00', '0f4de506-3505-4e98-92d3-be558a5497b5');


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
	('d22dbebd-99bf-4374-85c3-f7ce2ecc93b3', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '2026-05-14 07:33:29.027669+00', '2026-05-14 07:33:29.027669+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0', '172.18.0.1', NULL, NULL, NULL, NULL, NULL),
	('9f57e80d-dcc0-497b-a336-150061d8a698', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '2026-05-14 07:34:41.427881+00', '2026-05-15 09:27:47.931272+00', NULL, 'aal1', NULL, '2026-05-15 09:27:47.931098', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0', '172.18.0.1', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('d22dbebd-99bf-4374-85c3-f7ce2ecc93b3', '2026-05-14 07:33:29.049858+00', '2026-05-14 07:33:29.049858+00', 'password', 'e0fd0662-5f90-4423-9152-d59aba8867d7'),
	('9f57e80d-dcc0-497b-a336-150061d8a698', '2026-05-14 07:34:41.435303+00', '2026-05-14 07:34:41.435303+00', 'password', '62dd0656-3ef5-40c8-8460-674c2dbc8843');


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
	('00000000-0000-0000-0000-000000000000', 29, 'heqxatnnawbu', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', false, '2026-05-14 07:33:29.035799+00', '2026-05-14 07:33:29.035799+00', NULL, 'd22dbebd-99bf-4374-85c3-f7ce2ecc93b3'),
	('00000000-0000-0000-0000-000000000000', 30, 'rjmycmydg2ag', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', true, '2026-05-14 07:34:41.432018+00', '2026-05-15 08:29:11.215304+00', NULL, '9f57e80d-dcc0-497b-a336-150061d8a698'),
	('00000000-0000-0000-0000-000000000000', 31, 'ccap542ziboc', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', true, '2026-05-15 08:29:11.220033+00', '2026-05-15 09:27:47.911742+00', 'rjmycmydg2ag', '9f57e80d-dcc0-497b-a336-150061d8a698'),
	('00000000-0000-0000-0000-000000000000', 32, '6ktrda4k5nm6', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', false, '2026-05-15 09:27:47.923954+00', '2026-05-15 09:27:47.923954+00', 'ccap542ziboc', '9f57e80d-dcc0-497b-a336-150061d8a698');


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

INSERT INTO "public"."profiles" ("id", "student_id", "full_name", "security_question", "security_answer", "role", "created_at", "contact_info") VALUES
	('680a5c61-16d7-4e10-ac83-84592dab642f', '251012089', 'Ace Ibea', 'highschool', 'perpetual', 'user', '2026-05-05 13:30:27.713623+00', '09123456789'),
	('d35efff1-94f0-45f4-8027-d385344bb40c', '251011821', 'zeto cabahug', 'city', 'manila', 'admin', '2026-04-30 14:20:59.123516+00', '09453343596'),
	('7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '251012345', 'Roise Samuel Martinez', 'highschool', 'cavite science high school', 'user', '2026-05-14 07:33:28.941021+00', NULL);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."items" ("id", "reporter_id", "title", "description", "category", "location_found", "status", "image_url", "created_at") VALUES
	('2219bd5b-e73a-47a9-a124-972e9050857f', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'Phone', 'iphone 14', 'Electronics', 'DIT Lobby', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1777711704884.png', '2026-05-02 08:48:24.976074+00'),
	('7d6d30e0-9c7a-4c01-a4ab-dcad1a7e0f87', 'd35efff1-94f0-45f4-8027-d385344bb40c', 'Wallet', 'CK, black wallet', 'Personal', 'CEIT', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1777803013578.jpg', '2026-05-03 10:10:14.547481+00'),
	('e85dd9e7-7ad7-47cb-be63-e474138c1c6e', '680a5c61-16d7-4e10-ac83-84592dab642f', 'ID', 'ID NI ACE IBEA', 'Documents', 'Oval', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1777989045529.png', '2026-05-05 13:50:46.097788+00'),
	('6872dd79-1941-485b-acfb-3c8fff52f9d6', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', 'Money', 'Money worth 3k', 'Personal', 'DIT', 'found', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1778744334916.jpg', '2026-05-14 07:38:56.657712+00');


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
	('512a4cbb-779e-41e5-ba87-eab403771e66', 'item-images', '1777803013578.jpg', 'd35efff1-94f0-45f4-8027-d385344bb40c', '2026-05-03 10:10:14.322005+00', '2026-05-03 10:10:14.322005+00', '2026-05-03 10:10:14.322005+00', '{"eTag": "\"18d5c64d2bfb606540294f5c1e57b20d\"", "size": 18120, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-03T10:10:14.298Z", "contentLength": 18120, "httpStatusCode": 200}', '094ae0c9-df0f-4262-9df5-dc6bf29205a3', 'd35efff1-94f0-45f4-8027-d385344bb40c', '{}'),
	('c5a5e0c4-a819-4aed-8f74-27b4a53fd7e4', 'item-images', '1777989045529.png', '680a5c61-16d7-4e10-ac83-84592dab642f', '2026-05-05 13:50:45.837476+00', '2026-05-05 13:50:45.837476+00', '2026-05-05 13:50:45.837476+00', '{"eTag": "\"950203de639cb7327b234e5ce489fa9c\"", "size": 47983, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-05T13:50:45.821Z", "contentLength": 47983, "httpStatusCode": 200}', '41c3c2c7-d0ec-4283-ac5f-0dec2ab25844', '680a5c61-16d7-4e10-ac83-84592dab642f', '{}'),
	('ba236871-55ff-4071-92cf-d568fe96575f', 'item-images', '1778744334916.jpg', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '2026-05-14 07:38:56.417581+00', '2026-05-14 07:38:56.417581+00', '2026-05-14 07:38:56.417581+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-14T07:38:56.378Z", "contentLength": 106873, "httpStatusCode": 200}', '477be9a7-1b00-470f-887c-3a5654bccb9d', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '{}');


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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 32, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict SMFDjtaYm8mG68xapnX7HKFkQgne6oRWjRdCbR8g1YhKkrDwzI0OaZ8JfHELYwm

RESET ALL;
