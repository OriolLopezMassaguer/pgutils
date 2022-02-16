CREATE OR REPLACE FUNCTION pg_schema_size(text) returns bigint AS $$
select sum(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint from pg_tables where schemaname = $1
$$ language sql;

create or replace view public.schema_size  as
(SELECT schema_name, 
       round(sum(table_size)/1000000000) schema_size,
       round((sum(table_size) / database_size) * 100) schema_size_percentage
FROM (
  SELECT pg_catalog.pg_namespace.nspname as schema_name,
         pg_relation_size(pg_catalog.pg_class.oid) as table_size,
         sum(pg_relation_size(pg_catalog.pg_class.oid)) over () as database_size
  FROM   pg_catalog.pg_class
     JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
GROUP BY schema_name, database_size
order by schema_size desc)
UNION ALL
(SELECT 'all', 
       round(sum(table_size)/1000000000) schema_size,
       (sum(table_size) / database_size) * 100 schema_size_percentage
FROM (
  SELECT pg_catalog.pg_namespace.nspname as schema_name,
         pg_relation_size(pg_catalog.pg_class.oid) as table_size,
         sum(pg_relation_size(pg_catalog.pg_class.oid)) over () as database_size
  FROM   pg_catalog.pg_class
     JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
GROUP BY database_size
)order by schema_size desc;





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
 


CREATE OR REPLACE VIEW public.schema_size
AS SELECT t.schema_name,
    sum(t.table_size) AS siz,
    sum(t.table_size) / t.database_size * 100::numeric
   FROM ( SELECT pg_namespace.nspname AS schema_name,
            pg_relation_size(pg_class.oid::regclass) AS table_size,
            sum(pg_relation_size(pg_class.oid::regclass)) OVER () AS database_size
           FROM pg_class
             JOIN pg_namespace ON pg_class.relnamespace = pg_namespace.oid) t
  GROUP BY t.schema_name, t.database_size
  ORDER BY (sum(t.table_size)) DESC;