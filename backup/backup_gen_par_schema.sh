# $1 host
# $2 db
# $3 jobs
# $4 schema
pg_dump -Upostgres --compress=9 -W -h $1 -j $3 -Fd -d $2 -n $4 -f $1_$2_$(date -d "today" +"%Y%m%d%H")_$4.backup
