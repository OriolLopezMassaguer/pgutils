pg_dump -p 5433 -Upostgres --compress=9 -W -h $1 -j $3 -Fd -d $2 -f $1_$2_$(date -d "today" +"%Y%m%d%H")_$4.backupp
