mkdir /home/oriol/database/$1_$(date -d "today" +"%Y%m%d%H").backup
pg_dump -Upostgres --compress=9 -W -hlocalhost -j $2 -Fd -d $1 -f /home/oriol/database/$1_$(date -d "today" +"%Y%m%d%H").backup
