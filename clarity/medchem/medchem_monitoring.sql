-- decomp progress
select processed,count(*)
from tb_medchem_scaffold

group by processed


select processed,count(*)
from tb_medchem_scaffold
where inchikeymurckoscaffold in (select inchikeymurckoscaffold from
(SELECT tb_medchem_scaffold.inchikeymurckoscaffold,count(*) nmols
			 FROM public.tb_medchem_scaffold inner join tb_medchem_molecule on (tb_medchem_scaffold.inchikeymurckoscaffold= tb_medchem_molecule.inchikeymurckoscaffold)
			 
			 group by tb_medchem_scaffold.inchikeymurckoscaffold  
			 having count(*)>=1 and count(*) <=1000) t)
group by processed

select * from tb_medchem_scaffold 

where processed='props_computed'

select inchikeymurckoscaffold,count(*) from tb_medchem_molecule where inchikeymurckoscaffold in
(select inchikeymurckoscaffold
from tb_medchem_scaffold
where processed<>'props_computed')
group by inchikeymurckoscaffold
order by count(*) desc
limit 100



select inchikeymurckoscaffold,count(*) from tb_medchem_molecule where inchikeymurckoscaffold in
(select inchikeymurckoscaffold
from tb_medchem_scaffold
where processed='props_computed')
group by inchikeymurckoscaffold

select inchikeymurckoscaffold,count(*) from tb_medchem_molecule where inchikeymurckoscaffold in
(select inchikeymurckoscaffold
from tb_medchem_scaffold
where inchikeymurckoscaffold in ('FCNWJJNAXVYXAH-UHFFFAOYSA-N','PIGJYCFPOKYNLL-UHFFFAOYSA-N','VRYWBMTXKFQBCA-UHFFFAOYSA-N'))
group by inchikeymurckoscaffold


SELECT tb_chemical_space.*
			 FROM tb_chemical_space inner join tb_medchem_molecule on (tb_chemical_space.inchikey= tb_medchem_molecule.inchikey)
			 
			where tb_medchem_molecule.inchikeymurckoscaffold='UHOVQNZJYSORNB-UHFFFAOYSA-N'


SELECT tb_medchem_scaffold.inchikeymurckoscaffold,count(*) nmols
FROM public.tb_medchem_scaffold inner join tb_medchem_molecule on (tb_medchem_scaffold.inchikeymurckoscaffold= tb_medchem_molecule.inchikeymurckoscaffold)
			 
group by tb_medchem_scaffold.inchikeymurckoscaffold  
having count(*)>=1000 and count(*) <=10000000
order by nmols desc


SELECT pg_stat_activity.datname, pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
and datname='thebe_40_final6' 
ORDER BY datname,query_start desc;



--ALTER TABLE public.tb_medchem_scaffold ADD coremol mol NULL;
--
--
--update tb_medchem_scaffold
--set processed='props_computed'
--where processed <>'props_computed'
--
--
--update tb_medchem_scaffold
--set processed='props_computed'
--where processed <>'props_computed'


