# $1 host
# $2 db
# $3 jobs
# $4 schema
filename=$1_$2_$4_$(date -d "today" +"%Y%m%d%H").backup
echo $filename
pg_dump -Upostgres --compress=9 -T 'tmp_*' -W -h $1 -j $3 -Fd -d $2 -n $4 -f $filename
chmod -R 770 $filename
