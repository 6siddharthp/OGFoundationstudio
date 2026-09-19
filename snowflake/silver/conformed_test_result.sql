-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_result AS SELECT 'RES_' || MD5('silver_lims_annandale_samples:' || source_row_number) test_result_key,
 'SMP_' || MD5('annandale:' || source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, s.date_completed result_date,
 s.result_value, s.result_unit, s.spec_lower_limit, s.spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_annandale_samples' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
      REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lims_houston_samples:' || source_row_number) test_result_key,
 'SMP_' || MD5('houston:' || source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, s.date_completed result_date,
 s.result_value, s.result_unit, s.spec_lower_limit, s.spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_houston_samples' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_houston_samples s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
      REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lims_curitiba_amostras:' || source_row_number) test_result_key,
 'SMP_' || MD5('curitiba:' || source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, s.date_completed result_date,
 s.result_value, s.result_unit, s.spec_lower_limit, s.spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_curitiba_amostras' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
      REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lab_muestras_ba:' || source_row_number) test_result_key,
 'SMP_' || MD5('buenos-aires:' || source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, s.date_completed result_date,
 s.result_value, s.result_unit, s.spec_lower_limit, s.spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lab_muestras_ba' source_system
 FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba s
 LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON LOWER(m.source_material_code)=LOWER(s.material_code)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
      REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '');
