-- Foundation Studio · Snowflake execution SQL
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT 'LIMS_ANNANDALE_SAMPLES' source_table,
      b."source_row_number", 'status_vocabulary' rule_name,
      'Sample status is not present in the governed status vocabulary' reason,
      'annandale' site_code,
      'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_annandale_samples" b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b."sample_status")), '[^A-Z0-9]', '') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), '[^A-Z0-9]', '')
    WHERE b."sample_status" IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT 'LIMS_HOUSTON_SAMPLES' source_table,
      b."source_row_number", 'status_vocabulary' rule_name,
      'Sample status is not present in the governed status vocabulary' reason,
      'houston' site_code,
      'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_houston_samples" b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b."sample_status")), '[^A-Z0-9]', '') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), '[^A-Z0-9]', '')
    WHERE b."sample_status" IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT 'LIMS_CURITIBA_AMOSTRAS' source_table,
      b."source_row_number", 'status_vocabulary' rule_name,
      'Sample status is not present in the governed status vocabulary' reason,
      'curitiba' site_code,
      'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_curitiba_amostras" b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b."sample_status")), '[^A-Z0-9]', '') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), '[^A-Z0-9]', '')
    WHERE b."sample_status" IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT 'LAB_MUESTRAS_BA' source_table,
      b."source_row_number", 'status_vocabulary' rule_name,
      'Sample status is not present in the governed status vocabulary' reason,
      'buenos-aires' site_code,
      'quarantined' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lab_muestras_ba" b
    LEFT JOIN OGFS_DEMO.SILVER.governed_sample_status_reference r
      ON REGEXP_REPLACE(UPPER(TRIM(b."sample_status")), '[^A-Z0-9]', '') =
         REGEXP_REPLACE(UPPER(TRIM(r.source_value)), '[^A-Z0-9]', '')
    WHERE b."sample_status" IS NOT NULL AND r.source_value IS NULL
UNION ALL
SELECT 'LIMS_ANNANDALE_SAMPLES' source_table,
      b."source_row_number", 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'annandale' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_annandale_samples" b
    LEFT JOIN OGFS_DEMO.SILVER.conformed_material m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b."material_code"))
    WHERE b."material_code" IS NOT NULL AND m.material_key IS NULL
UNION ALL
SELECT 'LIMS_HOUSTON_SAMPLES' source_table,
      b."source_row_number", 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'houston' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_houston_samples" b
    LEFT JOIN OGFS_DEMO.SILVER.conformed_material m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b."material_code"))
    WHERE b."material_code" IS NOT NULL AND m.material_key IS NULL
UNION ALL
SELECT 'LIMS_CURITIBA_AMOSTRAS' source_table,
      b."source_row_number", 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'curitiba' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lims_curitiba_amostras" b
    LEFT JOIN OGFS_DEMO.SILVER.conformed_material m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b."material_code"))
    WHERE b."material_code" IS NOT NULL AND m.material_key IS NULL
UNION ALL
SELECT 'LAB_MUESTRAS_BA' source_table,
      b."source_row_number", 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'buenos-aires' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE."lab_muestras_ba" b
    LEFT JOIN OGFS_DEMO.SILVER.conformed_material m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b."material_code"))
    WHERE b."material_code" IS NOT NULL AND m.material_key IS NULL);
