pg_dump -U postgres -d $1 -h kappa -t tb_molecule_thesaurus -f tb_molecule_thesaurus_$(date -d "today" +"%Y%m%d%H").bak
pg_dump -U postgres -d $1 -h kappa -t tb_target_thesaurus -f tb_target_thesaurus_$(date -d "today" +"%Y%m%d%H").bak
