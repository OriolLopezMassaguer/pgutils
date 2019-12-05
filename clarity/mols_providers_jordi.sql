select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['LIFE_CHEMICAL']
--1212562

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['LIFE_STOCK']
--469140

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['LIFE_TANGIBLE']
--744126

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['CHEMBRIDGE']

select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and cs.spaces @>array['TARGETMOL']


select count(*) 
from tb_medchem_scaffold sca, tb_medchem_molecule mcm, tb_chemical_space cs 
where sca.inchikeymurckoscaffold=mcm.inchikeymurckoscaffold 
and cs.inchikey=mcm.inchikey
and (cs.spaces @>array['TARGETMOL']
or  cs.spaces @>array['CHEMBRIDGE']
or cs.spaces @>array['LIFE_CHEMICAL'])

select * from tb_panel where panel_code like 'HQ%'


