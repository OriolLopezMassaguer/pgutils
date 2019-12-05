#!/bin/bash
 
###################################################
# 
###################################################
 
#Set the value of variable
database_dest="thebe_bis"
database_src="thebe"
username="postgres"
hostname="localhost"
export PGPASSWORD='postgres';

#kill all the existing access to src database
psql -U$username -h$hostname -t -c  "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname = '$database_src';"

#duplicate original database
psql -U$username -h$hostname -t -c  "CREATE DATABASE $database_dest WITH TEMPLATE $database_src;"
 
#set all the jobs to complete
JobsToCompleteCount=$(psql -U$username -h$hostname -d$database_dest -t -c "update tb_job set current_state='completed' where current_state not in ('error','completed');")
echo "Jobs updated to completed....:"$JobsToCompleteCount

#delete cascade all entries in tb_chemical space that are not related with some job
MoleculesRemovedCount=$(psql -U$username -h$hostname -d$database_dest -t -c "delete from tb_chemical_space where inchikey not in ( select inchikey_neighbour from tb_molecule_neighbour union select inchikey from tb_molecule);")
echo "Molecules removed from tb_chemical_space....:"$MoleculesRemovedCount

#truncate faers tables;
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_drug2event;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_drug_summary;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_event_summary;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_report cascade;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_outcome_codes cascade;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_report_drug;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_reporter_codes cascade;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_role_codes;"
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_ctfaers_timespan;"

#remove synonyms
RemoveSynonymsCount=$(psql -U$username -h$hostname -d$database_dest -t -c "delete from tb_drug_thesaurus where inchikey not in (select inchikey from tb_chemical_space);")
echo "Synonyms removed....:"$RemoveSynonymsCount

#truncate clean synonyms
psql -U$username -h$hostname -d$database_dest -t -c "truncate table tb_drug_thesaurus_clean;"

#dump data
pg_dump -Fc -U$username -h$hostname -d$database_dest > v3_data_dump.sql

#delete duplicated db
psql -U$username -h$hostname -t -c  "DROP DATABASE $database_dest;"

