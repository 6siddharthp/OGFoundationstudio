-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT 'LIMS_ANNANDALE_SAMPLES' source_table,
      b.source_row_number source_row_number, 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'annandale' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_annandale_samples b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER('LIMS_ANNANDALE_SAMPLES')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN ('attach','create'))
UNION ALL
SELECT 'LIMS_HOUSTON_SAMPLES' source_table,
      b.source_row_number source_row_number, 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'houston' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_houston_samples b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER('LIMS_HOUSTON_SAMPLES')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN ('attach','create'))
UNION ALL
SELECT 'LIMS_CURITIBA_AMOSTRAS' source_table,
      b.source_row_number source_row_number, 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'curitiba' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER('LIMS_CURITIBA_AMOSTRAS')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN ('attach','create'))
UNION ALL
SELECT 'LAB_MUESTRAS_BA' source_table,
      b.source_row_number source_row_number, 'material_master_reference' rule_name,
      'Material code is missing from RAW_MATERIAL_MASTER and requires review' reason,
      'buenos_aires' site_code,
      'flagged_for_review' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lab_muestras_ba b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER('LAB_MUESTRAS_BA')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN ('attach','create')));
