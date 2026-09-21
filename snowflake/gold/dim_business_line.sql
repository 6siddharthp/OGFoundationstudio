-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_business_line AS SELECT column1::VARCHAR business_line_key,column2::VARCHAR business_line_name FROM VALUES ('BIZ_LUBRICANTS','Lubricants'),('BIZ_FUELS','Fuels'),('BIZ_CHEMICALS','Chemicals');
