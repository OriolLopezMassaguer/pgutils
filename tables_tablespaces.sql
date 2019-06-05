SELECT d.datname as "Name",
       r.rolname as "Owner",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding",
       pg_catalog.shobj_description(d.oid, 'pg_database') as "Description",
       t.spcname as "Tablespace"
FROM pg_catalog.pg_database d
  JOIN pg_catalog.pg_roles r ON d.datdba = r.oid
  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid
ORDER BY t.spcname, d.datname



--ALTER DATABASE thebe_dev_40_ce SET TABLESPACE main_disk;

SELECT temp_files AS "Temporary files"
     , temp_bytes AS "Size of temporary files",db.*
FROM   pg_stat_database db;


CREATE TABLESPACE ssd LOCATION '/pgdata';

select spcname
      ,pg_tablespace_location(oid) 
from   pg_tablespace;