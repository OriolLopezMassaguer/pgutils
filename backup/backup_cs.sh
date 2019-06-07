pg_dump -U postgres -d $1 -h kappa -t tb_chemical_space -Fc -f cspace_$(date -d "today" +"%Y%m%d%H").bak
