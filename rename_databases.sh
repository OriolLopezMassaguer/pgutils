psql -U postgres -d postgres -h localhost -W -v db1=$1 -v db2=$2 < rename_databases.sql 
