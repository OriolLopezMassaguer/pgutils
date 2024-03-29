create or replace view public.size_tables as 
SELECT 	
	table_schema,
	table_name,
	round(total_bytes::numeric / 1073741824::numeric,2) total_size,
	round(index_bytes::numeric / 1073741824::numeric,2) AS index_size,    
    round(table_bytes::numeric / 1073741824::numeric,2) AS table_size
  FROM (
  SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes FROM (
      SELECT c.oid,nspname AS table_schema, relname AS TABLE_NAME
              , c.reltuples AS row_estimate
              , pg_total_relation_size(c.oid) AS total_bytes
              , pg_indexes_size(c.oid) AS index_bytes
              , pg_total_relation_size(reltoastrelid) AS toast_bytes
          FROM pg_class c
          LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
          WHERE relkind = 'r' 
  ) a
) a 
where table_name not like 'pg_%'




create or replace function 
count_rows(schema text, tablename text) returns integer
as
$body$
declare
  result integer;
  query varchar;
begin
  query := 'SELECT count(1) FROM ' || schema || '.' || tablename;
  execute query into result;
  return result;
end;
$body$
language plpgsql;





select 
  table_schema,
  table_name,
  count_rows(table_schema, table_name)
from information_schema.tables
where 
  table_schema not in ('pg_catalog', 'information_schema') 
  --and table_schema  in ('aers_raw') 
  and table_type='BASE TABLE'

















   
    SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_relation_size(C.oid)) AS "size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
  and relname like '%tb_chemical_space%'
  ORDER BY pg_relation_size(C.oid) DESC
  LIMIT 20;

SELECT
  pgClass.relname   AS tableName,
  pgClass.reltuples AS rowCount
FROM
  pg_class pgClass
LEFT JOIN
  pg_namespace pgNamespace ON (pgNamespace.oid = pgClass.relnamespace)
WHERE
  pgNamespace.nspname NOT IN ('pg_catalog', 'information_schema') AND
  pgClass.relkind='r'
order by tableName;



