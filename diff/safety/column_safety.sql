-- schemaType: COLUMN
-- db1: {thebe_50_int omicron 5432 postgres postgres safety sslmode=disable}
-- db2: {thebe_50_int omicron 5432 postgres postgres safety_old sslmode=disable}
-- Run the following SQL against db2:
-- Note that adding of array data types are not yet generated properly.
ALTER TABLE safety_old.sa_aggregated_annotations ADD COLUMN all_sources ARRAY;
ALTER TABLE safety_old.sa_translational_safety_summary ADD COLUMN in_label boolean;
