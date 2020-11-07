CREATE OR REPLACE FUNCTION pg_schema_size(text) returns bigint AS $$
select sum(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint from pg_tables where schemaname = $1
$$ language sql;


SELECT schema_name, 
       sum(table_size),
       (sum(table_size) / database_size) * 100
FROM (
  SELECT pg_catalog.pg_namespace.nspname as schema_name,
         pg_relation_size(pg_catalog.pg_class.oid) as table_size,
         sum(pg_relation_size(pg_catalog.pg_class.oid)) over () as database_size
  FROM   pg_catalog.pg_class
     JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
GROUP BY schema_name, database_size