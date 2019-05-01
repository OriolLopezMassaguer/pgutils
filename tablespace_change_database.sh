psql -U postgres -d postgres -h kappa -W -v db=$1 -v ts=$2 < tablespace_change_database.sql
