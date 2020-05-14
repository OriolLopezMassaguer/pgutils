pg_dump -U postgres --compress=9 -Fd -d $1 -j $2 -h kappa -t tb_ctfaers_drug2event -t tb_ctfaers_drug_summary -t tb_ctfaers_event_summary -t tb_ctfaers_outcome_codes -t tb_ctfaers_report -t tb_ctfaers_report_drug -t tb_ctfaers_reporter_codes -t tb_ctfaers_role_codes -t tb_ctfaers_strata  -t tb_ctfaers_stratified_matrices -t tb_ctfaers_timespan -f faers_$(date -d "today" +"%Y%m%d%H").bak



