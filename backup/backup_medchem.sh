pg_dump -U postgres --compress=9 -d $1 -h kappa -t tb_medchem_scaffold -t tb_medchem_molecule -t tb_medchem_substituents -Fc -f medchem_$(date -d "today" +"%Y%m%d%H").bak
