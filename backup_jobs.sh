pg_dump -Fc -f backup_jobs_$(date -d "today" +"%Y%m%d%H").bak -U postgres --data-only -t tb_user -t tb_model -t tb_model_network -t tb_job -t tb_job_model -t tb_job_molecule -t tb_molecule -t tb_molecule_metabolite -t tb_molecule_neighbour -t tb_slink -t tb_slink_fragment -t tb_tlink -t tb_tlink_subst_sas -t tb_tlink_subst_xpharm -h $1 -d $2


