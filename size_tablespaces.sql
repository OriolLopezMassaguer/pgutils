SELECT spcname, pg_size_pretty(pg_tablespace_size(spcname)) FROM pg_tablespace; 
