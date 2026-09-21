-- Foundation Studio · Snowflake execution SQL
-- Foundation Studio · Snowflake execution SQL - Sid 9 20 6 40 am

-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_material AS SELECT material_key,canonical_material_name,business_line,cas_number,supplier,unit_of_measure,hazard_classification FROM OGFS_DEMO.SILVER.conformed_material;
