-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_lab_site AS SELECT column1::VARCHAR site_key,column2::VARCHAR site_code,column3::VARCHAR site_name FROM VALUES ('SITE_ANNANDALE','annandale','Annandale'),('SITE_HOUSTON','houston','Houston'),('SITE_CURITIBA','curitiba','Curitiba'),('SITE_BUENOS_AIRES','buenos-aires','Buenos Aires');
