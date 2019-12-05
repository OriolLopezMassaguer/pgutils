---get main names
	
--select distinct
--	mt2.synonym as mainname,
--	mt1.inchikey
--from 
--	tb_molecule_thesaurus mt1 inner join	tb_molecule_thesaurus mt2 on (mt2.inchikey = mt1.inchikey)
--where 
--  mt2.is_main_name 
--	


drop table if exists chk_synonyms_molecules;
create table chk_synonyms_molecules  (
	reason text NULL,
	inchikey text NOT null,
	mainname text not null,
	synonym text not null,
	synonym_type text not null,
	length int8 not null
);

insert into chk_synonyms_molecules
select 
	'all_not_alfanumeric' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name
	and mt.synonym   ~ '^[^a-zA-Z0-9]*$';
	

	
insert into chk_synonyms_molecules
select 
	'small_synonyms' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name
	and length(mt.synonym) <10
	order by length(mt.synonym) asc;
	


insert into chk_synonyms_molecules
select 
	'units_in_synonym' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '.*/ml.*' or
			mt.synonym  ~ '.*ml/.*' or
			mt.synonym  ~ '.*/mg.*' or
			mt.synonym  ~ '.*mg/.*' or
			mt.synonym  ~ '.*/l.*' or
			mt.synonym  ~ '.*l/.*' or
			mt.synonym  ~ '.*/gm.*' or
			mt.synonym  ~ '.*gm/.*'
		);

insert into chk_synonyms_molecules
select 
	'unmatched_brackets' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '.*\[.*' 
			and not mt.synonym  ~ '.*\].*' 
		);

insert into chk_synonyms_molecules		
select 
	'unmatched_parentheses' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '.*\(.*' 
			and not mt.synonym  ~ '.*\).*' 
		);
	
	
insert into chk_synonyms_molecules		
select 
	'percentage_in_synonym' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '.*%.*' 
		);

insert into chk_synonyms_molecules		
select 
	'comma_point_begin_end' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '^,.*$' or 
			mt.synonym  ~ '^\..*$' or 
			mt.synonym  ~ '^.*,$' or 
			mt.synonym  ~ '^.*\.$' 
		);
	
insert into chk_synonyms_molecules		
	
select 
	'double_quotes' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and 
		(
			mt.synonym  ~ '.*".*' 
		);
	
	
create table chk_synonym_prefixes as 	
select 
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym synonym_prefix,
	mt3.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2,
	tb_molecule_thesaurus mt3
where  
	mt2.inchikey = mt.inchikey
	and mt2.inchikey=mt3.inchikey
	and mt2.is_main_name 
	and mt3.synonym like mt.synonym || '%'
	and length(mt3.synonym) >length(mt.synonym);

--select * from tb_umls
--where tb_umls.main_term  ~ '.*\..*' 

insert into chk_synonyms_molecules
select 
	'repeated_synonims' reason,
	mt.inchikey, 
	mt2.synonym as mainname,
	mt.synonym,
	mt.synonym_type,
	length(mt.synonym)
from 
	tb_molecule_thesaurus mt,
	tb_molecule_thesaurus mt2
where  
	mt2.inchikey = mt.inchikey
	and mt2.is_main_name 
	and mt.synonym in
		(select synonym from (select mt.synonym, count(*)
		from 	tb_molecule_thesaurus mt
		group by mt.synonym
		having count(*)>1) t)

-- supress EC synonims
select * 
from tb_target_thesaurus t
where t.target_synonym  ~ '^[0-9a-zA-Z\-]+\.[0-9a-zA-Z\-]+\.[0-9a-zA-Z\-]+\.[0-9A-Za-zA-Z\-]+$'


