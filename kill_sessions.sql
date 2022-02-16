 show temp_tablespaces ; 

create view public.running_querys 
as

SELECT pid,datname,now() - pg_stat_activity.query_start AS duration,client_addr::text,state,query,*
FROM 
    pg_stat_activity 
where
 datname is not null
--and state='active'
  	--datname = 'thebe_50_2021_q4' 
--     and application_name ='pg_restore'
   --and client_addr IN ('10.9.89.119/32')
 -- and query like 'COPY%'
   --and (now() - pg_stat_activity.query_start) > interval '3 minutes'
   --and pg_stat_activity.application_name like 'ClarityPV%'
order by datname asc
     
ALTER DATABASE thebe_50_prod RENAME TO thebe_50_prod_q3_faers;

SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    pid <> pg_backend_pid()
    and datname = 'thebe_50_dataload'     
    and pid =138857
    
8056

SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes'
--and state!='idle';



     

     
     and client_addr::text='10.3.117.63/32'
     
     

   
  SELECT pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' and datname = 'thebe_dev_40_ce' 
ORDER BY query_start desc;

  SELECT pid, application_name, to_char((clock_timestamp() - query_start), 'HH24 hrs MI "minutes" SS "seconds"'), usename, query 
FROM pg_stat_activity 
where application_name like 'IO.%'
order by application_name asc,age(clock_timestamp(), query_start) desc


COPY (SELECT "report_id", "report_id_source", "source", "in_combined", "source_case_id", "molecules_ids", "molecules_names", "molecules_ids_inferred", "molecules_suspicious_ids", "adverse_events_ids", "adverse_events_labels", "adverse_events_aggregations", "num_aggregated_adverse_events", "indications_ids", "indications_labels", "administration_routes", "age_strata", "age_strata_order", "weight_strata", "weight_strata_order", "gender", "outcome", "outcome_order", "reporter", "reporter_order", "report_date", "report_year", "duplicated_report", "single_ingredient", "single_product", "country", "region", "molecule_administration_route_pairs", "molecule_indication_pairs", "molecule_adverse_event_pairs", "discarted_events"
FROM "claritypv"."pv_pm_reports") TO STDOUT