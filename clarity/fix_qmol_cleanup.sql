--drop table tb_medchem_scaffold;
--alter table tb_medchem_scaffold_nocore rename to tb_medchem_scaffold;
--drop table tb_medchem_molecule_final;
--alter table tb_medchem_molecule_final rename to tb_medchem_molecule;
--
--insert into tb_medchem_scaffold
--select * from tb_medchem_scaffold_nocore
--
--truncate table tb_medchem_molecule;
--insert into tb_medchem_molecule
--select inchikey,inchikeymurckoscaffold,decomp,null,null,null,image_substituents 
--from tb_medchem_molecule_final;

ALTER TABLE tb_medchem_molecule DROP COLUMN is2;
ALTER TABLE tb_medchem_molecule DROP COLUMN status;
ALTER TABLE tb_medchem_molecule DROP COLUMN welded_mol;
ALTER TABLE tb_medchem_molecule DROP COLUMN sizer;


ALTER TABLE tb_medchem_scaffold DROP COLUMN processed;
ALTER TABLE tb_medchem_scaffold DROP COLUMN sizer;
ALTER TABLE tb_medchem_scaffold DROP COLUMN coremol2;
ALTER TABLE tb_medchem_scaffold DROP COLUMN coremol;

update tb_chemical_space 
set molrdkit_all=null;