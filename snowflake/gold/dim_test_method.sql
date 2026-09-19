-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_test_method AS SELECT test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line FROM OGFS_DEMO.SILVER.conformed_test_method;
