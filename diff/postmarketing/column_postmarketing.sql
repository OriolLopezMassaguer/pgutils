-- schemaType: COLUMN
-- db1: {thebe_50_int omicron 5432 postgres postgres postmarketing sslmode=disable}
-- db2: {thebe_50_int omicron 5432 postgres postgres postmarketing_old sslmode=disable}
-- Run the following SQL against db2:


--RENAMED
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN drug_evidence double precision;
ALTER TABLE postmarketing_old.pm_alerts DROP COLUMN IF EXISTS drug_liability;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN event_evidence double precision;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN event_evidence_quartile text;
ALTER TABLE postmarketing_old.pm_alerts DROP COLUMN IF EXISTS event_liability;
ALTER TABLE postmarketing_old.pm_alerts DROP COLUMN IF EXISTS event_liability_quartile;

-- new stratified
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN age_strata text;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN geographic_region text;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN sex text;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN weight_strata text;


-- new fields

ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN drug_only_reports_frequency double precision;
ALTER TABLE postmarketing_old.pm_alerts ADD COLUMN reporting_velocity double precision;




-- Note that adding of array data types are not yet generated properly.
ALTER TABLE postmarketing_old.pm_drug_info ADD COLUMN reporting_acceleration ARRAY;
-- Note that adding of array data types are not yet generated properly.
ALTER TABLE postmarketing_old.pm_drug_info ADD COLUMN reporting_velocity ARRAY;
ALTER TABLE postmarketing_old.pm_std_adr ADD COLUMN ct_report_id bigint;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_adr ALTER COLUMN report_id TYPE bigint;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_demo ALTER COLUMN case_id TYPE bigint;
ALTER TABLE postmarketing_old.pm_std_demo ADD COLUMN ct_report_id bigint;
-- WARNING: This type change may not work well: (timestamp without time zone to date).
ALTER TABLE postmarketing_old.pm_std_demo ALTER COLUMN report_date TYPE date;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_demo ALTER COLUMN report_id TYPE bigint;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_demo ALTER COLUMN vigigrade TYPE bigint;
ALTER TABLE postmarketing_old.pm_std_drug ADD COLUMN ct_report_id bigint;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_drug ALTER COLUMN drug_id TYPE bigint;
ALTER TABLE postmarketing_old.pm_std_drug ALTER COLUMN drug_id DROP NOT NULL;
-- WARNING: This type change may not work well: (numeric to bigint).
ALTER TABLE postmarketing_old.pm_std_drug ALTER COLUMN report_id TYPE bigint;
ALTER TABLE postmarketing_old.pm_std_drug ALTER COLUMN report_id DROP NOT NULL;
ALTER TABLE postmarketing_old.pm_std_drug ALTER COLUMN source DROP NOT NULL;

