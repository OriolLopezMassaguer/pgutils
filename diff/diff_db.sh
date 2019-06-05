export DB2=thebe_40_milestone3
export HOST2=kappa    
export DB1=thebe_40_milestone4
export HOST1=kappa
export TAG=ms3_ms4
export PGDIFF_PATH=/home/oriol/soft/pgdiff
$PGDIFF_PATH/pgdiff SCHEMA -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > schema_$TAG.sql
$PGDIFF_PATH/pgdiff TABLE -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > table_$TAG.sql
$PGDIFF_PATH/pgdiff COLUMN -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > column_$TAG.sql
$PGDIFF_PATH/pgdiff INDEX -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > index_$TAG.sql
$PGDIFF_PATH/pgdiff VIEW -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > view_$TAG.sql
$PGDIFF_PATH/pgdiff FOREIGN_KEY -U postgres -H $HOST1 -D $DB1 -S public -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s public -o 'sslmode=disable' --password1=postgres --password2=postgres > fk_$TAG.sql


