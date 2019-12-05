create or replace view tb_medchem_scaffold_unpivot_source
as 
	select distinct tb_medchem_scaffold_props.*, 'drugs' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['DRUGS']
	union all
	select distinct tb_medchem_scaffold_props.*, 'tset' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['SLINK_TRAINING_SET','TLINK_TRAINING_SET']
	union all
	select distinct tb_medchem_scaffold_props.*, 'faers' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY['FAERS']
	union all
	select distinct tb_medchem_scaffold_props.*, 'vendors' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces && ARRAY(select space_id from tb_space where is_provider)	
	union all
	select distinct tb_medchem_scaffold_props.*, 'LIFE_CHEMICAL' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces @> array['LIFE_CHEMICAL']
		union all
	select distinct tb_medchem_scaffold_props.*, 'TARGETMOL' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces @> array['TARGETMOL']
		union all
	select distinct tb_medchem_scaffold_props.*, 'CHEMBRIDGE' as molset
	from tb_medchem_scaffold_props ,tb_medchem_molecule, tb_chemical_space 
	where tb_medchem_scaffold_props.inchikeymurckoscaffold =tb_medchem_molecule.inchikeymurckoscaffold 
	and tb_medchem_molecule.inchikey= tb_chemical_space.inchikey 
	and tb_chemical_space.spaces @> array['CHEMBRIDGE']
	;