SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict WwZY8wm96CyVyo91gThFFVkffS4oBiCYbxDXHwYdjnvgAZfv3UUZkfcINuvqCQW

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
	('00000000-0000-0000-0000-000000000000', '5f1a24d6-36f8-464f-865e-33d24c8c6044', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-15 09:27:47.91087+00', ''),
	('00000000-0000-0000-0000-000000000000', '492519d6-47b6-489a-9c4d-767ac3c57f71', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 03:01:28.846521+00', ''),
	('00000000-0000-0000-0000-000000000000', 'efab2d73-7f51-4fcc-8121-00bf6f594675', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 03:01:28.855757+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e24af37-449e-4aed-8f34-208bf721adce', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 03:31:31.344652+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b9f1f3fb-7baf-4c8e-ae25-95ee68253210', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 03:31:49.870462+00', ''),
	('00000000-0000-0000-0000-000000000000', 'aac84f17-e687-4cbe-bcc6-674f74298de9', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 03:32:55.468815+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4c17c73-6ff0-4bf1-9bb6-e6ed49bafe3b', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 03:34:09.272122+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c7647a6d-f6ec-47f7-9698-80cb7c904aac', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 04:32:39.736276+00', ''),
	('00000000-0000-0000-0000-000000000000', '9b80c128-1aee-4ce0-bb15-bcc55b08dedc', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 04:32:39.742676+00', ''),
	('00000000-0000-0000-0000-000000000000', 'db297f48-1c6b-481e-9c0f-22136c8e28f5', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 15:52:19.534093+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a7435a09-65b6-4e9a-88c5-0a3dfccc327b', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 15:52:19.540607+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c65921bc-8aaf-44fb-b0b8-657f27644a26', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 15:52:31.552002+00', ''),
	('00000000-0000-0000-0000-000000000000', '34b6ffd0-fe1c-4419-951b-ed5fd8cdb808', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 15:52:46.845135+00', ''),
	('00000000-0000-0000-0000-000000000000', '9db0e526-ca5e-4f0f-b94d-97fc5be62df0', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 18:16:30.043835+00', ''),
	('00000000-0000-0000-0000-000000000000', '73618b6a-fadc-4e44-8ff5-1839ef03594e', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-16 18:16:30.060514+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f0c7bb4-4827-4319-a16d-b8cb77787d50', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 18:17:37.696965+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a7f5317-366a-474c-be8c-e24ce9e15d6a', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 18:17:51.829882+00', ''),
	('00000000-0000-0000-0000-000000000000', '9613789e-ad7b-4239-bc76-8ad948ac36df', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 18:52:34.846134+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c26d5252-48a4-4014-acb3-7aac2eea523a', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 18:52:46.399322+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f6e6dbda-cd96-4751-bafc-6e490c914432', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 18:55:19.703431+00', ''),
	('00000000-0000-0000-0000-000000000000', '3930447d-be56-4985-806a-b58a3b61b48d', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 18:56:10.361292+00', ''),
	('00000000-0000-0000-0000-000000000000', '0e6741b2-e0a0-47da-a1b6-cf133026a964', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 18:58:30.330653+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee9fd5ac-8d6d-4cb2-86cc-15df4de44658', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 18:58:54.741611+00', ''),
	('00000000-0000-0000-0000-000000000000', '6946d075-83c3-42b0-9606-a901ad2502d0', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-16 18:59:35.236138+00', ''),
	('00000000-0000-0000-0000-000000000000', '89883e6c-7bff-4b3a-a7ab-682a1d2cd3fa', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-16 18:59:55.720243+00', ''),
	('00000000-0000-0000-0000-000000000000', '20193523-a20e-4fc3-b845-3a5a1facc5d4', '{"action":"token_refreshed","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 03:45:51.505251+00', ''),
	('00000000-0000-0000-0000-000000000000', '90fcb5ac-5b83-4b2a-921f-11892467c4d7', '{"action":"token_revoked","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 03:45:51.510717+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e534589-ed35-4b81-bcdc-80cc62931e8e', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:03:06.724013+00', ''),
	('00000000-0000-0000-0000-000000000000', '935dd0b8-0c60-4ccf-af32-0099c6e5cb63', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:03:15.139447+00', ''),
	('00000000-0000-0000-0000-000000000000', '40903162-22e5-4d19-8cfe-42fb51aa6a82', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:03:46.567276+00', ''),
	('00000000-0000-0000-0000-000000000000', '6a2ba487-d82f-4640-8e1a-819971578001', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:06:55.219355+00', ''),
	('00000000-0000-0000-0000-000000000000', '65f02f2f-a90f-4f09-928f-2893537a2a3d', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:07:12.993798+00', ''),
	('00000000-0000-0000-0000-000000000000', '2a2ddfa4-7419-490e-bb2f-349306b89f7e', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:22:31.273811+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cadb6f61-9eaf-4d18-805e-d2b5c047542d', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:24:22.740212+00', ''),
	('00000000-0000-0000-0000-000000000000', '98cfac9c-b56e-4aa5-bdec-3debd357e743', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:24:42.819528+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e06edbdf-6fa7-46b8-999e-083de742d0b8', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:25:44.989939+00', ''),
	('00000000-0000-0000-0000-000000000000', '127b5d28-18a0-4a01-8f4b-0e9e514ab6fd', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:25:54.33414+00', ''),
	('00000000-0000-0000-0000-000000000000', '0bb63938-3336-47c9-92b9-12be25b4d7ff', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:26:36.344622+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b3a80d66-9109-4a21-ad3c-93ac536d2e9a', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:28:10.149505+00', ''),
	('00000000-0000-0000-0000-000000000000', '02c56cfd-2b70-4d31-ae98-77bff9626e77', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:28:19.650733+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b98c6eef-21b1-4eda-8059-6b43a1737c2e', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:28:43.378781+00', ''),
	('00000000-0000-0000-0000-000000000000', 'df286699-90fd-416b-8fcd-6f9c3a153522', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:29:00.288069+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f32f8221-5e80-4e13-9d8b-5511f316a32a', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 04:30:01.191778+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8be6379-3ab3-400b-a4f8-52bfe72e9b6f', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 04:30:13.647843+00', ''),
	('00000000-0000-0000-0000-000000000000', 'abfe2fb3-0603-4638-ba5c-eda22250ab7a', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 14:21:01.449147+00', ''),
	('00000000-0000-0000-0000-000000000000', '6721da6c-2384-4bb8-83e5-2a06c5c5351b', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 14:21:01.458646+00', ''),
	('00000000-0000-0000-0000-000000000000', '5bc2fba9-cfc9-4d91-9ead-175971efb28f', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:21:13.492782+00', ''),
	('00000000-0000-0000-0000-000000000000', '56b2ed8e-ca95-49be-b11b-c7f0fbf2a5e0', '{"action":"login","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:23:05.329637+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f3f871c2-35a9-4883-ba8a-be831b7c2e1e', '{"action":"logout","actor_id":"680a5c61-16d7-4e10-ac83-84592dab642f","actor_name":"Ace Ibea","actor_username":"251012089@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:24:41.95265+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd7574bb8-e5f9-4e2f-8222-0c5f0b5c7d95', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:24:54.727511+00', ''),
	('00000000-0000-0000-0000-000000000000', '73b409f5-0bec-4772-b4c6-20dcc628e504', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:25:09.144944+00', ''),
	('00000000-0000-0000-0000-000000000000', '811a3867-3e1b-4ddf-8f3d-6b2a8586c696', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:25:19.859786+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a83df70f-2952-47ca-9401-768b3ce1f8fb', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:36:32.345238+00', ''),
	('00000000-0000-0000-0000-000000000000', '46bab88f-19a1-43cc-b1ab-d4b763a7c955', '{"action":"user_signedup","actor_id":"31640d12-9d8b-4b86-b1f7-a51fe0f7bc0b","actor_name":"laufey","actor_username":"251011223@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-17 14:37:51.82263+00', ''),
	('00000000-0000-0000-0000-000000000000', '64bbc4ab-c7e1-4f7f-aacd-acfadb569f49', '{"action":"login","actor_id":"31640d12-9d8b-4b86-b1f7-a51fe0f7bc0b","actor_name":"laufey","actor_username":"251011223@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:37:51.842241+00', ''),
	('00000000-0000-0000-0000-000000000000', '1c296e31-ee77-42d1-8ba3-60af8be3350a', '{"action":"login","actor_id":"31640d12-9d8b-4b86-b1f7-a51fe0f7bc0b","actor_name":"laufey","actor_username":"251011223@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:37:55.645588+00', ''),
	('00000000-0000-0000-0000-000000000000', '0fd114e3-463d-4b41-a526-98d0e3d12bf1', '{"action":"logout","actor_id":"31640d12-9d8b-4b86-b1f7-a51fe0f7bc0b","actor_name":"laufey","actor_username":"251011223@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:40:20.745955+00', ''),
	('00000000-0000-0000-0000-000000000000', '051d7a3b-e578-403e-a233-eab786713019', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:40:33.43712+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce19be52-3bec-473e-bda4-8809dcfa3c66', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 14:41:17.674141+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a9491dbf-fea5-4c70-8773-6c9f559d766d', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 14:41:24.96721+00', ''),
	('00000000-0000-0000-0000-000000000000', '84ed2640-1803-499d-a2a1-a52caec8f72b', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 15:39:35.434278+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c6e57d94-4a5c-4cc9-8060-9b2b6afd2c89', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-17 15:39:35.453202+00', ''),
	('00000000-0000-0000-0000-000000000000', '7501b073-0382-496d-b9f6-415f2e818bae', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-17 15:41:23.662513+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b0ff60b-3028-43ae-9828-ed97e7f805c7', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-17 15:49:55.180993+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb8b8813-6b77-49ae-9c2b-53953189d18e', '{"action":"token_refreshed","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-18 09:25:22.338108+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e64ab94f-f48a-434d-9ba8-2244c17dcac3', '{"action":"token_revoked","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-18 09:25:22.344846+00', ''),
	('00000000-0000-0000-0000-000000000000', '79b3507f-04e7-4547-bd21-f59670f257e2', '{"action":"user_signedup","actor_id":"2046b012-05e1-47c8-9839-797d4faf152e","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 09:28:52.450568+00', ''),
	('00000000-0000-0000-0000-000000000000', '782bc894-357a-48af-9806-ed7370e5e378', '{"action":"login","actor_id":"2046b012-05e1-47c8-9839-797d4faf152e","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:28:52.468454+00', ''),
	('00000000-0000-0000-0000-000000000000', '400c02f4-74a3-497b-a691-d8ec80095555', '{"action":"login","actor_id":"2046b012-05e1-47c8-9839-797d4faf152e","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:28:58.338018+00', ''),
	('00000000-0000-0000-0000-000000000000', '2566d8c3-569a-41c5-888b-23dcba3d0ac0', '{"action":"logout","actor_id":"2046b012-05e1-47c8-9839-797d4faf152e","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 09:30:49.899662+00', ''),
	('00000000-0000-0000-0000-000000000000', 'afe5554c-4cf8-4872-96d7-a33b39f57b51', '{"action":"user_repeated_signup","actor_id":"2046b012-05e1-47c8-9839-797d4faf152e","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2026-05-18 09:31:17.645616+00', ''),
	('00000000-0000-0000-0000-000000000000', '9af494ad-baac-4f7c-9a12-4ba8e9a0efed', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251098765@cvsu.edu.ph","user_id":"2046b012-05e1-47c8-9839-797d4faf152e","user_phone":""}}', '2026-05-18 09:31:29.542949+00', ''),
	('00000000-0000-0000-0000-000000000000', '4135f689-bb83-4535-b99c-44a08e2d9117', '{"action":"user_signedup","actor_id":"f0323d82-2173-49bc-bd67-ffdfd03b4f30","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 09:31:33.464282+00', ''),
	('00000000-0000-0000-0000-000000000000', '543d40b1-1af9-4dcc-aed8-97492643d5f0', '{"action":"login","actor_id":"f0323d82-2173-49bc-bd67-ffdfd03b4f30","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:31:33.497298+00', ''),
	('00000000-0000-0000-0000-000000000000', '23831119-e706-45fc-9c9f-c6fadb2b7074', '{"action":"login","actor_id":"f0323d82-2173-49bc-bd67-ffdfd03b4f30","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:31:36.682024+00', ''),
	('00000000-0000-0000-0000-000000000000', '76f71986-b024-48f5-9efc-e5002626c899', '{"action":"logout","actor_id":"f0323d82-2173-49bc-bd67-ffdfd03b4f30","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 09:36:07.174539+00', ''),
	('00000000-0000-0000-0000-000000000000', '7699a1cc-746e-4d96-b157-b66664da5fd9', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251098765@cvsu.edu.ph","user_id":"f0323d82-2173-49bc-bd67-ffdfd03b4f30","user_phone":""}}', '2026-05-18 09:36:16.268704+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ba2c1a69-6dcf-4f94-8a77-1fc6c3cb3989', '{"action":"user_signedup","actor_id":"70269034-7539-4a41-ad71-d85cd911943b","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 09:36:49.259032+00', ''),
	('00000000-0000-0000-0000-000000000000', '977cf05a-135f-4c2d-b316-d34a8429af6f', '{"action":"login","actor_id":"70269034-7539-4a41-ad71-d85cd911943b","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:36:49.275269+00', ''),
	('00000000-0000-0000-0000-000000000000', '524daa3d-99b0-42cb-8644-939685c036e5', '{"action":"login","actor_id":"70269034-7539-4a41-ad71-d85cd911943b","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:36:52.428579+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f8011dd1-4a2d-4dfc-8137-7c179bc0c962', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251098765@cvsu.edu.ph","user_id":"70269034-7539-4a41-ad71-d85cd911943b","user_phone":""}}', '2026-05-18 09:37:26.440179+00', ''),
	('00000000-0000-0000-0000-000000000000', 'adf4b929-ee00-49f7-a001-bdaf18912509', '{"action":"user_signedup","actor_id":"343b3139-0dfc-4642-a45e-1beb57b39faf","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 09:41:35.579081+00', ''),
	('00000000-0000-0000-0000-000000000000', '65763cdc-4784-482d-92ff-cccb6deeeff8', '{"action":"login","actor_id":"343b3139-0dfc-4642-a45e-1beb57b39faf","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:41:35.611772+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee9fd524-7184-44bf-abd9-d9219bf93e1a', '{"action":"login","actor_id":"343b3139-0dfc-4642-a45e-1beb57b39faf","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 09:41:40.47259+00', ''),
	('00000000-0000-0000-0000-000000000000', '57311945-7cc0-495d-b0cc-981245a127d4', '{"action":"logout","actor_id":"343b3139-0dfc-4642-a45e-1beb57b39faf","actor_name":"Juan Cruz","actor_username":"251098765@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 10:03:08.275177+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e1760d6e-c350-4ff4-b170-5e5036fd5dbc', '{"action":"login","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 10:03:13.968257+00', ''),
	('00000000-0000-0000-0000-000000000000', '4f6bfa5a-70b5-489d-b192-3656d09dbd73', '{"action":"logout","actor_id":"d35efff1-94f0-45f4-8027-d385344bb40c","actor_name":"zeto cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 10:04:14.67008+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b841b10d-f83f-45b3-8c04-06c4f1010d01', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 10:04:33.049301+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd711e1a1-8489-49b3-bea5-8f12699ee135', '{"action":"logout","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 10:32:35.251298+00', ''),
	('00000000-0000-0000-0000-000000000000', '1dfa6ed3-6366-4390-9af3-53d875f448e2', '{"action":"login","actor_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","actor_name":"Roise Samuel Martinez","actor_username":"251012345@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 10:37:09.55256+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b3797c67-798e-4610-8680-b142fb193179', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251011821@cvsu.edu.ph","user_id":"d35efff1-94f0-45f4-8027-d385344bb40c","user_phone":""}}', '2026-05-18 12:07:13.028369+00', ''),
	('00000000-0000-0000-0000-000000000000', '12de58c2-8b6d-4b24-9895-a6e24c15f803', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251012345@cvsu.edu.ph","user_id":"7cb5831c-e9bd-4c87-804d-2b4c4c60737c","user_phone":""}}', '2026-05-18 12:07:13.03755+00', ''),
	('00000000-0000-0000-0000-000000000000', '43211daf-a350-4abf-9e14-1179ad0219e0', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251012089@cvsu.edu.ph","user_id":"680a5c61-16d7-4e10-ac83-84592dab642f","user_phone":""}}', '2026-05-18 12:07:13.037271+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ae645e17-685d-46ff-abd3-4d3c00f7541a', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251011223@cvsu.edu.ph","user_id":"31640d12-9d8b-4b86-b1f7-a51fe0f7bc0b","user_phone":""}}', '2026-05-18 12:07:13.047243+00', ''),
	('00000000-0000-0000-0000-000000000000', '48823e52-cdf1-411f-9a9a-3accf08c3a05', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251098765@cvsu.edu.ph","user_id":"343b3139-0dfc-4642-a45e-1beb57b39faf","user_phone":""}}', '2026-05-18 12:07:13.054402+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd01706d5-ee0b-40f2-932d-f5faa8fab256', '{"action":"user_signedup","actor_id":"b5e704a4-3fd3-4d8f-908e-19fccadb0fe5","actor_name":"Juan Cruz","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 12:14:21.898477+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b32bf43-0837-4f90-988f-f0ed4d1d8e51', '{"action":"login","actor_id":"b5e704a4-3fd3-4d8f-908e-19fccadb0fe5","actor_name":"Juan Cruz","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 12:14:22.125021+00', ''),
	('00000000-0000-0000-0000-000000000000', '656ebc3c-9864-43ab-b998-9bac0d113145', '{"action":"login","actor_id":"b5e704a4-3fd3-4d8f-908e-19fccadb0fe5","actor_name":"Juan Cruz","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 12:14:29.94141+00', ''),
	('00000000-0000-0000-0000-000000000000', '5d0ad8e0-e5c4-4173-ace3-3783a350744e', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"251011821@cvsu.edu.ph","user_id":"b5e704a4-3fd3-4d8f-908e-19fccadb0fe5","user_phone":""}}', '2026-05-18 12:15:28.486225+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f5d5f98-304d-4f25-96fc-303ad2a2e793', '{"action":"user_signedup","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-18 12:17:37.030756+00', ''),
	('00000000-0000-0000-0000-000000000000', '82235e56-4bf7-4169-bf11-58d70b4a4993', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 12:17:37.049621+00', ''),
	('00000000-0000-0000-0000-000000000000', 'db24c829-72bc-4810-b088-5704f5414f96', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-18 12:17:40.526585+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5231b89-e89e-411b-8761-7bdc7514649c', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-18 12:45:01.74092+00', ''),
	('00000000-0000-0000-0000-000000000000', '53009473-7072-4fc8-9de5-11ca70c4c979', '{"action":"user_signedup","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-19 01:18:56.832174+00', ''),
	('00000000-0000-0000-0000-000000000000', '916cb9f9-a19f-44ee-82de-f7e2c74482bc', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:18:56.859595+00', ''),
	('00000000-0000-0000-0000-000000000000', '5d54727a-fb20-4a35-b1a2-bc5b21c28f5d', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:19:06.225424+00', ''),
	('00000000-0000-0000-0000-000000000000', '717da2b8-2bda-4ad1-906c-8c4cd70d8b63', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:22:11.209021+00', ''),
	('00000000-0000-0000-0000-000000000000', '31cac279-71b5-4b8a-8d70-d28f60be3354', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:23:29.852342+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee92c939-63f8-42c6-bbc9-0627dec411ee', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:24:25.270684+00', ''),
	('00000000-0000-0000-0000-000000000000', '21452cea-25f1-45f1-b6fa-790e872370f3', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:24:36.926039+00', ''),
	('00000000-0000-0000-0000-000000000000', '12f80748-28c6-481e-9d80-164da11b2215', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:25:38.807154+00', ''),
	('00000000-0000-0000-0000-000000000000', '3bf917a4-0d6a-4b69-b4ea-425b6743d0f0', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:25:58.884016+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ab342377-c288-44af-9bc8-6bb29a08558e', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:26:19.109611+00', ''),
	('00000000-0000-0000-0000-000000000000', '6b2f1f49-4a3b-4c9c-bce5-46516a6a5162', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:26:29.371935+00', ''),
	('00000000-0000-0000-0000-000000000000', '23b8be10-9518-4e9b-b0cc-41881efef3ff', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:26:55.022376+00', ''),
	('00000000-0000-0000-0000-000000000000', '62bed57d-510a-408d-bbc5-3ede246ee4e2', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:27:04.477237+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e271c4c2-c3d3-485c-9070-1a766c55bc73', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:27:25.090063+00', ''),
	('00000000-0000-0000-0000-000000000000', '1852b356-aa4a-4a45-b6a6-683de5997008', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:27:34.854312+00', ''),
	('00000000-0000-0000-0000-000000000000', '6b604ed3-3fa6-46c6-8ab5-929b802a3907', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:27:50.856477+00', ''),
	('00000000-0000-0000-0000-000000000000', '71ebe4ee-6447-4c0e-8212-b2fcdf5d3a1a', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:28:01.514915+00', ''),
	('00000000-0000-0000-0000-000000000000', '70eafa49-25ef-4f26-b9de-c0f3a2de2476', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:28:35.264092+00', ''),
	('00000000-0000-0000-0000-000000000000', '0e7286e3-7a16-4e89-b67f-774cd9863eb1', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:29:02.003635+00', ''),
	('00000000-0000-0000-0000-000000000000', '7934a792-bce9-498c-a960-1f3fb2852a8f', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:29:48.661922+00', ''),
	('00000000-0000-0000-0000-000000000000', '3e49144d-46d8-45fa-9a29-e55425b218d4', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:30:02.612479+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ffd52f72-c990-4fc1-9d04-34b3e9c47e56', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:30:39.746178+00', ''),
	('00000000-0000-0000-0000-000000000000', '748915eb-7a4d-4f4b-b436-36423691a50e', '{"action":"user_signedup","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-19 01:31:16.465858+00', ''),
	('00000000-0000-0000-0000-000000000000', '9c31c8c2-7ecc-4229-8892-157421d21f76', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:31:16.492393+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cdfa538e-baa0-4b1c-b2d8-57418c3e221b', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:31:20.097311+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f36406a9-ffd4-4cb7-b5ef-5db4db3219b8', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:31:31.191118+00', ''),
	('00000000-0000-0000-0000-000000000000', '02e1d4cb-2d92-424d-8f6c-107639f1a82b', '{"action":"user_signedup","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2026-05-19 01:32:04.832385+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c25253d6-0afd-4699-bae8-05ba828880a4', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:32:04.848165+00', ''),
	('00000000-0000-0000-0000-000000000000', '692aff86-9028-48ef-8c6f-afdb0fede6ed', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:32:07.517656+00', ''),
	('00000000-0000-0000-0000-000000000000', '33b9c989-dbe4-4410-aad6-c0b079306292', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:32:18.772163+00', ''),
	('00000000-0000-0000-0000-000000000000', '3882a8ad-4f73-4ba2-bd3e-207f53504618', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:32:28.47612+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c37499c5-8767-4b61-9190-d8f346c777a9', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:32:37.57622+00', ''),
	('00000000-0000-0000-0000-000000000000', '93153070-4075-401b-b76c-1b7cedea5111', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:33:06.246438+00', ''),
	('00000000-0000-0000-0000-000000000000', '57c386d6-afec-4ec8-935d-863fc9e5d06f', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:33:18.604293+00', ''),
	('00000000-0000-0000-0000-000000000000', '16190a12-fca2-427a-ac9a-afda6b2b8c34', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:33:28.358726+00', ''),
	('00000000-0000-0000-0000-000000000000', '4c380b03-4f48-429f-9047-a4dce0013b6b', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:33:40.557087+00', ''),
	('00000000-0000-0000-0000-000000000000', '13d8f33d-33a6-4ca9-a44f-47c0506b4197', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:33:50.03369+00', ''),
	('00000000-0000-0000-0000-000000000000', '16597023-6860-43a9-9a52-ac52b09be229', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:33:56.352678+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f93c5263-2aa3-49e9-b2a0-a3b95bb3641c', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:34:09.087655+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e44812e-44cb-4141-9c30-feb3cd084978', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:34:21.244415+00', ''),
	('00000000-0000-0000-0000-000000000000', '66d02d9a-92b7-4561-be6a-fd497177db05', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:34:27.818196+00', ''),
	('00000000-0000-0000-0000-000000000000', '13cc1684-f780-4261-aa72-cea93049157c', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:35:39.296561+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd285fc18-de90-41a2-8094-53aac4a8c6ae', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 01:35:51.775297+00', ''),
	('00000000-0000-0000-0000-000000000000', '97b657a9-cd2b-4525-8bf6-9268adc037a3', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-19 01:50:48.776745+00', ''),
	('00000000-0000-0000-0000-000000000000', '49f08240-ddbe-4f23-96d8-f26134c14d9e', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-19 02:49:40.835462+00', ''),
	('00000000-0000-0000-0000-000000000000', '81be1713-421b-421b-97f3-400c1fa3c478', '{"action":"token_refreshed","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-20 13:18:46.59485+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd4d52ade-970c-456f-84f0-b93425d97309', '{"action":"token_revoked","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-20 13:18:46.609874+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e1f82f2-f0f7-4498-9c9c-d4acaa63f5c9', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 13:21:14.577031+00', ''),
	('00000000-0000-0000-0000-000000000000', '4dc7e6d5-9afe-4175-9cf4-777e25046756', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 13:21:25.706112+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b5bfc9e-3238-4ebf-b142-c189c7413c9b', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 13:36:46.345957+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fa2ab3c3-3fe9-4278-9b94-4f5d68d246fe', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 13:36:55.154339+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd0aa2a4d-7519-4823-845f-b3f6fd8235fb', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 13:37:35.161033+00', ''),
	('00000000-0000-0000-0000-000000000000', '793d839e-c4b6-4681-bcb2-6d1bd4be3fbd', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 13:37:45.225512+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e637643-5bb7-473c-8939-34948a1051d5', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 13:42:19.329726+00', ''),
	('00000000-0000-0000-0000-000000000000', '3f77274e-5130-417c-bd7c-8a94456d3f1e', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 13:42:31.209912+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f243d713-d98d-4b1d-bd1b-9bc964a2bbe1', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:04:53.261451+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e79718a7-7613-4f92-b07a-60b487565c5a', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:05:13.500354+00', ''),
	('00000000-0000-0000-0000-000000000000', '61118710-f9d7-40e0-907a-45e34c3beac3', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:06:44.858742+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b157a9fb-2a6b-4ac4-9b84-1062a5b29fe4', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:06:55.12764+00', ''),
	('00000000-0000-0000-0000-000000000000', '9f4418b3-50c7-45fc-9469-749c554cab3e', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:19:59.782495+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4537fb6-8da0-41d0-957b-5a87c23073b2', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:21:09.687447+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd24d1621-74a2-4b5d-bed9-05248a51b3d4', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:22:24.627422+00', ''),
	('00000000-0000-0000-0000-000000000000', '34f5ca29-f03b-4575-bfeb-9221d25951dd', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:22:33.747469+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd2177e6-a0a9-4ac7-a2d5-3e2a1999e6cf', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:22:58.187676+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb7d5e24-01fc-4476-9842-42e54ad2a4cb', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:23:08.685045+00', ''),
	('00000000-0000-0000-0000-000000000000', '9552af59-4e90-4a0e-ade8-286aff6fbf55', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:25:04.199054+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d60d77d-f146-4378-a212-7b7ee562cbad', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:25:13.581389+00', ''),
	('00000000-0000-0000-0000-000000000000', '48d3a20d-875b-45ac-a7c4-e4705dad3c2c', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:25:32.66041+00', ''),
	('00000000-0000-0000-0000-000000000000', '1816dfe3-c57f-4895-b587-22886daaceb5', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:25:44.911672+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd4ac5c39-74e1-4dd1-b266-8c552b8a6f45', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:26:06.352758+00', ''),
	('00000000-0000-0000-0000-000000000000', '2a65ed93-8fa6-4824-bf7d-f9e3f1375bb5', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:26:15.692457+00', ''),
	('00000000-0000-0000-0000-000000000000', '26760d7f-e0ac-4562-9df8-5ca03fa801f2', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:33:51.685283+00', ''),
	('00000000-0000-0000-0000-000000000000', '8c371bd7-1cf4-4530-811c-50be10defe48', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:34:15.424089+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bfb1df84-bc9d-4871-85d8-c4ecade30fb0', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:35:16.352467+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f05ddfc7-b885-498d-9edd-400a055e43f7', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:36:10.00796+00', ''),
	('00000000-0000-0000-0000-000000000000', '03c7b2ee-e77c-4776-b28a-1ef461c24b16', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:36:50.394387+00', ''),
	('00000000-0000-0000-0000-000000000000', '5047b6b0-7b45-4606-ac30-bae8da9fa849', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:37:00.478648+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f664b011-0217-4e60-84cc-fbf67cbf9766', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:37:33.768422+00', ''),
	('00000000-0000-0000-0000-000000000000', '29a812a4-ed84-4f8d-9888-44ccb56b2d34', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:37:42.542562+00', ''),
	('00000000-0000-0000-0000-000000000000', '739988fe-4348-45b4-8fb4-d5fd381a765d', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:41:22.70765+00', ''),
	('00000000-0000-0000-0000-000000000000', '322cbf7e-96d3-4fc1-99e1-9623bd63e54e', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:41:33.11426+00', ''),
	('00000000-0000-0000-0000-000000000000', '4aa57d0c-8f3b-465a-a2d8-fdf056aae645', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:43:26.237304+00', ''),
	('00000000-0000-0000-0000-000000000000', '20998b51-5f7e-460a-ae39-817a4becdd4a', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:43:33.00101+00', ''),
	('00000000-0000-0000-0000-000000000000', '389a52af-dc79-44d2-ba0d-775fafa86218', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:44:13.120612+00', ''),
	('00000000-0000-0000-0000-000000000000', '215008b4-2ddc-4b9a-923d-95a38db07fc9', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:44:21.822378+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c0cbd55-0f0d-424e-a6c4-2216c06c7454', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:53:47.142982+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9a56d5e-75bf-4a7b-b6d8-31b4c2813632', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:54:02.285587+00', ''),
	('00000000-0000-0000-0000-000000000000', '9dcf4fd1-9b5a-4bae-957a-3274deb7c6c0', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:55:55.370735+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad8ca3ec-1e5c-437c-b702-972cd2fc5cff', '{"action":"login","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:56:03.430921+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4e2e0b0-aca2-4f0f-8f23-b692db5f17bf', '{"action":"logout","actor_id":"2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e","actor_name":"Lloyd Vergara","actor_username":"202622222@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-20 14:57:03.978556+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd4848029-f3c4-41c5-b4cb-0db2ec7224c0', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 14:57:15.493329+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed02bcea-2eb9-4292-a18f-53e4ffa4179a', '{"action":"token_refreshed","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-20 16:20:16.542273+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c52a7596-6274-49be-b75c-44617e70282a', '{"action":"token_revoked","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-20 16:20:16.553739+00', ''),
	('00000000-0000-0000-0000-000000000000', '98cbb40f-abe8-495b-a146-f37393323923', '{"action":"login","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-20 16:20:52.993433+00', ''),
	('00000000-0000-0000-0000-000000000000', '5b1e7576-a2bb-4715-9678-fc8b46bcd18c', '{"action":"token_refreshed","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-21 00:44:12.65381+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5f5f910-f153-4913-8c2e-18f8a93206c0', '{"action":"token_revoked","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-21 00:44:12.671031+00', ''),
	('00000000-0000-0000-0000-000000000000', '7789bf9f-d3e5-4da3-84e8-2ea8d0efb5cd', '{"action":"token_refreshed","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-21 01:55:56.794571+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f9b9ec57-01e1-4e79-91e1-1dcacdcfdb2f', '{"action":"token_revoked","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"token"}', '2026-05-21 01:55:56.815053+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c025b1dd-634d-4c94-8a46-f48ad8e6375e', '{"action":"logout","actor_id":"fce248b1-08c8-45be-8be8-0b17d815ce14","actor_name":"Zeto Riego de dios Cabahug","actor_username":"251011821@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-21 01:56:01.25349+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ea983541-cd7f-47e1-b0c4-9bfd3d4e00a5', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-21 01:56:13.456483+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e62db8d0-1c42-4586-8471-5b986186a91d', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-21 02:01:47.831155+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc1a99de-7b95-4ebb-b303-50619105be78', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-21 02:01:55.780707+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce3d8014-f383-45f5-bc1d-a167dce8e99e', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-21 02:12:07.09088+00', ''),
	('00000000-0000-0000-0000-000000000000', '8002327e-99a3-4356-bda3-93affc7a858f', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-21 02:12:20.737692+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a9dfb42d-3902-4b46-a237-a21cbef06548', '{"action":"logout","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-21 02:12:44.920435+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd726e38-a88c-4f4a-a063-9fcf940eb25c', '{"action":"login","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-21 02:12:53.902032+00', ''),
	('00000000-0000-0000-0000-000000000000', '54772d04-045f-4ef5-b0e1-8f630a58079f', '{"action":"logout","actor_id":"cbddab80-f2fd-4323-abcd-ce4ed6f54ccd","actor_name":"Roise Samuel Martinez","actor_username":"202611111@cvsu.edu.ph","actor_via_sso":false,"log_type":"account"}', '2026-05-21 02:18:35.075424+00', ''),
	('00000000-0000-0000-0000-000000000000', '1bb79905-adb7-4421-a346-9460f8f776c9', '{"action":"login","actor_id":"e4b94146-ffdb-419b-b7b1-f40183c361bb","actor_name":"Gerard Jariel","actor_username":"202610123@cvsu.edu.ph","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2026-05-21 02:18:45.22849+00', '');


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
	('00000000-0000-0000-0000-000000000000', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', 'authenticated', 'authenticated', '202622222@cvsu.edu.ph', '$2a$10$Y.4ts1IYxJVF7.5Um1HCsudx5/ICSei5HjbRMiw2Ehvqi88NC8p5i', '2026-05-19 01:18:56.839396+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-20 14:56:03.43224+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e", "email": "202622222@cvsu.edu.ph", "full_name": "Lloyd Vergara", "student_id": "202622222", "contact_info": "09159296144", "email_verified": true, "phone_verified": false, "security_answer": "alfonso", "security_question": "city"}', NULL, '2026-05-19 01:18:56.796542+00', '2026-05-20 14:56:03.435883+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', 'authenticated', 'authenticated', '202611111@cvsu.edu.ph', '$2a$06$d2zA0rQEZHv.NKptTnjDQOfYpoVvQOZ7Hr9Pn2H6lvphPctUrawUi', '2026-05-18 12:17:37.031689+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-21 02:12:53.903417+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "cbddab80-f2fd-4323-abcd-ce4ed6f54ccd", "email": "202611111@cvsu.edu.ph", "full_name": "Roise Samuel Martinez", "student_id": "202611111", "contact_info": "09123456789", "email_verified": true, "phone_verified": false, "security_answer": "cavite science high school", "security_question": "highschool"}', NULL, '2026-05-18 12:17:37.014997+00', '2026-05-21 02:12:53.906673+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', 'authenticated', 'authenticated', '202610123@cvsu.edu.ph', '$2a$06$kBdLgzFh0SVjAD16T9WjHub0nNx7DT.g0vItg/o6jjUWd9uIq165W', '2026-05-19 01:31:16.466967+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-21 02:18:45.23056+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "e4b94146-ffdb-419b-b7b1-f40183c361bb", "email": "202610123@cvsu.edu.ph", "full_name": "Gerard Jariel", "student_id": "202610123", "contact_info": "12345678900", "email_verified": true, "phone_verified": false, "security_answer": "popo", "security_question": "pet"}', NULL, '2026-05-19 01:31:16.450775+00', '2026-05-21 02:18:45.242482+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'fce248b1-08c8-45be-8be8-0b17d815ce14', 'authenticated', 'authenticated', '251011821@cvsu.edu.ph', '$2a$10$MJqKG49IK.lfvuqsQ5Q4p.PKLQ.RmdYcyzqF0Q9ZxOcZK9uz3LuEy', '2026-05-19 01:32:04.833257+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-20 16:20:52.994757+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "fce248b1-08c8-45be-8be8-0b17d815ce14", "email": "251011821@cvsu.edu.ph", "full_name": "Zeto Riego de dios Cabahug", "student_id": "251011821", "contact_info": "12345678901", "email_verified": true, "phone_verified": false, "security_answer": "ercihs", "security_question": "highschool"}', NULL, '2026-05-19 01:32:04.820172+00', '2026-05-21 01:55:56.827993+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{"sub": "cbddab80-f2fd-4323-abcd-ce4ed6f54ccd", "email": "202611111@cvsu.edu.ph", "full_name": "Roise Samuel Martinez", "student_id": "202611111", "contact_info": "09123456789", "email_verified": false, "phone_verified": false, "security_answer": "cavite science high school", "security_question": "highschool"}', 'email', '2026-05-18 12:17:37.021552+00', '2026-05-18 12:17:37.021596+00', '2026-05-18 12:17:37.021596+00', 'b7f302be-7dfc-41a9-88cb-9a7601b68afd'),
	('2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '{"sub": "2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e", "email": "202622222@cvsu.edu.ph", "full_name": "Lloyd Vergara", "student_id": "202622222", "contact_info": "09159296144", "email_verified": false, "phone_verified": false, "security_answer": "alfonso", "security_question": "city"}', 'email', '2026-05-19 01:18:56.825403+00', '2026-05-19 01:18:56.82544+00', '2026-05-19 01:18:56.82544+00', '1898ddf0-056f-4b97-92f9-1e6219544486'),
	('e4b94146-ffdb-419b-b7b1-f40183c361bb', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '{"sub": "e4b94146-ffdb-419b-b7b1-f40183c361bb", "email": "202610123@cvsu.edu.ph", "full_name": "Gerard Jariel", "student_id": "202610123", "contact_info": "12345678900", "email_verified": false, "phone_verified": false, "security_answer": "popo", "security_question": "pet"}', 'email', '2026-05-19 01:31:16.459815+00', '2026-05-19 01:31:16.459853+00', '2026-05-19 01:31:16.459853+00', '865c1ef4-5308-4191-aee9-5d81f942971a'),
	('fce248b1-08c8-45be-8be8-0b17d815ce14', 'fce248b1-08c8-45be-8be8-0b17d815ce14', '{"sub": "fce248b1-08c8-45be-8be8-0b17d815ce14", "email": "251011821@cvsu.edu.ph", "full_name": "Zeto Riego de dios Cabahug", "student_id": "251011821", "contact_info": "12345678901", "email_verified": false, "phone_verified": false, "security_answer": "ercihs", "security_question": "highschool"}', 'email', '2026-05-19 01:32:04.829761+00', '2026-05-19 01:32:04.829791+00', '2026-05-19 01:32:04.829791+00', 'b5027c27-201e-4aaa-828e-266cacc6cec9');


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
	('c0835485-6077-4f9c-aeee-0285f86dcdc2', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '2026-05-21 02:18:45.230798+00', '2026-05-21 02:18:45.230798+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 OPR/131.0.0.0', '172.18.0.1', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('c0835485-6077-4f9c-aeee-0285f86dcdc2', '2026-05-21 02:18:45.243514+00', '2026-05-21 02:18:45.243514+00', 'password', 'cab6ceb7-b539-4c35-b56e-e763f4c89fcd');


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
	('00000000-0000-0000-0000-000000000000', 168, 'mekiib6vf6rk', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', false, '2026-05-21 02:18:45.233882+00', '2026-05-21 02:18:45.233882+00', NULL, 'c0835485-6077-4f9c-aeee-0285f86dcdc2');


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
	('cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '202611111', 'Roise Samuel Martinez', 'highschool', 'cavite science high school', 'user', '2026-05-18 12:17:37.014686+00', '09123456789'),
	('2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '202622222', 'Lloyd Vergara', 'city', 'alfonso', 'user', '2026-05-19 01:18:56.794604+00', '09159296144'),
	('e4b94146-ffdb-419b-b7b1-f40183c361bb', '202610123', 'Gerard Jariel', 'pet', 'popo', 'user', '2026-05-19 01:31:16.45039+00', '12345678900'),
	('fce248b1-08c8-45be-8be8-0b17d815ce14', '251011821', 'Zeto Riego de dios Cabahug', 'highschool', 'ercihs', 'admin', '2026-05-19 01:32:04.819867+00', '12345678901');


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."items" ("id", "reporter_id", "title", "description", "category", "location_found", "status", "image_url", "created_at", "pickup_location", "claimed_at", "is_archived_by_finder") VALUES
	('9444ab22-f289-4e5b-9fe1-7c95a47c1812', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', 'Phone', 'neu roses', 'Electronics', 'DIT Lobby', 'claimed', 'http://127.0.0.1:54321/storage/v1/object/public/item-images/1779328604433.png', '2026-05-21 01:56:45.172571+00', 'DIT Guardhouse', '2026-05-21 02:13:16.402522+00', true);


--
-- Data for Name: claims; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."claims" ("id", "item_id", "claimer_id", "proof_text", "claim_status", "created_at", "claimant_contact", "finder_confirmed", "claimant_confirmed", "approved_at", "is_archived_by_claimer") VALUES
	('718c8bc7-b074-44bb-8c87-9bcdc2a59db5', '9444ab22-f289-4e5b-9fe1-7c95a47c1812', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', 'everytime i think about that fateful day', 'approved', '2026-05-21 02:02:10.422137+00', '09123456789', true, true, '2026-05-21 02:12:34.556+00', true);


--
-- Data for Name: enrolled_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."enrolled_students" ("student_id", "full_name") VALUES
	('202610123', 'Gerard Jariel'),
	('251011821', 'Zeto Riego de dios Cabahug'),
	('202611111', 'Roise Samuel Martinez'),
	('202622222', 'Lloyd Vergara');


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
	('ba236871-55ff-4071-92cf-d568fe96575f', 'item-images', '1778744334916.jpg', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '2026-05-14 07:38:56.417581+00', '2026-05-14 07:38:56.417581+00', '2026-05-14 07:38:56.417581+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-14T07:38:56.378Z", "contentLength": 106873, "httpStatusCode": 200}', '477be9a7-1b00-470f-887c-3a5654bccb9d', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '{}'),
	('f9b463b3-eb51-47c6-82d0-ffffa1c8e09b', 'item-images', '1778902137414.png', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '2026-05-16 03:28:58.513555+00', '2026-05-16 03:28:58.513555+00', '2026-05-16 03:28:58.513555+00', '{"eTag": "\"65eb0e7bc578c6ba3eb17419b89e32f7\"", "size": 17333, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-16T03:28:58.470Z", "contentLength": 17333, "httpStatusCode": 200}', '498e45b0-61db-43f0-abbe-127c570520ca', '7cb5831c-e9bd-4c87-804d-2b4c4c60737c', '{}'),
	('2f4ff978-1c31-42cc-865b-8f38eb05d4c1', 'item-images', '1779108278674.jpg', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '2026-05-18 12:44:39.399142+00', '2026-05-18 12:44:39.399142+00', '2026-05-18 12:44:39.399142+00', '{"eTag": "\"79947d03610ad63150e432edd9ab7af0\"", "size": 68468, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-18T12:44:39.374Z", "contentLength": 68468, "httpStatusCode": 200}', '7cb4bece-54cb-4253-8cbd-419bbb7d6512', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{}'),
	('3dab29cc-17eb-4df5-a555-6a1bb1d42e87', 'item-images', '1779153666078.jpg', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '2026-05-19 01:21:06.29456+00', '2026-05-19 01:21:06.29456+00', '2026-05-19 01:21:06.29456+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-19T01:21:06.278Z", "contentLength": 106873, "httpStatusCode": 200}', '86a6cd3c-2a31-42b3-b2b7-9fe6a9a45abc', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '{}'),
	('699f2aa2-5166-4ed7-bcba-2bc780d4ae6d', 'item-images', '1779154233898.png', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '2026-05-19 01:30:33.943623+00', '2026-05-19 01:30:33.943623+00', '2026-05-19 01:30:33.943623+00', '{"eTag": "\"54f69c1ba43bace88eeb214a99c3278a\"", "size": 29110, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-19T01:30:33.936Z", "contentLength": 29110, "httpStatusCode": 200}', '8277cd08-7cf5-4568-a3e2-edd8a2e7950a', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{}'),
	('6c8ac185-c23b-44a4-ae91-4e86771bd719', 'item-images', '1779285934090.png', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '2026-05-20 14:05:35.138187+00', '2026-05-20 14:05:35.138187+00', '2026-05-20 14:05:35.138187+00', '{"eTag": "\"65eb0e7bc578c6ba3eb17419b89e32f7\"", "size": 17333, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:05:35.115Z", "contentLength": 17333, "httpStatusCode": 200}', '4ca10f51-052b-4d16-9d77-cfabddf72dd2', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{}'),
	('aa730241-4abc-4618-a460-70888b76220c', 'item-images', '1779285964764.jpg', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '2026-05-20 14:06:04.815725+00', '2026-05-20 14:06:04.815725+00', '2026-05-20 14:06:04.815725+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:06:04.808Z", "contentLength": 106873, "httpStatusCode": 200}', '58800e3e-bde0-4437-9a5c-a2f093d4d4f5', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{}'),
	('b81f4698-153e-4484-90b3-dc5fe1f623dd', 'item-images', '1779286001055.png', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '2026-05-20 14:06:41.096079+00', '2026-05-20 14:06:41.096079+00', '2026-05-20 14:06:41.096079+00', '{"eTag": "\"de408451139b5e1963af47251a346aac\"", "size": 171015, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:06:41.088Z", "contentLength": 171015, "httpStatusCode": 200}', '5dbf9e45-122b-4340-bbc9-eee9831b3881', 'cbddab80-f2fd-4323-abcd-ce4ed6f54ccd', '{}'),
	('eefd3ce1-9a87-4c57-920b-19f7e886af97', 'item-images', '1779286059444.png', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '2026-05-20 14:07:39.474778+00', '2026-05-20 14:07:39.474778+00', '2026-05-20 14:07:39.474778+00', '{"eTag": "\"bbd494cd341dda005465417a2a86f423\"", "size": 172095, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:07:39.465Z", "contentLength": 172095, "httpStatusCode": 200}', 'bdf939d4-777c-455d-8775-82408041f0ed', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '{}'),
	('84ec1c46-5264-4d48-90cd-fb7d7d428b93', 'item-images', '1779286277457.png', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '2026-05-20 14:11:17.593352+00', '2026-05-20 14:11:17.593352+00', '2026-05-20 14:11:17.593352+00', '{"eTag": "\"2d97e7c5697125fd3a5708432211700a\"", "size": 171404, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:11:17.582Z", "contentLength": 171404, "httpStatusCode": 200}', '24b3d237-2d4a-4f48-bf35-33f5e49bf1ed', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '{}'),
	('797bb11e-d77c-43c0-bd0c-36e4ad990283', 'item-images', '1779286358773.jpg', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '2026-05-20 14:12:38.833684+00', '2026-05-20 14:12:38.833684+00', '2026-05-20 14:12:38.833684+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:12:38.826Z", "contentLength": 106873, "httpStatusCode": 200}', '6fb04c39-7c89-45e5-b157-f83c38991e46', '2b49f2f0-f6b4-41ba-8020-0c42e0e61a5e', '{}'),
	('22d0b279-cb63-4085-9bb7-43c1c3397ee9', 'item-images', '1779286892807.jpg', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '2026-05-20 14:21:32.929758+00', '2026-05-20 14:21:32.929758+00', '2026-05-20 14:21:32.929758+00', '{"eTag": "\"6d007e266edc3b87da40fb78dd523d9c\"", "size": 106873, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:21:32.920Z", "contentLength": 106873, "httpStatusCode": 200}', 'ceb3475b-b971-4fa3-b469-8979924ef580', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '{}'),
	('0d6a4aee-8f78-4a0a-a678-3386a8d18d4e', 'item-images', '1779286916445.png', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '2026-05-20 14:21:56.490835+00', '2026-05-20 14:21:56.490835+00', '2026-05-20 14:21:56.490835+00', '{"eTag": "\"54f69c1ba43bace88eeb214a99c3278a\"", "size": 29110, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-20T14:21:56.484Z", "contentLength": 29110, "httpStatusCode": 200}', '8090a7fb-82d4-4935-92f6-1c7f11a25bf2', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '{}'),
	('ede45d6d-7346-4b9b-97b2-a91bb23a5e40', 'item-images', '1779328604433.png', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '2026-05-21 01:56:45.07442+00', '2026-05-21 01:56:45.07442+00', '2026-05-21 01:56:45.07442+00', '{"eTag": "\"54f69c1ba43bace88eeb214a99c3278a\"", "size": 29110, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-05-21T01:56:45.021Z", "contentLength": 29110, "httpStatusCode": 200}', '1ff311ef-615c-4fdd-b24b-0833178f0ca6', 'e4b94146-ffdb-419b-b7b1-f40183c361bb', '{}');


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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 168, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict WwZY8wm96CyVyo91gThFFVkffS4oBiCYbxDXHwYdjnvgAZfv3UUZkfcINuvqCQW

RESET ALL;
