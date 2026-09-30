-- Foundation Studio · generated orchestration
CREATE OR REPLACE PROCEDURE OGFS_DEMO.GOLD.run_gold_pipeline()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.GOLD.dim_material (
  material_sk NUMBER AUTOINCREMENT PRIMARY KEY,
  material_key VARCHAR,
  canonical_material_name VARCHAR,
  business_line VARCHAR,
  cas_number VARCHAR,
  supplier VARCHAR,
  unit_of_measure VARCHAR,
  hazard_classification VARCHAR,
  valid_from TIMESTAMP_TZ,
  valid_to TIMESTAMP_TZ,
  is_current BOOLEAN,
  safety_data_sheet_ref VARCHAR
)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_material d SET valid_from=''1900-01-01''::TIMESTAMP_TZ
WHERE d.valid_from=(SELECT MIN(history.valid_from) FROM OGFS_DEMO.GOLD.dim_material history WHERE history.material_key=d.material_key)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
SET gold_scd_effective_at=CURRENT_TIMESTAMP()';
  EXECUTE IMMEDIATE '-- foundation:stage 3
MERGE INTO OGFS_DEMO.GOLD.dim_material d
USING (SELECT source_raw.material_key,source_raw.canonical_material_name,source_raw.business_line,source_raw.cas_number,source_raw.supplier,source_raw.unit_of_measure,source_raw.hazard_classification,source_raw.safety_data_sheet_ref FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_material) source_raw) s
ON d.material_key = s.material_key AND d.is_current = TRUE
WHEN MATCHED AND HASH(d.business_line,d.cas_number,d.supplier,d.unit_of_measure,d.hazard_classification,d.safety_data_sheet_ref) <> HASH(s.business_line,s.cas_number,s.supplier,s.unit_of_measure,s.hazard_classification,s.safety_data_sheet_ref) THEN UPDATE SET d.valid_to=$gold_scd_effective_at,d.is_current=FALSE
WHEN NOT MATCHED THEN INSERT (material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification,safety_data_sheet_ref,valid_from,valid_to,is_current) VALUES (s.material_key,s.canonical_material_name,s.business_line,s.cas_number,s.supplier,s.unit_of_measure,s.hazard_classification,s.safety_data_sheet_ref,''1900-01-01''::TIMESTAMP_TZ,''9999-12-31''::TIMESTAMP_TZ,TRUE)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.GOLD.dim_material (material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification,safety_data_sheet_ref,valid_from,valid_to,is_current)
SELECT s.material_key,s.canonical_material_name,s.business_line,s.cas_number,s.supplier,s.unit_of_measure,s.hazard_classification,s.safety_data_sheet_ref,$gold_scd_effective_at,''9999-12-31''::TIMESTAMP_TZ,TRUE
FROM (SELECT source_raw.material_key,source_raw.canonical_material_name,source_raw.business_line,source_raw.cas_number,source_raw.supplier,source_raw.unit_of_measure,source_raw.hazard_classification,source_raw.safety_data_sheet_ref FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_material) source_raw) s
WHERE NOT EXISTS (
  SELECT 1 FROM OGFS_DEMO.GOLD.dim_material current_row
  WHERE current_row.material_key=s.material_key AND current_row.is_current=TRUE AND HASH(current_row.business_line,current_row.cas_number,current_row.supplier,current_row.unit_of_measure,current_row.hazard_classification,current_row.safety_data_sheet_ref) = HASH(s.business_line,s.cas_number,s.supplier,s.unit_of_measure,s.hazard_classification,s.safety_data_sheet_ref)
)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_material d
SET canonical_material_name=s.canonical_material_name
FROM (SELECT source_raw.material_key,source_raw.canonical_material_name,source_raw.business_line,source_raw.cas_number,source_raw.supplier,source_raw.unit_of_measure,source_raw.hazard_classification,source_raw.safety_data_sheet_ref FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_material) source_raw) s
WHERE d.material_key=s.material_key
  AND (d.canonical_material_name IS DISTINCT FROM s.canonical_material_name)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
MERGE INTO OGFS_DEMO.GOLD.dim_material d
USING (SELECT -1 material_sk) u ON d.material_sk=u.material_sk
WHEN NOT MATCHED THEN INSERT (material_sk,material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification,valid_from,valid_to,is_current,safety_data_sheet_ref)
VALUES (-1,''MAT_UNKNOWN'',''Unknown material'',NULL,NULL,NULL,NULL,NULL,''1900-01-01''::TIMESTAMP_TZ,''9999-12-31''::TIMESTAMP_TZ,TRUE,NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.GOLD.dim_test_method (
  test_method_sk NUMBER AUTOINCREMENT PRIMARY KEY,
  test_method_key VARCHAR,
  governed_standard_reference VARCHAR,
  standard_body VARCHAR,
  method_title VARCHAR,
  applies_to_business_line VARCHAR,
  valid_from TIMESTAMP_TZ,
  valid_to TIMESTAMP_TZ,
  is_current BOOLEAN
)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_test_method d SET valid_from=''1900-01-01''::TIMESTAMP_TZ
WHERE d.valid_from=(SELECT MIN(history.valid_from) FROM OGFS_DEMO.GOLD.dim_test_method history WHERE history.test_method_key=d.test_method_key)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
SET gold_scd_effective_at=CURRENT_TIMESTAMP()';
  EXECUTE IMMEDIATE '-- foundation:stage 3
MERGE INTO OGFS_DEMO.GOLD.dim_test_method d
USING (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
ON d.test_method_key = s.test_method_key AND d.is_current = TRUE
WHEN MATCHED AND HASH(d.governed_standard_reference,d.standard_body,d.applies_to_business_line) <> HASH(s.governed_standard_reference,s.standard_body,s.applies_to_business_line) THEN UPDATE SET d.valid_to=$gold_scd_effective_at,d.is_current=FALSE
WHEN NOT MATCHED THEN INSERT (test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line,valid_from,valid_to,is_current) VALUES (s.test_method_key,s.governed_standard_reference,s.standard_body,s.method_title,s.applies_to_business_line,''1900-01-01''::TIMESTAMP_TZ,''9999-12-31''::TIMESTAMP_TZ,TRUE)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.GOLD.dim_test_method (test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line,valid_from,valid_to,is_current)
SELECT s.test_method_key,s.governed_standard_reference,s.standard_body,s.method_title,s.applies_to_business_line,$gold_scd_effective_at,''9999-12-31''::TIMESTAMP_TZ,TRUE
FROM (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
WHERE NOT EXISTS (
  SELECT 1 FROM OGFS_DEMO.GOLD.dim_test_method current_row
  WHERE current_row.test_method_key=s.test_method_key AND current_row.is_current=TRUE AND HASH(current_row.governed_standard_reference,current_row.standard_body,current_row.applies_to_business_line) = HASH(s.governed_standard_reference,s.standard_body,s.applies_to_business_line)
)';
  EXECUTE IMMEDIATE '-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_test_method d
SET method_title=s.method_title
FROM (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
WHERE d.test_method_key=s.test_method_key
  AND (d.method_title IS DISTINCT FROM s.method_title)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_lab_site AS SELECT s.site_key,s.site_code,s.site_name FROM (SELECT source_raw.site_key,source_raw.site_code,source_raw.site_name FROM (SELECT column1::VARCHAR site_key,column2::VARCHAR site_code,column3::VARCHAR site_name FROM VALUES (''SITE_ANNANDALE'',''annandale'',''Annandale''),(''SITE_HOUSTON'',''houston'',''Houston''),(''SITE_CURITIBA'',''curitiba'',''Curitiba''),(''SITE_BUENOS_AIRES'',''buenos_aires'',''Buenos Aires'')) source_raw) s';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_business_line AS SELECT s.business_line_key,s.business_line_name FROM (SELECT source_raw.business_line_key,source_raw.business_line_name FROM (SELECT DISTINCT business_line_key,business_line_name FROM OGFS_DEMO.SILVER.business_line_mapping) source_raw) s';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_date AS SELECT s.date_key,s.full_date,s.year,s.quarter,s.month,s.month_name,s.week_of_year,s.day_of_week FROM (SELECT source_raw.date_key,source_raw.full_date,source_raw.year,source_raw.quarter,source_raw.month,source_raw.month_name,source_raw.week_of_year,source_raw.day_of_week FROM (WITH event_dates AS (
    SELECT TO_DATE(completion_date) event_date FROM OGFS_DEMO.SILVER.conformed_lab_sample
    UNION ALL
    SELECT TO_DATE(result_date) event_date FROM OGFS_DEMO.SILVER.conformed_test_result
  ), bounds AS (
    SELECT DATEADD(day,-31,COALESCE(MIN(event_date),CURRENT_DATE())) start_date,
           DATEADD(day,31,COALESCE(MAX(event_date),CURRENT_DATE())) end_date
    FROM event_dates WHERE event_date IS NOT NULL
  ), days AS (
    SELECT DATEADD(day,f.value::INTEGER,b.start_date) day
    FROM bounds b,LATERAL FLATTEN(INPUT=>ARRAY_GENERATE_RANGE(0,DATEDIFF(day,b.start_date,b.end_date)+1)) f
  )
  SELECT TO_NUMBER(TO_CHAR(day,''YYYYMMDD'')) date_key,day full_date,YEAR(day) year,QUARTER(day) quarter,
         MONTH(day) month,MONTHNAME(day) month_name,WEEKOFYEAR(day) week_of_year,DAYNAME(day) day_of_week
  FROM days) source_raw) s';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.fact_lab_sample AS SELECT b.lab_sample_key,CASE WHEN b.material_key IS NULL THEN unknown_material_1.material_sk ELSE d1.material_sk END AS material_sk,d2.test_method_sk AS test_method_sk,b.site_key AS site_key,b.business_line_key AS business_line_key,b.date_key AS date_key,b.turnaround_days,b.sample_status,b.source_system_count FROM (SELECT s.lab_sample_key,s.material_key,s.test_method_key,''SITE_''||UPPER(s.site_code) site_key,COALESCE(bl.business_line_key,(SELECT business_line_key FROM OGFS_DEMO.SILVER.business_line_mapping WHERE source_product_line IS NULL)) business_line_key,TO_NUMBER(TO_CHAR(TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.completion_date)),''YYYYMMDD'')) date_key,DATEDIFF(day,TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.requested_date)),TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.completion_date))) turnaround_days,s.sample_status,s.source_system_count,TRY_TO_TIMESTAMP_TZ(TO_VARCHAR(s.completion_date)) _event_time FROM OGFS_DEMO.SILVER.conformed_lab_sample s LEFT JOIN OGFS_DEMO.SILVER.business_line_mapping bl ON LOWER(TRIM(bl.source_product_line))=LOWER(TRIM(s.business_line))) b LEFT JOIN OGFS_DEMO.GOLD.dim_material d1 ON d1.material_key=b.material_key AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) >= d1.valid_from AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) < d1.valid_to LEFT JOIN OGFS_DEMO.GOLD.dim_material unknown_material_1 ON unknown_material_1.material_key=''MAT_UNKNOWN'' AND unknown_material_1.is_current=TRUE LEFT JOIN OGFS_DEMO.GOLD.dim_test_method d2 ON d2.test_method_key=b.test_method_key AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) >= d2.valid_from AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) < d2.valid_to';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.fact_test_result AS SELECT b.test_result_key,b.lab_sample_key AS lab_sample_key,CASE WHEN b.material_key IS NULL THEN unknown_material_2.material_sk ELSE d2.material_sk END AS material_sk,d3.test_method_sk AS test_method_sk,b.date_key AS date_key,b.result_value,b.result_unit,b.spec_lower_limit,b.spec_upper_limit,b.within_spec FROM (SELECT test_result_key,lab_sample_key,test_method_key,material_key,TO_NUMBER(TO_CHAR(TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(result_date)),''YYYYMMDD'')) date_key,result_value,result_unit,spec_lower_limit,spec_upper_limit,within_spec,TRY_TO_TIMESTAMP_TZ(TO_VARCHAR(result_date)) _event_time FROM OGFS_DEMO.SILVER.conformed_test_result) b LEFT JOIN OGFS_DEMO.GOLD.dim_material d2 ON d2.material_key=b.material_key AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) >= d2.valid_from AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) < d2.valid_to LEFT JOIN OGFS_DEMO.GOLD.dim_material unknown_material_2 ON unknown_material_2.material_key=''MAT_UNKNOWN'' AND unknown_material_2.is_current=TRUE LEFT JOIN OGFS_DEMO.GOLD.dim_test_method d3 ON d3.test_method_key=b.test_method_key AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) >= d3.valid_from AND COALESCE(b._event_time,''1900-01-01''::TIMESTAMP_TZ) < d3.valid_to';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT column1::VARCHAR kpi_name,column2::BOOLEAN included,column3::VARCHAR skip_reason,
       PARSE_JSON(BASE64_DECODE_STRING(column4))::VARIANT site_policy,column5::VARCHAR policy_summary
FROM VALUES (''Cross-Lab Data Standardization Rate'',TRUE,NULL,''W10='',''''),
(''Cross-Lab Reproducibility Index'',TRUE,NULL,''W10='',''''),
(''Cross-Site Result Correlation'',TRUE,NULL,''W10='',''''),
(''Duplicate Test Rate Across Labs'',TRUE,NULL,''W10='',''''),
(''Inter-Site Result Deviation'',TRUE,NULL,''W10='',''''),
(''Site-Pair Agreement by Method'',TRUE,NULL,''W10='',''''),
(''Test Method Standardization Rate'',TRUE,NULL,''W10='',''''),
(''Unmatched Sample Rate'',TRUE,NULL,''W10='',''''),
(''Backlog Aging Index'',TRUE,NULL,''W10='',''''),
(''First-Time-Right Rate'',TRUE,NULL,''W3sic2l0ZUlkIjoiY3VyaXRpYmEiLCJzaXRlTmFtZSI6IkN1cml0aWJhIiwiZmllbGRzIjpbInNwZWNfbG93ZXJfbGltaXQiLCJzcGVjX3VwcGVyX2xpbWl0Il0sInJlYXNvbiI6IkV4Y2x1ZGVkIGJlY2F1c2Ugc3BlY19sb3dlcl9saW1pdCBhbmQgc3BlY191cHBlcl9saW1pdCBhcmUgbm90IGNhcHR1cmVkIGF0IHNvdXJjZS4ifV0='',''Excludes Curitiba from this KPI calculation.''),
(''Instrument Throughput'',TRUE,NULL,''W10='',''''),
(''LIMS Data Completeness'',TRUE,NULL,''W3sic2l0ZUlkIjoiY3VyaXRpYmEiLCJzaXRlTmFtZSI6IkN1cml0aWJhIiwiZmllbGRzIjpbInByb2plY3RfcmVmZXJlbmNlIiwic3BlY19sb3dlcl9saW1pdCIsInNwZWNfdXBwZXJfbGltaXQiLCJhcHByb3ZhbF9kYXRlIiwic3RvcmFnZV9sb2NhdGlvbiJdLCJyZWFzb24iOiJOb3QgY2FwdHVyZWQgYXQgc291cmNlOyBjb3VudGVkIGFzIDUgY29tcGxldGVuZXNzIGdhcHMuIn0seyJzaXRlSWQiOiJidWVub3NfYWlyZXMiLCJzaXRlTmFtZSI6IkJ1ZW5vcyBBaXJlcyIsImZpZWxkcyI6WyJjb21tZW50cyJdLCJyZWFzb24iOiJOb3QgY2FwdHVyZWQgYXQgc291cmNlOyBjb3VudGVkIGFzIDEgY29tcGxldGVuZXNzIGdhcC4ifV0='',''Curitiba, Buenos Aires source gaps are included in the completeness denominator.''),
(''Lab Capacity Utilization'',TRUE,NULL,''W10='',''''),
(''Retest Rate'',TRUE,NULL,''W10='',''''),
(''Sample Turnaround Time'',TRUE,NULL,''W10='',''''),
(''Sample Volume Trend'',TRUE,NULL,''W10='','''')';
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.ORCHESTRATION.gold_pipeline_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  AFTER OGFS_DEMO.ORCHESTRATION.silver_pipeline_task
AS CALL OGFS_DEMO.GOLD.run_gold_pipeline();
CREATE OR REPLACE VIEW OGFS_DEMO.GOLD.orchestration_freshness AS
SELECT source_table,MAX(completed_at) last_successful_load
FROM OGFS_DEMO.BRONZE.orchestration_run_log WHERE status='SUCCEEDED' GROUP BY source_table;
