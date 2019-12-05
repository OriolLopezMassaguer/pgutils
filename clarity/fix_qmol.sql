-- CREATE TABLE tb_medchem_scaffold_nocore (
-- 	molrdkit mol NULL,
-- 	inchikeymurckoscaffold text NOT NULL,
-- 	imagescaffold bytea NULL,
-- 	mwt float8 NULL,
-- 	logp float8 NULL,
-- 	nhba float8 NULL,
-- 	nhbd float8 NULL,
-- 	nrotors float8 NULL,
-- 	nrings float8 NULL,
-- 	psa float8 NULL,
-- 	log_s float8 NULL,
-- 	logbb float8 NULL,
-- 	ppb float8 NULL,
-- 	pgp float8 NULL,
-- 	dbonds float8 NULL,
-- 	nhalo float8 NULL,
-- 	bonds float8 NULL,
-- 	nrsys float8 NULL,
-- 	atoms float8 NULL,
-- 	tbonds float8 NULL,
-- 	abonds float8 NULL,
-- 	sbonds float8 NULL,
-- 	mr float8 NULL,
-- 	csc text NULL,
-- 	imgscaffoldorig bytea NULL,
-- 	processed varchar NULL,
-- 	sizer int4 NULL,
-- 	CONSTRAINT tb_medchem_scaffold_nocore_pkey PRIMARY KEY (inchikeymurckoscaffold)
-- );

-- truncate table tb_medchem_scaffold_nocore;

-- insert into tb_medchem_scaffold_nocore 
-- SELECT molrdkit, inchikeymurckoscaffold, imagescaffold, mwt, logp, nhba, nhbd, nrotors, nrings, psa, log_s, logbb, ppb, pgp, dbonds, nhalo, bonds, nrsys, atoms, tbonds, 
-- abonds, sbonds, mr, csc, imgscaffoldorig, processed, sizer  
-- FROM tb_medchem_scaffold;

-- CREATE INDEX tb_medchem_scaffold_mol_idx2 ON public.tb_medchem_scaffold_nocore USING gist (molrdkit);

CREATE TABLE tb_medchem_molecule_final (
	inchikey text NOT NULL,
	inchikeymurckoscaffold text NULL,
	decomp jsonb NULL,
	image_substituents bytea NULL,
	CONSTRAINT tb_medchem_molecule_final_pk PRIMARY KEY (inchikey)
);
CREATE INDEX tb_medchem_molecule_final_inchikey_idx ON public.tb_medchem_molecule_final USING btree (inchikey);
CREATE INDEX tb_medchem_molecule_final_inchikeymurckoscaffold_idx ON public.tb_medchem_molecule_final USING btree (inchikeymurckoscaffold);

insert into tb_medchem_molecule_final 
SELECT inchikey, inchikeymurckoscaffold, decomp,  image_substituents FROM tb_medchem_molecule;


