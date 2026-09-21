-- Foundation Studio · generated orchestration
CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_run_log (
  step_name VARCHAR, source_table VARCHAR, status VARCHAR, rows_written NUMBER,
  started_at TIMESTAMP_TZ, completed_at TIMESTAMP_TZ, query_id VARCHAR
);
CREATE TABLE IF NOT EXISTS OGFS_DEMO.BRONZE.orchestration_events (source_table VARCHAR, loaded_at TIMESTAMP_TZ);
CREATE OR REPLACE STREAM OGFS_DEMO.BRONZE.orchestration_events_stream ON TABLE OGFS_DEMO.BRONZE.orchestration_events;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LAB_MUESTRAS_BA','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lab_muestras_ba;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_ANNANDALE_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_annandale_samples;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_CURITIBA_AMOSTRAS','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','LIMS_HOUSTON_SAMPLES','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.lims_houston_samples;
INSERT INTO OGFS_DEMO.BRONZE.orchestration_run_log(step_name,source_table,status,rows_written,started_at,completed_at,query_id)
SELECT 'initial_deploy','RAW_MATERIAL_MASTER','SUCCEEDED',COUNT(*),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),LAST_QUERY_ID()
FROM OGFS_DEMO.BRONZE.raw_material_master;

CREATE OR REPLACE PROCEDURE OGFS_DEMO.BRONZE.run_full_pipeline()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
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
       DATE_REQUESTED::VARCHAR AS reviewer_id,
       DATE_RECEIVED::VARCHAR AS date_requested,
       DATE_STARTED::VARCHAR AS date_received,
       DATE_COMPLETED::VARCHAR AS date_started,
       PRIORITY::VARCHAR AS date_completed,
       SUBMITTER::VARCHAR AS priority,
       PROJECT_REFERENCE::VARCHAR AS submitter,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS project_reference,
       RESULT_UNIT::VARCHAR AS result_value,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_LOWER_LIMIT), 38, 10)::NUMBER AS result_unit,
       TRY_TO_DECIMAL(TO_VARCHAR(SPEC_UPPER_LIMIT), 38, 10)::NUMBER AS spec_lower_limit,
       SAMPLE_STATUS::VARCHAR AS spec_upper_limit,
       APPROVAL_STATUS::VARCHAR AS sample_status,
       APPROVAL_DATE::VARCHAR AS approval_status,
       STORAGE_LOCATION::VARCHAR AS approval_date,
       TRY_TO_BOOLEAN(TO_VARCHAR(RETEST_FLAG))::BOOLEAN AS storage_location,
       SITE_CODE::VARCHAR AS retest_flag,
       REVISOR_USUARIO::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LAB_MUESTRAS_BA';
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
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.not_captured_at_source AS
SELECT column1::VARCHAR source_table,column2::VARCHAR site_code,column3::VARCHAR site_name,
       column4::VARCHAR canonical_field,column5::VARCHAR reason
FROM VALUES (''LAB_MUESTRAS_BA'',''buenos-aires'',''Buenos Aires'',''comments'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''project_reference'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''spec_lower_limit'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''spec_upper_limit'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''approval_date'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''storage_location'',''Not captured at source'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.rule_skips (
  source_table VARCHAR,site_code VARCHAR,canonical_field VARCHAR,rule_type VARCHAR,
  unavailable_inputs ARRAY,reason VARCHAR,recorded_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
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
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_buenos_aires AS
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
  NULL AS comments,
  row_data.site_code AS site_code,
  ''lab_muestras_ba'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
       ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''buenos-aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
       ''uom_vocabulary'' rule_name, ''result_unit: Code lookup failed'' reason,
       ''buenos-aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
       ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''buenos-aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_annandale AS
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
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
       ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
       ''uom_vocabulary'' rule_name, ''result_unit: Code lookup failed'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
       ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_curitiba AS
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
  NULL AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  NULL AS spec_lower_limit,
  NULL AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  NULL AS approval_date,
  NULL AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_curitiba_amostras'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE 'INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
       ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
       ''uom_vocabulary'' rule_name, ''result_unit: Code lookup failed'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
       ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_houston AS
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
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
       ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
       ''uom_vocabulary'' rule_name, ''result_unit: Code lookup failed'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
       ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
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
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_identity_map AS
WITH base AS (
  SELECT DISTINCT source_material_code, legacy_material_id, canonical_material_name, cas_number,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), ''[^A-Z0-9]'', '''') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), ''[^A-Z0-9]'', ''''), '''') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
canonical_targets AS (
  SELECT * FROM base WHERE legacy_material_id LIKE ''MAT-%''
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY legacy_material_id
    ORDER BY LENGTH(canonical_material_name) DESC,normalized_name,source_material_code
  )=1
),
ranked_targets AS (
  SELECT b.source_material_code,t.normalized_name target_name,
    JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) similarity_score,
    CASE WHEN b.legacy_material_id=t.legacy_material_id THEN ''raw_material_master_xref''
         WHEN b.normalized_cas=t.normalized_cas THEN ''cas_number''
         ELSE ''canonical_name_similarity'' END match_rule,
    ROW_NUMBER() OVER (PARTITION BY b.source_material_code ORDER BY
      IFF(b.legacy_material_id=t.legacy_material_id,1,0) DESC,
      IFF(b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas,1,0) DESC,
      JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) DESC,
      t.normalized_name) target_rank
  FROM base b JOIN canonical_targets t ON
    b.legacy_material_id=t.legacy_material_id
    OR (b.legacy_material_id LIKE ''LGC-%'' AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas)
    OR ((b.normalized_cas IS NULL OR t.normalized_cas IS NULL)
      AND JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) >= 85)
),
resolved AS (
  SELECT b.*,r.target_name,r.match_rule
  FROM base b LEFT JOIN ranked_targets r ON r.source_material_code=b.source_material_code AND r.target_rank=1
)
SELECT source_material_code,canonical_material_name,cas_number,
  ''MAT_''||MD5(COALESCE(target_name,normalized_name)) material_key,
  COALESCE(match_rule,''unmatched_source_record'') match_rule,85 similarity_threshold
FROM resolved';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_candidates AS
WITH base AS (
  SELECT DISTINCT i.material_key,m.source_material_code,m.canonical_material_name,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), ''[^A-Z0-9]'', '''') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), ''[^A-Z0-9]'', ''''), '''') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m JOIN OGFS_DEMO.SILVER.material_identity_map i USING (source_material_code)
  WHERE m.source_material_code IS NOT NULL AND m.canonical_material_name IS NOT NULL
),
pairs AS (
  SELECT l.material_key left_material_key,r.material_key right_material_key,
    l.source_material_code left_code,r.source_material_code right_code,
    l.canonical_material_name left_name,r.canonical_material_name right_name,
    JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name) similarity_score
  FROM base l JOIN base r ON l.material_key < r.material_key
  WHERE NOT (l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas)
)
SELECT left_material_key,right_material_key,MIN(left_code) left_code,MIN(right_code) right_code,
  MIN(left_name) left_name,MIN(right_name) right_name,MAX(similarity_score) similarity_score,
  85 similarity_threshold,''candidate_review'' review_status
FROM pairs
WHERE similarity_score < 85 AND similarity_score >= 85*0.75
GROUP BY left_material_key,right_material_key
QUALIFY ROW_NUMBER() OVER (PARTITION BY left_material_key ORDER BY MAX(similarity_score) DESC,right_material_key)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
SELECT i.material_key,
 MAX_BY(m.canonical_material_name,LENGTH(m.canonical_material_name)) canonical_material_name,
 MIN(m.business_line) business_line, MIN(m.cas_number) cas_number,
 MIN(m.supplier) supplier, MIN(m.unit_of_measure) unit_of_measure,
 MIN(m.hazard_classification) hazard_classification, MIN(m.source_material_code) source_material_code,
 COUNT(*) source_record_count, COUNT(DISTINCT m.canonical_material_name) source_name_count
FROM OGFS_DEMO.SILVER.silver_raw_material_master m
JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code
GROUP BY i.material_key';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT ''LAB_MUESTRAS_BA'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''buenos-aires'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lab_muestras_ba b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
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
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''houston'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_houston_samples b
    LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
    WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_method AS
WITH methods AS (SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_annandale
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_curitiba
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_houston)
SELECT ''MTH_'' || MD5(COALESCE(r.governed_standard_reference, m.test_type)) test_method_key,
 COALESCE(r.governed_standard_reference, m.test_type) governed_standard_reference,
 MIN(r.standard_body) standard_body, MIN(r.method_title) method_title,
 MIN(r.applies_to_business_line) applies_to_business_line, COUNT(*) source_record_count
FROM methods m LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference r
 ON REGEXP_REPLACE(UPPER(TRIM(m.test_type)), ''[^A-Z0-9]'', '''') =
    REGEXP_REPLACE(UPPER(TRIM(r.source_method_name)), ''[^A-Z0-9]'', '''')
GROUP BY COALESCE(r.governed_standard_reference, m.test_type)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_lab_sample AS SELECT ''SMP_'' || MD5(''buenos-aires:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''buenos-aires'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''annandale'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_annandale s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''curitiba'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''houston'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_houston s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_result AS SELECT ''RES_'' || MD5(''silver_lims_buenos_aires:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''buenos-aires:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_buenos_aires'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_annandale:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_annandale'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_annandale s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_curitiba:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_curitiba'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_houston:'' || s.source_row_number) test_result_key,
 ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 ''silver_lims_houston'' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_houston s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_material AS SELECT material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification FROM OGFS_DEMO.SILVER.conformed_material';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_test_method AS SELECT test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line FROM OGFS_DEMO.SILVER.conformed_test_method';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_lab_site AS SELECT column1::VARCHAR site_key,column2::VARCHAR site_code,column3::VARCHAR site_name FROM VALUES (''SITE_BUENOS_AIRES'',''buenos-aires'',''Buenos Aires''),(''SITE_ANNANDALE'',''annandale'',''Annandale''),(''SITE_CURITIBA'',''curitiba'',''Curitiba''),(''SITE_HOUSTON'',''houston'',''Houston'')';
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
SELECT column1::VARCHAR kpi_name,column2::BOOLEAN included,column3::VARCHAR skip_reason,
       column4::VARIANT site_policy,column5::VARCHAR policy_summary
FROM VALUES (''Cross-Lab Data Standardization Rate'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Cross-Lab Reproducibility Index'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Cross-Site Result Correlation'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Duplicate Test Rate Across Labs'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Inter-Site Result Deviation'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Site-Pair Agreement by Method'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Test Method Standardization Rate'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Unmatched Sample Rate'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Backlog Aging Index'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''First-Time-Right Rate'',TRUE,NULL,PARSE_JSON(''[{siteId:curitiba,siteName:Curitiba,fields:[spec_lower_limit,spec_upper_limit],reason:"Excluded because spec_lower_limit and spec_upper_limit are not captured at source."}]''),''Excludes Curitiba from this KPI calculation.''),
(''Instrument Throughput'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''LIMS Data Completeness'',TRUE,NULL,PARSE_JSON(''[{siteId:"buenos-aires",siteName:"Buenos Aires",fields:[comments],reason:"Not captured at source; counted as 1 completeness gap."},{siteId:curitiba,siteName:Curitiba,fields:[project_reference,spec_lower_limit,spec_upper_limit,approval_date,storage_location],reason:"Not captured at source; counted as 5 completeness gaps."}]''),''Buenos Aires, Curitiba source gaps are included in the completeness denominator.''),
(''Lab Capacity Utilization'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Retest Rate'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Sample Turnaround Time'',TRUE,NULL,PARSE_JSON(''[]''),''''),
(''Sample Volume Trend'',TRUE,NULL,PARSE_JSON(''[]''),'''')';
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.BRONZE.full_pipeline_task
  WAREHOUSE = OGFS_DEMO_WH SCHEDULE = 'USING CRON 0 6 * * * America/Chicago'
  USER_TASK_TIMEOUT_MS = 3600000
  SUSPEND_TASK_AFTER_NUM_FAILURES = 2
AS CALL OGFS_DEMO.BRONZE.run_full_pipeline();
