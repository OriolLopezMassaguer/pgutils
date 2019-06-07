drop table IF EXISTS chk_tb_chemical_space_check;


create table chk_tb_chemical_space_check  (
	reason text NULL,
	inchikey text NOT NULL
);

insert into chk_tb_chemical_space_check select 'drug_nomol' reason, inchikey from tb_chemical_space where spaces@>array['DRUGS'] and molrdkit is null;
insert into chk_tb_chemical_space_check select 'cosmetics_nomol' reason, inchikey from tb_chemical_space where spaces@>array['COSMETICS'] and molrdkit is null;
insert into chk_tb_chemical_space_check select 'life_stock_nomol' reason, inchikey from tb_chemical_space where spaces@>array['LIFE_STOCK'] and molrdkit is null;
insert into chk_tb_chemical_space_check select 'life_tangible_nomol' reason, inchikey from tb_chemical_space where spaces@>array['LIFE_TANGIBLE'] and molrdkit is null;
insert into chk_tb_chemical_space_check select 'name_null' reason, inchikey from tb_chemical_space where name is null; --CHECK NAME EMPTY
insert into chk_tb_chemical_space_check select 'name_empty' reason, inchikey from tb_chemical_space where name =''; -- empty string name
insert into chk_tb_chemical_space_check select 'molfile_null' reason, inchikey from tb_chemical_space where molfile is null;
insert into chk_tb_chemical_space_check select 'molfile_empty' reason, inchikey from tb_chemical_space where molfile='';
insert into chk_tb_chemical_space_check select 'molfile_no_first_line' reason, inchikey from tb_chemical_space where (regexp_split_to_array(molfile, E'\\n'))[1]='';
insert into chk_tb_chemical_space_check select 'molfile_first_line_diff_name' reason, inchikey from tb_chemical_space where (regexp_split_to_array(molfile, E'\\n'))[1]!="name";
insert into chk_tb_chemical_space_check select 'molfile_last_line_nodollars' reason, inchikey from tb_chemical_space where (regexp_split_to_array(molfile, E'\\n'))[(array_length(regexp_split_to_array(molfile, E'\\n'),1)-1)]!='$$$$';
insert into chk_tb_chemical_space_check select 'small_image' reason, inchikey from tb_chemical_space where octet_length(image) <=2000;
insert into chk_tb_chemical_space_check select 'no_image' reason, inchikey from tb_chemical_space where image is null;

drop table IF EXISTS chk_tb_chemical_space_summary;

create table chk_tb_chemical_space_summary as 
select reason, count(*)
from chk_tb_chemical_space_check
group by reason;


-- count molecules by space
drop table IF EXISTS chk_molecules_by_space;
create table chk_molecules_by_space as
select count(*), unnest(spaces) space
from tb_chemical_space 
group by unnest(spaces);

--check molecules with different name in chemical space and thesaurus
drop table IF EXISTS chk_tb_molecule_thesaurus_main_name_vs_tb_chemical_space_name;
create table chk_tb_molecule_thesaurus_main_name_vs_tb_chemical_space_name as
select cs.name, mt.synonym, cs.inchikey from tb_molecule_thesaurus mt,tb_chemical_space cs
where mt.is_main_name = true and cs.inchikey = mt.inchikey and cs."name"!= mt.synonym;

--check molecules without main name
drop table IF EXISTS chk_tb_molecule_thesaurus_without_main_name;
create table chk_tb_molecule_thesaurus_without_main_name as
select inchikey from tb_molecule_thesaurus where inchikey not in (select inchikey from tb_molecule_thesaurus where is_main_name=true);

--check umls in faers but not in tb_umls
drop table IF EXISTS chk_faers_umls_not_in_tb_umls;
create table chk_faers_umls_not_in_tb_umls as
select distinct umls from tb_ctfaers_event_summary where umls not in (select umls from tb_umls);

--select array_length(regexp_split_to_array(source_id, '\|'),1),length(source_id),source_id 
--from tb_tlink_chemical_space where inchikey='SHGAZHPCJJPHSC-UHFFFAOYSA-N'

--drop table tb_medchem_molecule;