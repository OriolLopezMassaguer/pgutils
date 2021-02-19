export DB1=thebe_50_dev
export HOST1=kappa
export SCHEMA1=chemspace
export DB2=thebe_50_oriol
export HOST2=kappa   
export SCHEMA2=chemspace
export TAG=cs_review
export PGDIFF_PATH=/home/oriol/soft/pgdiff
export FOLDER=./$TAG/
mkdir $FOLDER
$PGDIFF_PATH/pgdiff SCHEMA -U postgres -H $HOST1 -D $DB1 -S $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/schema_$TAG.sql
$PGDIFF_PATH/pgdiff TABLE -U postgres -H $HOST1 -D $DB1 -S  $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/table_$TAG.sql
$PGDIFF_PATH/pgdiff COLUMN -U postgres -H $HOST1 -D $DB1 -S  $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/column_$TAG.sql
$PGDIFF_PATH/pgdiff INDEX -U postgres -H $HOST1 -D $DB1 -S  $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/index_$TAG.sql
$PGDIFF_PATH/pgdiff VIEW -U postgres -H $HOST1 -D $DB1 -S  $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/view_$TAG.sql
$PGDIFF_PATH/pgdiff FOREIGN_KEY -U postgres -H $HOST1 -D $DB1 -S  $SCHEMA1 -O 'sslmode=disable' -u postgres -h $HOST2 -d $DB2 -s  $SCHEMA2 -o 'sslmode=disable' --password1=postgres --password2=postgres > $FOLDER/fk_$TAG.sql


