--drop table IF EXISTS chk_tb_chemical_space_check;
--drop table if EXISTS chk_tb_chemical_space_summary;
--drop table if EXISTS chk_molecules_by_space;
--drop table IF EXISTS chk_tb_molecule_thesaurus_main_name_vs_tb_chemical_space_name;
--drop table IF EXISTS chk_tb_molecule_thesaurus_without_main_name;
--drop table IF EXISTS chk_faers_umls_not_in_tb_umls;



update tb_medchem_molecule
set image_substituents = null 
where status='failed';

update tb_chemical_space set molrdkit_all = null;

update tb_medchem_molecule 
set
	is2=null,
	status=null,
	welded_mol=null,
	sizer=null;


delete from tb_medchem_molecule
where inchikey in (
		select inchikey
		from tb_medchem_molecule 
		where (SELECT COUNT(*) FROM jsonb_object_keys(decomp)) =0 or decomp is null
);

update tb_medchem_scaffold 
set
	coremol=null,
	processed=null,
	sizer=null;


--SELECT count(*) from tb_medchem_molecule WHERE inchikey NOT IN (SELECT inchikey FROM tb_chemical_space)