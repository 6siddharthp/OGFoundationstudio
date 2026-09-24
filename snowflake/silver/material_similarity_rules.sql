-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_similarity_rules AS
SELECT column1::NUMBER(8,2) name_similarity_threshold,column2::NUMBER(8,2) review_band_floor,column3::NUMBER rule_version
FROM VALUES (85,63.75,1);
