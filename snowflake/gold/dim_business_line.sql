-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_business_line AS SELECT s.business_line_key,s.business_line_name FROM (SELECT source_raw.business_line_key,source_raw.business_line_name FROM (SELECT DISTINCT business_line_key,business_line_name FROM OGFS_DEMO.SILVER.business_line_mapping) source_raw) s;
