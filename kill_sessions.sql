SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'thebe_dev_30';
    
    
--     SELECT 
--    *
-- FROM 
--     pg_stat_activity 
-- WHERE 
--     -- don't kill my own connection!
--     pid <> pg_backend_pid()
--     -- don't kill the connections to other databases
--     AND datname = 'thebe_dev_30'
--     and client_addr='10.3.117.15'

SELECT 
   *
FROM 
    pg_stat_activity 
WHERE datname = 'thebe_dev_30';