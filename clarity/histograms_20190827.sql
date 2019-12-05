drop view if exists tb_medchem_scaffold_unpivot_source cascade;

create or replace view tb_medchem_scaffold_unpivot_source
as 
	select distinct tb_medchem_scaffold_props.*, 'DRUGS' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['DRUGS']
	union all
	select distinct tb_medchem_scaffold_props.*, 'ANNOTATED_DB' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['SLINK_TRAINING_SET','TLINK_TRAINING_SET']
	union all
	select distinct tb_medchem_scaffold_props.*, 'FAERS' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['FAERS']
	union all
	select distinct tb_medchem_scaffold_props.*, 'PROVIDERS' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY(select space_id from tb_space where is_provider)
	union all
	select distinct tb_medchem_scaffold_props.*, 'LIFE_CHEMICAL' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['LIFE_CHEMICAL']
	union all
	select distinct tb_medchem_scaffold_props.*, 'TARGETMOL' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['TARGETMOL']
	union all
	select distinct tb_medchem_scaffold_props.*, 'CHEMBRIDGE' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['CHEMBRIDGE'];

drop view if exists tb_medchem_scaffold_unpivot;
create view tb_medchem_scaffold_unpivot as 
SELECT t.molset,t.inchikeymurckoscaffold, col_name, col_value
FROM tb_medchem_scaffold_unpivot_source t
,LATERAL (
values 
	('abonds', t.abonds),
	('tbonds', t.tbonds),
	('atoms', t.atoms),
	('bonds', t.bonds),
	('dbonds', t.dbonds),
	('nhba',t.nhba),
	('nhbd',t.nhbd),
	('logp',t.logp),
	('mwt',t.mwt),
	('psa',t.psa),
	('nrings',t.nrings),
	('nrings',t.nrings),
	('nrsys',t.nrsys),
	('nrotors',t.nrotors),
	('sbonds',t.sbonds)	
) s(col_name, col_value);

drop view if exists  tb_medchem_scaffold_props_raw;

create view tb_medchem_scaffold_props_raw as
select up.molset,up.inchikeymurckoscaffold,col_value val,col_name prop, plim.min,plim.max,plim.bins,
width_bucket(col_value,plim.min,plim.max,plim.bins::int) bucket
from tb_medchem_scaffold_unpivot up, tb_props_limit plim 
where up.col_name= plim.prop;

drop view if exists  tb_medchem_scaffold_props_summarized_vw;
create view tb_medchem_scaffold_props_summarized_vw as 
select rw.molset,rw.prop,rw.bucket, count(*) elements_bucket
from tb_medchem_scaffold_props_raw rw
group by rw.molset,rw.prop,rw.bucket;



	drop table tb_medchem_scaffold_props_summarized_max;
	create table tb_medchem_scaffold_props_summarized_max as
		select tr.molset,tr.prop ,max(elements_bucket) max_bucket 
		from tb_medchem_scaffold_props_summarized_vw tr
		group by tr.molset,tr.prop;
		
	drop table tb_medchem_scaffold_props_summarized_normalized;
	
			create table tb_medchem_scaffold_props_summarized_normalized as 
		select sum.*,max.max_bucket,elements_bucket::float/max_bucket::float elems_normalized 
		from tb_medchem_scaffold_props_summarized_vw sum, 
		tb_medchem_scaffold_props_summarized_max max
		where sum.molset= max.molset and sum.prop= max.prop;