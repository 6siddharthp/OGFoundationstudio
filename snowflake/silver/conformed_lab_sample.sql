-- Foundation Studio · Snowflake execution SQL
-- Foundation Studio · Snowflake execution SQL 9 20 7-07

CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_lab_sample AS SELECT 'SMP_' || MD5('annandale:' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, 'annandale' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'SMP_' || MD5('houston:' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, 'houston' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_houston_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'SMP_' || MD5('curitiba:' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, 'curitiba' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'SMP_' || MD5('buenos-aires:' || s.source_row_number) lab_sample_key,
 m.material_key, tm.test_method_key, 'buenos-aires' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '');
