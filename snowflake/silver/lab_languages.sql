-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.lab_languages AS
SELECT column1::VARCHAR site_code, column2::VARCHAR source_language
FROM VALUES ('annandale','English'),
('houston','English'),
('curitiba','Portuguese'),
('buenos_aires','Spanish');
