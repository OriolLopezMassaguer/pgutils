SELECT d.datname as "Name",
       r.rolname as "Owner",
       t.spcname as "Tablespace",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding",
       pg_catalog.shobj_description(d.oid, 'pg_database') as "Description"       
FROM pg_catalog.pg_database d
  JOIN pg_catalog.pg_roles r ON d.datdba = r.oid
  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid
ORDER BY 1;

