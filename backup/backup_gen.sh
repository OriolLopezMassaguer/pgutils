pg_dump -Upostgres --compress=9 -W -h$2 $1  -Fc -f /home/oriol/database/$1_$(date -d "today" +"%Y%m%d%H").bak
