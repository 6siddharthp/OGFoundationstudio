-- Foundation Studio · generated orchestration
CREATE SCHEMA IF NOT EXISTS OGFS_DEMO.ORCHESTRATION;

CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_run_log (
  step_name VARCHAR, source_table VARCHAR, status VARCHAR, rows_written NUMBER,
  started_at TIMESTAMP_TZ, completed_at TIMESTAMP_TZ, query_id VARCHAR
);
CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_events (source_table VARCHAR, loaded_at TIMESTAMP_TZ);
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.orchestration_events_stream ON TABLE OGFS_DEMO.BRONZE.orchestration_events;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_ANNANDALE_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_annandale_samples;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_HOUSTON_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_houston_samples;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_CURITIBA_AMOSTRAS','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LAB_MUESTRAS_BA','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lab_muestras_ba;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','RAW_MATERIAL_MASTER','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.raw_material_master;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_bronze_pipeline()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_annandale_samples AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       SAMPLE_ID::VARCHAR AS sample_id,
       PRODUCT_LINE::VARCHAR AS product_line,
       MATERIAL_CODE::VARCHAR AS material_code,
       BATCH_LOT_NUMBER::VARCHAR AS batch_lot_number,
       CONTAINER_ID::VARCHAR AS container_id,
       TEST_TYPE::VARCHAR AS test_type,
       TEST_METHOD_VERSION::VARCHAR AS test_method_version,
       INSTRUMENT_ID::VARCHAR AS instrument_id,
       ANALYST_ID::VARCHAR AS analyst_id,
       TECH_REVIEWER_ID::VARCHAR AS reviewer_id,
       DATE_REQUESTED::VARCHAR AS date_requested,
       DATE_RECEIVED::VARCHAR AS date_received,
       DATE_STARTED::VARCHAR AS date_started,
       DATE_COMPLETED::VARCHAR AS date_completed,
       PRIORITY::VARCHAR AS priority,
       SUBMITTER::VARCHAR AS submitter,
       PROJECT_REFERENCE::VARCHAR AS project_reference,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS result_value,
       RESULT_UNIT::VARCHAR AS result_unit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_LOWER_LIMIT), 38, 10)::NUMBER AS spec_lower_limit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_UPPER_LIMIT), 38, 10)::NUMBER AS spec_upper_limit,
       SAMPLE_STATUS::VARCHAR AS sample_status,
       APPROVAL_STATUS::VARCHAR AS approval_status,
       APPROVAL_DATE::VARCHAR AS approval_date,
       STORAGE_LOCATION::VARCHAR AS storage_location,
       TRY_TO_BOOLEAN(TO_VARCHAR(REPEAT_ANALYSIS_IND))::BOOLEAN AS retest_flag,
       COMMENTS::VARCHAR AS comments,
       SITE_CODE::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LIMS_ANNANDALE_SAMPLES';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_houston_samples AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       SAMPLE_NUMBER::VARCHAR AS sample_id,
       PRODUCT_LINE::VARCHAR AS product_line,
       MATERIAL_CODE::VARCHAR AS material_code,
       BATCH_LOT_NUMBER::VARCHAR AS batch_lot_number,
       CONTAINER_ID::VARCHAR AS container_id,
       ANALYSIS_TYPE::VARCHAR AS test_type,
       TEST_METHOD_VERSION::VARCHAR AS test_method_version,
       INSTRUMENT_ID::VARCHAR AS instrument_id,
       ANALYST_ID::VARCHAR AS analyst_id,
       REVIEWED_BY::VARCHAR AS reviewer_id,
       DATE_REQUESTED::VARCHAR AS date_requested,
       DATE_RECEIVED::VARCHAR AS date_received,
       DATE_STARTED::VARCHAR AS date_started,
       DATE_COMPLETED::VARCHAR AS date_completed,
       PRIORITY::VARCHAR AS priority,
       SUBMITTER::VARCHAR AS submitter,
       PROJECT_REFERENCE::VARCHAR AS project_reference,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS result_value,
       UOM::VARCHAR AS result_unit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_LOWER_LIMIT), 38, 10)::NUMBER AS spec_lower_limit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_UPPER_LIMIT), 38, 10)::NUMBER AS spec_upper_limit,
       SAMPLE_STATUS::VARCHAR AS sample_status,
       APPROVAL_STATUS::VARCHAR AS approval_status,
       APPROVAL_DATE::VARCHAR AS approval_date,
       STORAGE_LOCATION::VARCHAR AS storage_location,
       TRY_TO_BOOLEAN(TO_VARCHAR(RERUN_FLAG))::BOOLEAN AS retest_flag,
       COMMENTS::VARCHAR AS comments,
       SITE_CODE::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LIMS_HOUSTON_SAMPLES';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_curitiba_amostras AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       AMOSTRA_ID::VARCHAR AS sample_id,
       PRODUCT_LINE::VARCHAR AS product_line,
       MATERIAL_CODE::VARCHAR AS material_code,
       BATCH_LOT_NUMBER::VARCHAR AS batch_lot_number,
       CONTAINER_ID::VARCHAR AS container_id,
       TEST_TYPE::VARCHAR AS test_type,
       TEST_METHOD_VERSION::VARCHAR AS test_method_version,
       INSTRUMENT_ID::VARCHAR AS instrument_id,
       TECNICO_ID::VARCHAR AS analyst_id,
       REVIEWER_ID::VARCHAR AS reviewer_id,
       DATA_SOLICITADA::VARCHAR AS date_requested,
       DATE_RECEIVED::VARCHAR AS date_received,
       DATE_STARTED::VARCHAR AS date_started,
       DATE_COMPLETED::VARCHAR AS date_completed,
       PRIORITY::VARCHAR AS priority,
       SUBMITTER::VARCHAR AS submitter,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS result_value,
       RESULT_UNIT::VARCHAR AS result_unit,
       STATUS_AMOSTRA::VARCHAR AS sample_status,
       APPROVAL_STATUS::VARCHAR AS approval_status,
       TRY_TO_BOOLEAN(TO_VARCHAR(RETEST_FLAG))::BOOLEAN AS retest_flag,
       COMMENTS::VARCHAR AS comments,
       SITE_CODE::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LIMS_CURITIBA_AMOSTRAS';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lab_muestras_ba AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       SAMPLE_ID::VARCHAR AS sample_id,
       PRODUCT_LINE::VARCHAR AS product_line,
       MATERIAL_CODE::VARCHAR AS material_code,
       BATCH_LOT_NUMBER::VARCHAR AS batch_lot_number,
       CONTAINER_ID::VARCHAR AS container_id,
       TEST_TYPE::VARCHAR AS test_type,
       TEST_METHOD_VERSION::VARCHAR AS test_method_version,
       INSTRUMENT_ID::VARCHAR AS instrument_id,
       ANALYST_ID::VARCHAR AS analyst_id,
       REVISOR_USUARIO::VARCHAR AS reviewer_id,
       DATE_REQUESTED::VARCHAR AS date_requested,
       DATE_RECEIVED::VARCHAR AS date_received,
       DATE_STARTED::VARCHAR AS date_started,
       DATE_COMPLETED::VARCHAR AS date_completed,
       PRIORITY::VARCHAR AS priority,
       SUBMITTER::VARCHAR AS submitter,
       PROJECT_REFERENCE::VARCHAR AS project_reference,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS result_value,
       RESULT_UNIT::VARCHAR AS result_unit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_LOWER_LIMIT), 38, 10)::NUMBER AS spec_lower_limit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_UPPER_LIMIT), 38, 10)::NUMBER AS spec_upper_limit,
       SAMPLE_STATUS::VARCHAR AS sample_status,
       APPROVAL_STATUS::VARCHAR AS approval_status,
       APPROVAL_DATE::VARCHAR AS approval_date,
       STORAGE_LOCATION::VARCHAR AS storage_location,
       TRY_TO_BOOLEAN(TO_VARCHAR(RETEST_FLAG))::BOOLEAN AS retest_flag,
       SITE_CODE::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LAB_MUESTRAS_BA';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.raw_material_master AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       CANONICAL_MATERIAL_NAME::VARCHAR AS canonical_material_name,
       BUSINESS_LINE::VARCHAR AS business_line,
       SOURCE_MATERIAL_CODE::VARCHAR AS source_material_code,
       LEGACY_MATERIAL_ID::VARCHAR AS legacy_material_id,
       CASNUMBER::VARCHAR AS cas_number,
       SUPPLIER::VARCHAR AS supplier,
       SUPPLIER_GRADE::VARCHAR AS supplier_grade,
       UNIT_OF_MEASURE::VARCHAR AS unit_of_measure,
       TRY_TO_DECIMAL(TO_VARCHAR(DENSITY), 38, 10)::NUMBER AS density,
       TRY_TO_DECIMAL(TO_VARCHAR(VISCOSITY_GRADE), 38, 10)::NUMBER AS viscosity_grade,
       HAZARD_CLASSIFICATION::VARCHAR AS hazard_classification,
       SAFETY_DATA_SHEET_REF::VARCHAR AS safety_data_sheet_ref,
       TRY_TO_DECIMAL(TO_VARCHAR(SHELF_LIFE_MONTHS), 38, 10)::NUMBER AS shelf_life_months,
       STORAGE_CONDITIONS::VARCHAR AS storage_conditions,
       TRY_TO_BOOLEAN(TO_VARCHAR(APPROVED_FOR_USE))::BOOLEAN AS approved_for_use,
       TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(LAST_REVIEW_DATE))::TIMESTAMP_NTZ AS last_review_date,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.RAW_MATERIAL_MASTER';
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.ORCHESTRATION.bronze_pipeline_task
  WAREHOUSE = OGFS_DEMO_WH SCHEDULE = 'USING CRON 0 6 * * * America/Chicago'
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2
AS CALL OGFS_DEMO.BRONZE.run_bronze_pipeline();
