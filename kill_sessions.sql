SELECT client_addr::text,state,query,state,
   *
FROM 
    pg_stat_activity 
WHERE 
     datname in ('thebe_50_intn') 
--     and application_name ='pg_restore'
--   and client_addr IN ('10.9.89.228/32')
order by state asc
     

SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    pid <> pg_backend_pid()
    and datname in ('thebe_50_intn')


SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes'
--and state!='idle';



     

     
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
                            
                            
                            
insert into chk_ent_target
select et.target_id ,'no main name in thesaurus'
from ent_target et 
where not exists 
(
select null
from ent_thesaurus et2 
where et2.entity_id = et.target_id 
and et2.is_main_name
and et2.entity_type ='target'
)