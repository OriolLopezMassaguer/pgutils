TRUNCATE TABLE tb_job CASCADE;
TRUNCATE TABLE tb_job_model CASCADE;
TRUNCATE TABLE tb_job_molecule CASCADE;
TRUNCATE TABLE tb_molecule CASCADE;
TRUNCATE TABLE tb_molecule_metabolite CASCADE;
TRUNCATE TABLE tb_molecule_neighbour CASCADE;
TRUNCATE TABLE tb_slink CASCADE;
TRUNCATE TABLE tb_slink_fragment CASCADE;
TRUNCATE TABLE tb_tlink CASCADE;
TRUNCATE TABLE tb_tlink_subst_sas CASCADE;
TRUNCATE TABLE tb_tlink_subst_xpharm CASCADE;
DELETE FROM tb_model WHERE tb_user_id<>-1;
DELETE FROM tb_model_network WHERE tb_user_id<>-1;

