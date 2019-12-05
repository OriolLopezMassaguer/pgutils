select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['TARGETMOL']

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['CHEMBRIDGE']


select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['LIFE_CHEMICAL']



select count(distinct sca.inchikeymurckoscaffold) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['LIFE_CHEMICAL']
--1212562

select count(distinct sca.inchikeymurckoscaffold) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['CHEMBRIDGE']


select count(distinct sca.inchikeymurckoscaffold) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['TARGETMOL']

---- totals

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL']



select count(distinct sca.inchikeymurckoscaffold) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL']


--intersection
-- prov intersection drugs
select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL']
and  cs.spaces @>array['DRUGS']

--prov tset
select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL']
and cs.spaces && array['SLINK_TRAINING_SET','TLINK_TRAINING_SET']


-- tset drugs
select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and  cs.spaces @>array['DRUGS']
and cs.spaces && array['SLINK_TRAINING_SET','TLINK_TRAINING_SET']
and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL']

drop table summary_spaces_venn;
create table summary_spaces_venn as 
with 
	drugs as 
		(select cs.inchikey
		from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
		where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
		and cs.inchikey=mcm.inchikey
		and  cs.spaces @>array['DRUGS']),
	tset as 
		(select cs.inchikey 
		from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
		where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
		and cs.inchikey=mcm.inchikey
		and cs.spaces && array['SLINK_TRAINING_SET','TLINK_TRAINING_SET']),
	provs as	
		(select cs.inchikey 
		from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
		where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
		and cs.inchikey=mcm.inchikey		
		and cs.spaces && array['CHEMBRIDGE','TARGETMOL','LIFE_CHEMICAL'])

select count(*),'drugs' from drugs
union all
select count(*),'tset' from tset
union all
select count(*),'provs'  from provs
union all
(	select count(*), 'drugs tset'
	from ((select * from drugs) intersect (select * from tset)) as t)
union all 
(	select count(*), 'provs tset'
	from ((select * from provs) intersect (select * from tset)) as t)
union all 
(	select count(*), 'drugs provs'
	from ((select * from drugs) intersect (select * from provs)) as t)	
	
union all 
(	select count(*), 'drugs provs tset'
	from ((select * from drugs) intersect (select * from provs) intersect (select * from tset)) as t)	
	
