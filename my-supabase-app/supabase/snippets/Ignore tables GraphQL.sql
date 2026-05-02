-- Tell the GraphQL extension to ignore these tables
comment on table public.profiles is '@graphql({"enabled": false})';
comment on table public.items is '@graphql({"enabled": false})';
comment on table public.claims is '@graphql({"enabled": false})';