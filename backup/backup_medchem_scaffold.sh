#pg_dump -U postgres --compress=9 -d $1 -h kappa -t tb_medchem_scaffold  -Fc -f medchem_scaffold_$(date -d "today" +"%Y%m%d%H").bak
pg_dump -U postgres --compress=9 -d $1 -h kappa -t tb_medchem_scaffold_coremol  -Fc -f medchem_scaffold_coremol_$(date -d "today" +"%Y%m%d%H").bak
