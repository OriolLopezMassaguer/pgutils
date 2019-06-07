pg_dump -U postgres --compress=9 -Fd -d $1 -j $2 -h kappa -t tb_medchem_scaffold -t tb_medchem_molecule -t tb_medchem_substituents  -f medchem_$(date -d "today" +"%Y%m%d%H").bak
