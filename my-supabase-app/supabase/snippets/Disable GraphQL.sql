-- Explicitly disable GraphQL for the main tables
COMMENT ON TABLE public.items IS '@graphql({"enabled": false})';
COMMENT ON TABLE public.profiles IS '@graphql({"enabled": false})';
COMMENT ON TABLE public.claims IS '@graphql({"enabled": false})';