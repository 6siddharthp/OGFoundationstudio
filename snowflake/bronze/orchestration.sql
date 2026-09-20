-- Foundation Studio · generated orchestration
CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_run_log (
  step_name VARCHAR, source_table VARCHAR, status VARCHAR, rows_written NUMBER,
  started_at TIMESTAMP_TZ, completed_at TIMESTAMP_TZ, query_id VARCHAR
);
CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_events (source_table VARCHAR, loaded_at TIMESTAMP_TZ);
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.orchestration_events_stream ON TABLE OGFS_DEMO.BRONZE.orchestration_events;
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_lims_annandale_samples_stream ON TABLE OGFS_DEMO.SOURCE.LIMS_ANNANDALE_SAMPLES;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_lims_annandale_samples()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_lims_annandale_samples_task','LIMS_ANNANDALE_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_lims_annandale_samples_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('LIMS_ANNANDALE_SAMPLES',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_lims_annandale_samples_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_lims_annandale_samples_stream')
AS CALL OGFS_DEMO.BRONZE.run_lims_annandale_samples();
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_lims_houston_samples_stream ON TABLE OGFS_DEMO.SOURCE.LIMS_HOUSTON_SAMPLES;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_lims_houston_samples()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_lims_houston_samples_task','LIMS_HOUSTON_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_lims_houston_samples_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('LIMS_HOUSTON_SAMPLES',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_lims_houston_samples_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_lims_houston_samples_stream')
AS CALL OGFS_DEMO.BRONZE.run_lims_houston_samples();
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_lims_curitiba_amostras_stream ON TABLE OGFS_DEMO.SOURCE.LIMS_CURITIBA_AMOSTRAS;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_lims_curitiba_amostras()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_lims_curitiba_amostras_task','LIMS_CURITIBA_AMOSTRAS','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_lims_curitiba_amostras_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('LIMS_CURITIBA_AMOSTRAS',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_lims_curitiba_amostras_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_lims_curitiba_amostras_stream')
AS CALL OGFS_DEMO.BRONZE.run_lims_curitiba_amostras();
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_lab_muestras_ba_stream ON TABLE OGFS_DEMO.SOURCE.LAB_MUESTRAS_BA;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_lab_muestras_ba()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_lab_muestras_ba_task','LAB_MUESTRAS_BA','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_lab_muestras_ba_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('LAB_MUESTRAS_BA',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_lab_muestras_ba_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_lab_muestras_ba_stream')
AS CALL OGFS_DEMO.BRONZE.run_lab_muestras_ba();
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_lims_test_copy_stream ON TABLE OGFS_DEMO.SOURCE.LIMS_TEST_COPY;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_lims_test_copy()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_lims_test_copy_task','LIMS_TEST_COPY','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_lims_test_copy_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_test_copy AS
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
FROM OGFS_DEMO.SOURCE.LIMS_TEST_COPY';
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('LIMS_TEST_COPY',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_lims_test_copy_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_lims_test_copy_stream')
AS CALL OGFS_DEMO.BRONZE.run_lims_test_copy();
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.source_raw_material_master_stream ON TABLE OGFS_DEMO.SOURCE.RAW_MATERIAL_MASTER;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_raw_material_master()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at)
  SELECT 'load_raw_material_master_task','RAW_MATERIAL_MASTER','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP() FROM OGFS_DEMO.BRONZE.source_raw_material_master_stream;
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  INSERT INTO OGFS_DEMO.BRONZE.orchestration_events(source_table,loaded_at) VALUES ('RAW_MATERIAL_MASTER',CURRENT_TIMESTAMP());
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.load_raw_material_master_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2 WHEN SYSTEM$STREAM_HAS_DATA('OGFS_DEMO.BRONZE.source_raw_material_master_stream')
AS CALL OGFS_DEMO.BRONZE.run_raw_material_master();
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
SELECT 'initial_deploy','LIMS_TEST_COPY','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_test_copy;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','RAW_MATERIAL_MASTER','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.raw_material_master;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_full_pipeline()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_test_copy AS
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
FROM OGFS_DEMO.SOURCE.LIMS_TEST_COPY';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
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
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quarantine_records (
  quarantine_id NUMBER AUTOINCREMENT, source_table VARCHAR, source_row_number NUMBER,
  rule_name VARCHAR, reason VARCHAR, site_code VARCHAR, review_status VARCHAR,
  source_data VARIANT, quarantined_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS
SELECT column1::VARCHAR source_method_name, column2::VARCHAR governed_standard_reference, column3::VARCHAR standard_body, column4::VARCHAR method_title, column5::VARCHAR applies_to_business_line
FROM VALUES (''Viscosity'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants''),
(''Kinematic Viscosity'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants''),
(''Kinematic Viscosity @ 100C'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants''),
(''KV100'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants''),
(''Visc @ 40C'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants''),
(''Flash Point'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels''),
(''Flash Pt'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels''),
(''Flash Point PMCC'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels''),
(''Flash Point COC'',''ASTM D92'',''ASTM'',''Flash Point by Cleveland Open Cup'',''Lubricants''),
(''Flash Point Open Cup'',''ASTM D92'',''ASTM'',''Flash Point by Cleveland Open Cup'',''Lubricants''),
(''Pour Point'',''ASTM D97'',''ASTM'',''Pour Point of Petroleum Products'',''Lubricants''),
(''Acid Number'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants''),
(''Total Acid Number'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants''),
(''TAN'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants''),
(''Base Number'',''ASTM D4739'',''ASTM'',''Base Number by Potentiometric Hydrochloric Acid Titration'',''Lubricants''),
(''TBN'',''ASTM D4739'',''ASTM'',''Base Number by Potentiometric Hydrochloric Acid Titration'',''Lubricants''),
(''Sulfur'',''ASTM D2622'',''ASTM'',''Sulfur by Wavelength Dispersive XRF'',''Fuels''),
(''Sulphur Content'',''ASTM D2622'',''ASTM'',''Sulfur by Wavelength Dispersive XRF'',''Fuels''),
(''Sulfur XRF'',''ASTM D4294'',''ASTM'',''Sulfur by Energy Dispersive XRF'',''Fuels''),
(''Sulfur EDXRF'',''ASTM D4294'',''ASTM'',''Sulfur by Energy Dispersive XRF'',''Fuels''),
(''Density'',''ASTM D4052'',''ASTM'',''Density, Relative Density, and API Gravity by Digital Density Meter'',''Fuels''),
(''API Gravity'',''ASTM D4052'',''ASTM'',''Density, Relative Density, and API Gravity by Digital Density Meter'',''Fuels''),
(''Water Content'',''ASTM D6304'',''ASTM'',''Water by Coulometric Karl Fischer Titration'',''Cross-business''),
(''Karl Fischer Water'',''ASTM D6304'',''ASTM'',''Water by Coulometric Karl Fischer Titration'',''Cross-business''),
(''Ash'',''ASTM D482'',''ASTM'',''Ash from Petroleum Products'',''Cross-business''),
(''Viscosity Index'',''ASTM D2270'',''ASTM'',''Calculating Viscosity Index from Kinematic Viscosity'',''Lubricants''),
(''VI'',''ASTM D2270'',''ASTM'',''Calculating Viscosity Index from Kinematic Viscosity'',''Lubricants''),
(''Cold Crank'',''ASTM D5293'',''ASTM'',''Apparent Viscosity by Cold-Cranking Simulator'',''Lubricants''),
(''CCS'',''ASTM D5293'',''ASTM'',''Apparent Viscosity by Cold-Cranking Simulator'',''Lubricants''),
(''Wear Metals'',''ASTM D5185'',''ASTM'',''Multielement Determination by ICP-AES'',''Lubricants''),
(''ICP Metals'',''ASTM D5185'',''ASTM'',''Multielement Determination by ICP-AES'',''Lubricants''),
(''Cloud Point'',''ASTM D2500'',''ASTM'',''Cloud Point of Petroleum Products'',''Fuels''),
(''Color'',''ASTM D1500'',''ASTM'',''ASTM Color of Petroleum Products'',''Cross-business''),
(''Oxidation Stability'',''ASTM D2274'',''ASTM'',''Oxidation Stability of Distillate Fuel Oil'',''Fuels''),
(''Aniline Point'',''ASTM D611'',''ASTM'',''Aniline Point and Mixed Aniline Point'',''Fuels''),
(''Bromine Number'',''ASTM D1159'',''ASTM'',''Bromine Numbers by Electrometric Titration'',''Chemicals''),
(''Boiling Range Distribution'',''ASTM D2887'',''ASTM'',''Boiling Range Distribution by Gas Chromatography'',''Fuels''),
(''SimDis'',''ASTM D2887'',''ASTM'',''Boiling Range Distribution by Gas Chromatography'',''Fuels''),
(''Cetane Index'',''ASTM D976'',''ASTM'',''Calculated Cetane Index of Distillate Fuels'',''Fuels''),
(''Sequence VIII'',''ASTM D6709'',''ASTM'',''Sequence VIII Engine Test'',''Lubricants''),
(''Sequence IVA'',''ASTM D6891'',''ASTM'',''Sequence IVA Engine Test'',''Lubricants''),
(''Sequence IIIF'',''ASTM D6984'',''ASTM'',''Sequence IIIF Engine Test'',''Lubricants''),
(''Deposit Sequence'',''ASTM D6593'',''ASTM'',''Sequence VG Engine Test for Deposit Formation'',''Lubricants''),
(''ROBO Oxidation'',''ASTM D7528'',''ASTM'',''ROBO Apparatus Oxidation Test'',''Lubricants''),
(''PDSC Oxidation'',''ASTM D6186'',''ASTM'',''Oxidation Induction Time by PDSC'',''Lubricants''),
(''Injector Fouling'',''ASTM D6421'',''ASTM'',''Electronic Port Fuel Injector Fouling'',''Fuels''),
(''Water Reaction Aviation Fuel'',''ASTM D1094'',''ASTM'',''Water Reaction of Aviation Fuels'',''Fuels''),
(''ILSAC GF-6'',''ILSAC GF-6'',''ILSAC'',''Passenger Car Engine Oil Performance Specification'',''Lubricants''),
(''API SP'',''API SP'',''API'',''API Service Category SP'',''Lubricants'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_sample_status_reference AS
SELECT column1::VARCHAR source_value, column2::VARCHAR source_system, column3::VARCHAR governed_status
FROM VALUES (''Complete'',''Annandale'',''Completed''),
(''Closed'',''Houston'',''Completed''),
(''In Progress'',''Annandale'',''In Progress''),
(''Open'',''Houston'',''In Progress''),
(''Pending Review'',''Annandale'',''Pending Review''),
(''Awaiting QA'',''Houston'',''Pending Review''),
(''Concluido'',''Curitiba'',''Completed''),
(''Em Andamento'',''Curitiba'',''In Progress''),
(''Aguardando Revisao'',''Curitiba'',''Pending Review''),
(''Completado'',''Buenos Aires'',''Completed''),
(''En Progreso'',''Buenos Aires'',''In Progress''),
(''Pendiente Revision'',''Buenos Aires'',''Pending Review'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_uom_reference AS
SELECT column1::VARCHAR source_unit, column2::VARCHAR governed_unit, column3::VARCHAR measure_type
FROM VALUES (''cSt'',''mm2/s'',''Kinematic viscosity''),
(''centistokes'',''mm2/s'',''Kinematic viscosity''),
(''mgKOH/g'',''mg KOH/g'',''Acid or base number''),
(''mg KOH per g'',''mg KOH/g'',''Acid or base number''),
(''ppm'',''mg/kg'',''Concentration''),
(''degC'',''degC'',''Temperature''),
(''C'',''degC'',''Temperature''),
(''Celsius'',''degC'',''Temperature''),
(''kPa'',''bar'',''Pressure''),
(''kg/m3'',''kg/m3'',''Density'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_annandale_samples AS
SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  NULL::VARCHAR AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_annandale_samples'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_ANNANDALE_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''test_type: Code lookup failed'', ''annandale'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_ANNANDALE_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''result_unit: Code lookup failed'', ''annandale'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_ANNANDALE_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''sample_status: Code lookup failed'', ''annandale'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_houston_samples AS
SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  NULL::VARCHAR AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_houston_samples'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_HOUSTON_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''test_type: Code lookup failed'', ''houston'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_HOUSTON_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''result_unit: Code lookup failed'', ''houston'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_HOUSTON_SAMPLES'', row_data.source_row_number,
       ''silver_rule'', ''sample_status: Code lookup failed'', ''houston'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_curitiba_amostras AS
SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.reviewer_id AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_curitiba_amostras'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_CURITIBA_AMOSTRAS'', row_data.source_row_number,
       ''silver_rule'', ''test_type: Code lookup failed'', ''curitiba'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_CURITIBA_AMOSTRAS'', row_data.source_row_number,
       ''silver_rule'', ''result_unit: Code lookup failed'', ''curitiba'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LIMS_CURITIBA_AMOSTRAS'', row_data.source_row_number,
       ''silver_rule'', ''sample_status: Code lookup failed'', ''curitiba'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lab_muestras_ba AS
SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.site_code AS site_code,
  ''lab_muestras_ba'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LAB_MUESTRAS_BA'', row_data.source_row_number,
       ''silver_rule'', ''test_type: Code lookup failed'', ''buenos_aires'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LAB_MUESTRAS_BA'', row_data.source_row_number,
       ''silver_rule'', ''result_unit: Code lookup failed'', ''buenos_aires'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT ''LAB_MUESTRAS_BA'', row_data.source_row_number,
       ''silver_rule'', ''sample_status: Code lookup failed'', ''buenos_aires'',
       ''quarantined'', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_raw_material_master AS
SELECT row_data.source_row_number,
  row_data.canonical_material_name AS canonical_material_name,
  row_data.business_line AS business_line,
  row_data.source_material_code AS source_material_code,
  row_data.legacy_material_id AS legacy_material_id,
  row_data.cas_number AS cas_number,
  row_data.supplier AS supplier,
  row_data.supplier_grade AS supplier_grade,
  row_data.unit_of_measure AS unit_of_measure,
  row_data.density AS density,
  row_data.viscosity_grade AS viscosity_grade,
  row_data.hazard_classification AS hazard_classification,
  row_data.safety_data_sheet_ref AS safety_data_sheet_ref,
  row_data.shelf_life_months AS shelf_life_months,
  row_data.storage_conditions AS storage_conditions,
  row_data.approved_for_use AS approved_for_use,
  row_data.last_review_date AS last_review_date,
  ''raw_material_master'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.raw_material_master AS row_data WHERE NOT (FALSE)) AS row_data';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
SELECT ''MAT_'' || MD5(LOWER(TRIM(canonical_material_name))) AS material_key,
 canonical_material_name canonical_material_name, MIN(business_line) business_line, MIN(cas_number) cas_number,
 MIN(supplier) supplier, MIN(unit_of_measure) unit_of_measure,
 MIN(hazard_classification) hazard_classification, MIN(source_material_code) source_material_code,
 COUNT(*) source_record_count
FROM OGFS_DEMO.SILVER.silver_raw_material_master
GROUP BY canonical_material_name';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''status_vocabulary'' rule_name,
      ''Sample status is not present in the governed status vocabulary'' reason,
      ''annandale'' site_code,
      ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_annandale_samples b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b.sample_status)), ''[^A-Z0-9]'', '''') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), ''[^A-Z0-9]'', '''')
    WHERE b.sample_status IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''status_vocabulary'' rule_name,
      ''Sample status is not present in the governed status vocabulary'' reason,
      ''houston'' site_code,
      ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_houston_samples b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b.sample_status)), ''[^A-Z0-9]'', '''') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), ''[^A-Z0-9]'', '''')
    WHERE b.sample_status IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table,
      b.source_row_number source_row_number, ''status_vocabulary'' rule_name,
      ''Sample status is not present in the governed status vocabulary'' reason,
      ''curitiba'' site_code,
      ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b.sample_status)), ''[^A-Z0-9]'', '''') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), ''[^A-Z0-9]'', '''')
    WHERE b.sample_status IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT ''LAB_MUESTRAS_BA'' source_table,
      b.source_row_number source_row_number, ''status_vocabulary'' rule_name,
      ''Sample status is not present in the governed status vocabulary'' reason,
      ''buenos_aires'' site_code,
      ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lab_muestras_ba b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b.sample_status)), ''[^A-Z0-9]'', '''') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), ''[^A-Z0-9]'', '''')
    WHERE b.sample_status IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT ''LIMS_TEST_COPY'' source_table,
      b.source_row_number source_row_number, ''status_vocabulary'' rule_name,
      ''Sample status is not present in the governed status vocabulary'' reason,
      ''lims_test-copy'' site_code,
      ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_test_copy b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b.sample_status)), ''[^A-Z0-9]'', '''') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), ''[^A-Z0-9]'', '''')
    WHERE b.sample_status IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''annandale'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_annandale_samples b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
UNION ALL
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''houston'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_houston_samples b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
UNION ALL
SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''curitiba'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
UNION ALL
SELECT ''LAB_MUESTRAS_BA'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''buenos_aires'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lab_muestras_ba b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
UNION ALL
SELECT ''LIMS_TEST_COPY'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''lims_test-copy'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_test_copy b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_method AS
WITH methods AS (SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_houston_samples
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba)
SELECT ''MTH_'' || MD5(COALESCE(r.governed_standard_reference, m.test_type)) test_method_key,
 COALESCE(r.governed_standard_reference, m.test_type) governed_standard_reference,
 MIN(r.standard_body) standard_body, MIN(r.method_title) method_title,
 MIN(r.applies_to_business_line) applies_to_business_line, COUNT(*) source_record_count
FROM methods m LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference r
 ON REGEXP_REPLACE(UPPER(TRIM(m.test_type)), ''[^A-Z0-9]'', '''') =
    REGEXP_REPLACE(UPPER(TRIM(r.source_method_name)), ''[^A-Z0-9]'', '''')
GROUP BY COALESCE(r.governed_standard_reference, m.test_type)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_lab_sample AS SELECT ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, ''annandale'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, ''houston'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_houston_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, ''curitiba'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''buenos-aires:'' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, ''buenos-aires'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_result AS SELECT ''RES_'' || MD5(''silver_lims_annandale_samples:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_annandale_samples'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_houston_samples:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_houston_samples'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_houston_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_curitiba_amostras:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, NULL::NUMBER spec_lower_limit, NULL::NUMBER spec_upper_limit,
 IFF(s.result_value BETWEEN NULL::NUMBER AND NULL::NUMBER,TRUE,FALSE) within_spec,
 ''silver_lims_curitiba_amostras'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lab_muestras_ba:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''buenos-aires:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lab_muestras_ba'' source_system
 FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_material AS SELECT material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification FROM OGFS_DEMO.SILVER.conformed_material';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_test_method AS SELECT test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line FROM OGFS_DEMO.SILVER.conformed_test_method';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_lab_site AS SELECT column1::VARCHAR site_key,column2::VARCHAR site_code,column3::VARCHAR site_name FROM VALUES (''SITE_ANNANDALE'',''annandale'',''Annandale''),(''SITE_HOUSTON'',''houston'',''Houston''),(''SITE_CURITIBA'',''curitiba'',''Curitiba''),(''SITE_BUENOS_AIRES'',''buenos_aires'',''Buenos Aires''),(''SITE_LIMS_TEST_COPY'',''lims_test-copy'',''LIMS_TEST_COPY'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_business_line AS SELECT column1::VARCHAR business_line_key,column2::VARCHAR business_line_name FROM VALUES (''BIZ_LUBRICANTS'',''Lubricants''),(''BIZ_FUELS'',''Fuels''),(''BIZ_CHEMICALS'',''Chemicals'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_date AS SELECT TO_NUMBER(TO_CHAR(day,''YYYYMMDD'')) date_key,day full_date,YEAR(day) year,QUARTER(day) quarter,MONTH(day) month,MONTHNAME(day) month_name,WEEKOFYEAR(day) week_of_year,DAYNAME(day) day_of_week FROM (SELECT DATEADD(day,SEQ4(),''2026-01-01''::DATE) day FROM TABLE(GENERATOR(ROWCOUNT=>365)))';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.fact_lab_sample AS SELECT lab_sample_key,material_key,test_method_key,''SITE_''||UPPER(site_code) site_key,CASE LOWER(business_line) WHEN ''lubricants'' THEN ''BIZ_LUBRICANTS'' WHEN ''fuels'' THEN ''BIZ_FUELS'' WHEN ''chemicals'' THEN ''BIZ_CHEMICALS'' END business_line_key,TO_NUMBER(TO_CHAR(TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(completion_date)),''YYYYMMDD'')) date_key,DATEDIFF(day,TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(requested_date)),TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(completion_date))) turnaround_days,sample_status,source_system_count FROM OGFS_DEMO.SILVER.conformed_lab_sample';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.fact_test_result AS SELECT test_result_key,lab_sample_key,test_method_key,material_key,TO_NUMBER(TO_CHAR(TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(result_date)),''YYYYMMDD'')) date_key,result_value,result_unit,spec_lower_limit,spec_upper_limit,within_spec FROM OGFS_DEMO.SILVER.conformed_test_result';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT value::VARCHAR AS kpi_name, TRUE AS included, NULL::VARCHAR AS skip_reason
FROM TABLE(FLATTEN(INPUT => PARSE_JSON(''["Cross-Lab Data Standardization Rate","Cross-Lab Reproducibility Index","Cross-Site Result Correlation","Duplicate Test Rate Across Labs","Inter-Site Result Deviation","Site-Pair Agreement by Method","Test Method Standardization Rate","Unmatched Sample Rate","Backlog Aging Index","First-Time-Right Rate","Instrument Throughput","LIMS Data Completeness","Lab Capacity Utilization","Retest Rate","Sample Turnaround Time","Sample Volume Trend"]'')))
UNION ALL
SELECT value::VARCHAR, FALSE, ''Inputs are outside the chosen process tables''
FROM TABLE(FLATTEN(INPUT => PARSE_JSON(''["Business Line Activity Growth","Cycle Time by Gate"]'')))';
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.full_pipeline_task
  WAREHOUSE = OGFS_DEMO_WH SCHEDULE = 'USING CRON 0 6 * * * America/Chicago'
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2
AS CALL OGFS_DEMO.BRONZE.run_full_pipeline();
