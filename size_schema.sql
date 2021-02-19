CREATE OR REPLACE FUNCTION pg_schema_size(text) returns bigint AS $$
select sum(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint from pg_tables where schemaname = $1
$$ language sql;

exitcreate view public.schema_size  as
SELECT schema_name, 
       sum(table_size)  siz,
       (sum(table_size) / database_size) * 100
FROM (
  SELECT pg_catalog.pg_namespace.nspname as schema_name,
         pg_relation_size(pg_catalog.pg_class.oid) as table_size,
         sum(pg_relation_size(pg_catalog.pg_class.oid)) over () as database_size
  FROM   pg_catalog.pg_class
     JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
GROUP BY schema_name, database_size
order by siz desc




CREATE OR REPLACE VIEW public.size_db
AS SELECT d.datname AS name,
    pg_get_userbyid(d.datdba) AS owner,
        CASE
            WHEN has_database_privilege(d.datname::text, 'CONNECT'::text) THEN pg_size_pretty(pg_database_size(d.datname))
            ELSE 'No Access'::text
        END AS size,
    t.spcname AS "Tablespace"
   FROM pg_database d
     JOIN pg_roles r ON d.datdba = r.oid
     JOIN pg_tablespace t ON d.dattablespace = t.oid
  ORDER BY (
        CASE
            WHEN has_database_privilege(d.datname::text, 'CONNECT'::text) THEN pg_database_size(d.datname)
            ELSE NULL::bigint
        END) DESC
 LIMIT 20;