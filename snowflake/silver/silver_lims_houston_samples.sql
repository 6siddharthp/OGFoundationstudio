-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_houston_samples AS
SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT ref.governed_standard_reference FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
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
  COALESCE((SELECT ref.governed_unit FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT ref.governed_status FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  'lims_houston_samples' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data WHERE NOT (COALESCE(((SELECT ref.governed_standard_reference FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT ref.governed_unit FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT ref.governed_status FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data;

INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT 'LIMS_HOUSTON_SAMPLES', row_data.source_row_number,
       'silver_rule', 'test_type: Code lookup failed', 'houston',
       'quarantined', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT ref.governed_standard_reference FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL;

INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT 'LIMS_HOUSTON_SAMPLES', row_data.source_row_number,
       'silver_rule', 'result_unit: Code lookup failed', 'houston',
       'quarantined', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT ref.governed_unit FROM OGFS_DEMO.SILVER.governed_uom_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_unit AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL;

INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT 'LIMS_HOUSTON_SAMPLES', row_data.source_row_number,
       'silver_rule', 'sample_status: Code lookup failed', 'houston',
       'quarantined', OBJECT_CONSTRUCT_KEEP_NULL(row_data.*), CURRENT_TIMESTAMP()
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
WHERE (SELECT ref.governed_status FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL;
