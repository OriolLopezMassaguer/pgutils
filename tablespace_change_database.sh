psql -U postgres -d postgres -h $3 -W -v db=$1 -v ts=$2 < tablespace_change_database.sql
