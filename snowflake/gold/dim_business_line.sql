-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_business_line AS SELECT s.business_line_key,s.business_line_name FROM (SELECT source_raw.business_line_key,source_raw.business_line_name FROM (SELECT column1::VARCHAR business_line_key,column2::VARCHAR business_line_name FROM VALUES ('BIZ_LUBRICANTS','Lubricants'),('BIZ_FUELS','Fuels'),('BIZ_CHEMICALS','Chemicals')) source_raw) s;
