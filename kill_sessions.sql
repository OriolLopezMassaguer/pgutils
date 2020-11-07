SELECT client_addr::text,state,query,
   *
FROM 
    pg_stat_activity 
WHERE 
     datname in ('thebe_50_dev')
--   and client_addr::text='10.3.117.63/32'
     

SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    pid <> pg_backend_pid()
    and datname in ('thebe_50_dev')
     

     
     and client_addr::text='10.3.117.63/32'
     
     

   
  SELECT pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' and datname = 'thebe_dev_40_ce' 
ORDER BY query_start desc;

  SELECT pid, application_name, to_char((clock_timestamp() - query_start), 'HH24 hrs MI "minutes" SS "seconds"'), usename, query 
FROM pg_stat_activity 
where application_name like 'IO.%'
order by application_name asc,age(clock_timestamp(), query_start) desc


SELECT pid
                         , application_name
                          , to_char((clock_timestamp() - query_start), 'HH24 hrs MI "minutes" SS "seconds"     '),
                          usename , query FROM pg_stat_activity 
                            where application_name like 'IO.%' and query  not like '%pg_stat_activity%'


                            select count(*) from  tb_ctfaers_drug2event tcde 