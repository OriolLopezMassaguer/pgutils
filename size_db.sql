SELECT d.datname AS Name,  pg_catalog.pg_get_userbyid(d.datdba) AS Owner,
    CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
        THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))
        ELSE 'No Access'
    END AS size,
    t.spcname as "Tablespace"
FROM pg_catalog.pg_database d
 JOIN pg_catalog.pg_roles r ON d.datdba = r.oid
  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid
    ORDER BY
    CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
        THEN pg_catalog.pg_database_size(d.datname)
        ELSE NULL
    END DESC -- nulls first
    LIMIT 20;
   
   
   
    
