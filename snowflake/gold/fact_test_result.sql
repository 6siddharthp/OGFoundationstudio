-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.fact_test_result AS SELECT test_result_key,lab_sample_key,test_method_key,material_key,TO_NUMBER(TO_CHAR(TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(result_date)),'YYYYMMDD')) date_key,result_value,result_unit,spec_lower_limit,spec_upper_limit,within_spec FROM OGFS_DEMO.SILVER.conformed_test_result;
