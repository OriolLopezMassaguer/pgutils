select   spcname,pg_size_pretty ( pg_tablespace_size (spcname))  from pg_tablespace