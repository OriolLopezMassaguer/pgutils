# $1 db1
# $2 host1
# $3 db2
# $4 host2
# $5 schema
#pg_dump -Upostgres -W -h$2 $1 -Fp | psql -Upostgres -h$4 -d $3
pg_dump -Upostgres -W -h$2 $1 -n $5  -Fc | pg_restore -Upostgres -h$4 -d $3


