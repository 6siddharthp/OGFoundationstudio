-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.business_line_mapping AS
SELECT column1::VARCHAR business_line_key,column2::VARCHAR business_line_name,
  NULLIF(column3::VARCHAR,'') source_product_line
FROM VALUES ('BIZ_LUBRICANTS','Lubricants','Lubricants'),
('BIZ_FUELS','Fuels','Fuels'),
('BIZ_CHEMICALS','Chemicals','Chemicals'),
('BIZ_UNASSIGNED','Unassigned','');
