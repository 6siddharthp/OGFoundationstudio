-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
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
  'lab_muestras_ba' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data;

-- foundation:stage 3
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT 'LAB_MUESTRAS_BA' source_table, row_data.source_row_number,
       'test_method_vocabulary' rule_name, 'test_type: Code lookup failed' reason,
       'buenos_aires' site_code,
       'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT 'LAB_MUESTRAS_BA' source_table, row_data.source_row_number,
       'uom_vocabulary' rule_name, 'result_unit: Code lookup failed' reason,
       'buenos_aires' site_code,
       'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_unit) FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT 'LAB_MUESTRAS_BA' source_table, row_data.source_row_number,
       'status_vocabulary' rule_name, 'sample_status: Code lookup failed' reason,
       'buenos_aires' site_code,
       'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1;
