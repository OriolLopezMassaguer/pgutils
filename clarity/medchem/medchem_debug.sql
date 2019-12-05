-- tables and views for analysis

DROP VIEW tb_medchem_mols_substituents_unnested_vw;

create or replace view tb_medchem_mols_substituents_unnested_vw as
select mol.inchikeymurckoscaffold, mol.inchikey,deco.*
from 
	tb_medchem_molecule mol ,
	jsonb_each_text(mol.decomp) deco;

drop table tb_medchem_mols_substituents_unnested;
create table tb_medchem_mols_substituents_unnested as select * from tb_medchem_mols_substituents_unnested_vw;


-- get info from scaffold and molecule raw
select scaff.imgscaffoldorig,scaff.imagescaffold,mol.*
from tb_medchem_scaffold scaff, tb_medchem_molecule mol 
where scaff.inchikeymurckoscaffold='VKIHKPYBWMKOSB-UHFFFAOYSA-N'
ans mol.inchikey='CHBQSWCTEAZOMP-UHFFFAOYSA-N'
and scaff.inchikeymurckoscaffold=mol.inchikeymurckoscaffold

--molrdkit info decomp info for molecule
								select 
									decomp,
									mol_to_pkl(scaff.molrdkit) molrdkit_scaff,
									mol_to_pkl(cs.molrdkit_all) molrdkit_all,
									scaff.processed,
									mcm.inchikey,
									scaff.inchikeymurckoscaffold,
									scaff.coremol molrdkit_coremol,
									scaff.sizer
								from tb_medchem_molecule mcm, 
									tb_medchem_scaffold scaff,
									tb_chemical_space cs
								where mcm.inchikeymurckoscaffold = scaff.inchikeymurckoscaffold
								and mcm.decomp is not null
								and scaff.processed is not null
								and mcm.inchikey='CHBQSWCTEAZOMP-UHFFFAOYSA-N'
								and mcm.inchikey=cs.inchikey;
							
-- ing original vs img substituents							
								select  
									cs.molrdkit_all,
									cs.image,
									scaff.sizer,
									mcm.image_substituents,
									mcm.status,
									mcm.decomp,
									mcm.inchikey,									
									scaff.imagescaffold,scaff.imgscaffoldorig,
									scaff.coremol,
									scaff.processed,
									scaff.inchikeymurckoscaffold
								from tb_medchem_molecule mcm, 
									tb_medchem_scaffold scaff,
									tb_chemical_space cs
								where mcm.inchikeymurckoscaffold = scaff.inchikeymurckoscaffold
								--and mcm.decomp is not null
								--and scaff.processed is not null
								--								and scaff.inchikeymurckoscaffold='ATCGJUAWGTXYJY-UHFFFAOYSA-N'
								and mcm.inchikey=cs.inchikey
								and mcm.inchikey='CHBQSWCTEAZOMP-UHFFFAOYSA-N'
 
--unnested decomp for  molecule

								select 
									cs.molrdkit_all,
									cs.image,
									scaff.sizer,
									mcm.image_substituents,
									mcm.status,
									mcm.inchikey,
									mcm.decomp,
									mols_unnested."key",
									mols_unnested.value,
									scaff.imagescaffold,scaff.imgscaffoldorig,
									scaff.coremol,
									scaff.processed,
									scaff.inchikeymurckoscaffold
								from tb_medchem_molecule mcm, 
									tb_medchem_scaffold scaff,
									tb_chemical_space cs,
									tb_medchem_mols_substituents_unnested mols_unnested 
								where mcm.inchikeymurckoscaffold = scaff.inchikeymurckoscaffold
								--and mcm.decomp is not null
								--and scaff.processed is not null
								
								and mcm.inchikey=cs.inchikey
								and mols_unnested.inchikey = mcm.inchikey
--								and scaff.mwt<80 
--								and scaff.sizer=3
								and	 mcm.inchikey='CHBQSWCTEAZOMP-UHFFFAOYSA-N'
--								and scaff.inchikeymurckoscaffold='CTAPFRYPJLPFDF-UHFFFAOYSA-N'

select scaff_rns.inchikeymurckoscaffold ,scaff_rns.sizer, mols_count_rns.inchikey,mols_count_rns.numsubs
from (select un.inchikeymurckoscaffold, un.inchikey, count(*) numsubs
	from tb_medchem_mols_substituents_unnested un
	group by un.inchikey, un.inchikeymurckoscaffold) as mols_count_rns inner join
	(select scaff.inchikeymurckoscaffold,scaff.sizer from tb_medchem_scaffold scaff) as scaff_rns
	on (mols_count_rns.inchikeymurckoscaffold = scaff_rns.inchikeymurckoscaffold)
where mols_count_rns.inchikeymurckoscaffold  in ('AALYNQWBYWIBSV-UHFFFAOYSA-N','MVSOBGYTSOWMLA-UHFFFAOYSA-N','BECYNXSUECSGCX-UHFFFAOYSA-N')
								
-- create script command

create table inchis_mols_command as 	
								select distinct 
									 'python2 MEDCHEM.py imgsubstituents '||mcm.inchikey 
								from tb_medchem_molecule mcm, 
									tb_medchem_scaffold scaff,
									tb_chemical_space cs,
									tb_medchem_mols_substituents_unnested mols_unnested 
								where mcm.inchikeymurckoscaffold = scaff.inchikeymurckoscaffold
								--and mcm.decomp is not null
								--and scaff.processed is not null
								
								and mcm.inchikey=cs.inchikey
								and mols_unnested.inchikey = mcm.inchikey
								--and scaff.mwt<80 
								--and scaff.sizer=3
								--and mcm.inchikey='AEJFIQYNUPXIHE-UHFFFAOYSA-N'
								and scaff.inchikeymurckoscaffold='CTAPFRYPJLPFDF-UHFFFAOYSA-N'
								
								

create table inchis_mols as 	
								select distinct 
									 mcm.inchikey 
								from tb_medchem_molecule mcm, 
									tb_medchem_scaffold scaff,
									tb_chemical_space cs,
									tb_medchem_mols_substituents_unnested mols_unnested 
								where mcm.inchikeymurckoscaffold = scaff.inchikeymurckoscaffold
								--and mcm.decomp is not null
								--and scaff.processed is not null
								
								and mcm.inchikey=cs.inchikey
								and mols_unnested.inchikey = mcm.inchikey
								--and scaff.mwt<80 
								--and scaff.sizer=3
								--and mcm.inchikey='AEJFIQYNUPXIHE-UHFFFAOYSA-N'
								and scaff.inchikeymurckoscaffold='CTAPFRYPJLPFDF-UHFFFAOYSA-N'
								



--select status, count(*) 
--from tb_medchem_molecule
--group by status
--
--select tb_medchem_scaffold.processed, count(*) 
--from tb_medchem_scaffold
--group by processed
--
--
--select count(*)
--from tb_medchem_substituents
--
--
--
--select count(*)
--from
--(SELECT distinct d.value smiles 
--					FROM tb_medchem_molecule
--					JOIN jsonb_each_text(tb_medchem_molecule.decomp) d ON true
--					where decomp is not null) t
--
--
--select scaff_rns.inchikeymurckoscaffold ,scaff_rns.sizer, mols_count_rns.inchikey,mols_count_rns.numsubs
--from (select un.inchikeymurckoscaffold, un.inchikey, count(*) numsubs
--	from tb_medchem_mols_substituents_unnested un
--	group by un.inchikey, un.inchikeymurckoscaffold) as mols_count_rns inner join
--	(select scaff.inchikeymurckoscaffold,scaff.sizer from tb_medchem_scaffold scaff) as scaff_rns
--	on (mols_count_rns.inchikeymurckoscaffold = scaff_rns.inchikeymurckoscaffold)
--where mols_count_rns.inchikeymurckoscaffold  in ('AALYNQWBYWIBSV-UHFFFAOYSA-N','MVSOBGYTSOWMLA-UHFFFAOYSA-N','BECYNXSUECSGCX-UHFFFAOYSA-N')
--



