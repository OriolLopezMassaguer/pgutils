SELECT 
   *
FROM 
    pg_stat_activity 
WHERE 
     datname = 'thebe_40_milestone2'



SELECT 
    pg_terminate_backend(81574) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'thebe_40_milestone2'
    and application_name like '%JDBC%'

   
  SELECT pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' and datname = 'thebe_dev_40_ce' 
ORDER BY query_start desc;

select imagescaffold, inchikeymurckoscaffold, imagescaffold_resized from tb_medchem_scaffold 
where imagescaffold_resized is not null


select count(*) from tb_medchem_scaffold where imagescaffold is not null and imagescaffold_resized is  null

select count(*) from tb_medchem_scaffold where imagescaffold is not null

limit 10

create view scaffold_export as
select molrdkit, inchikeymurckoscaffold


ALTER TABLE public.tb_medchem_molecule ADD sizer int NULL;

ALTER TABLE public.tb_medchem_scaffold ADD sizer int NULL;

UPDATE tb_medchem_scaffold SET processed = null,sizer = 5 where inchikeymurckoscaffold= ''

from tb_medchem_scaffold where molrdkit is not null
limit 10