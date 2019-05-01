create extension if not exists rdkit;
create schema rdk;
select * into rdk.mols from (select molregno,mol_from_ctab(molfile::cstring) m  from compound_structures) tmp where m is not null;
create index molidx on rdk.mols using gist(m);
alter table rdk.mols add primary key (molregno);

select count(*) from rdk.mols where m@>'c1cccc2c1nncc2';