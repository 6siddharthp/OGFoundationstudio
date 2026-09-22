-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_lab_site AS SELECT s.site_key,s.site_code,s.site_name FROM (SELECT source_raw.site_key,source_raw.site_code,source_raw.site_name FROM (SELECT column1::VARCHAR site_key,column2::VARCHAR site_code,column3::VARCHAR site_name FROM VALUES ('SITE_ANNANDALE','annandale','Annandale'),('SITE_HOUSTON','houston','Houston'),('SITE_CURITIBA','curitiba','Curitiba'),('SITE_BUENOS_AIRES','buenos_aires','Buenos Aires')) source_raw) s;
