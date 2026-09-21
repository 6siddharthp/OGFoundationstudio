-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_result AS SELECT 'RES_' || MD5('silver_lims_buenos_aires:' || s.source_row_number) test_result_key,
 'SMP_' || MD5('buenos-aires:' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_buenos_aires' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lims_annandale:' || s.source_row_number) test_result_key,
 'SMP_' || MD5('annandale:' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_annandale' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_annandale s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lims_curitiba:' || s.source_row_number) test_result_key,
 'SMP_' || MD5('curitiba:' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_curitiba' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '')
UNION ALL
SELECT 'RES_' || MD5('silver_lims_houston:' || s.source_row_number) test_result_key,
 'SMP_' || MD5('houston:' || s.source_row_number) lab_sample_key,
 tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
 s.result_value result_value, s.result_unit result_unit, s.spec_lower_limit spec_lower_limit, s.spec_upper_limit spec_upper_limit,
 IFF(s.result_value BETWEEN s.spec_lower_limit AND s.spec_upper_limit,TRUE,FALSE) within_spec,
 'silver_lims_houston' source_system
 FROM OGFS_DEMO.SILVER.silver_lims_houston s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
  LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=mi.material_key
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), '[^A-Z0-9]', '') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '');
