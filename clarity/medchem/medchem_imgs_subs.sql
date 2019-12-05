create table a_scaffolds_mols_subs_count 
as SELECT  inchikeymurckoscaffold,count(*) 
FROM tb_medchem_molecule 
where image_substituents is not null
group by inchikeymurckoscaffold;
CREATE INDEX  ON public.a_scaffolds_mols_subs_count (inchikeymurckoscaffold);


create table a_scaffolds_mols_all_count 
as SELECT  inchikeymurckoscaffold,count(*) 
FROM tb_medchem_molecule 
group by inchikeymurckoscaffold;

CREATE index  ON public.a_scaffolds_mols_all_count (inchikeymurckoscaffold);

drop table  a_scaffolds_with_molecules_highlighted;
create table a_scaffolds_with_molecules_highlighted as 
select 	
	a_scaffolds_mols_subs_count.inchikeymurckoscaffold,a_scaffolds_mols_subs_count.count
from 
	a_scaffolds_mols_subs_count inner join	a_scaffolds_mols_all_count 
	on (a_scaffolds_mols_subs_count.inchikeymurckoscaffold = a_scaffolds_mols_all_count.inchikeymurckoscaffold and a_scaffolds_mols_subs_count.count=a_scaffolds_mols_all_count.count ) 
where a_scaffolds_mols_subs_count.count>=10  and a_scaffolds_mols_subs_count.count<=20
limit 1000


select inchikeymurckoscaffold,image_substituents from tb_medchem_molecule
where tb_medchem_molecule.inchikeymurckoscaffold 
in (select inchikeymurckoscaffold from a_scaffolds_with_molecules_highlighted)
order by inchikeymurckoscaffold asc


