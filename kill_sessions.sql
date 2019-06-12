SELECT client_addr::text,
   *
FROM 
    pg_stat_activity 
WHERE 
     datname = 'thebe_40_final1'
     and client_addr::text='10.3.117.15/32'



SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    pid <> pg_backend_pid()
     and datname = 'thebe_40_final1'
     and client_addr::text='10.3.117.15/32'
     
     
     select * from pg_stat_progress_vacuum

   
  SELECT pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' and datname = 'thebe_dev_40_ce' 
ORDER BY query_start desc;

select imagescaffold, inchikeymurckoscaffold, imagescaffold_resized from tb_medchem_scaffold 
where imagescaffold_resized is not null


select count(*) from tb_medchem_scaffold where imagescaffold is not null and imagescaffold_resized is  null

select count(*) from tb_medchem_scaffold where imagescaffold is not null

limit 10

select  count(*)  from tb_medchem_scaffold where imagescaffold is not null


ALTER TABLE public.tb_medchem_molecule ADD sizer int NULL;

ALTER TABLE public.tb_medchem_scaffold ADD sizer int NULL;

UPDATE tb_medchem_scaffold SET processed = null,sizer = 5 where inchikeymurckoscaffold= ''

from tb_medchem_scaffold where molrdkit is not null
limit 10