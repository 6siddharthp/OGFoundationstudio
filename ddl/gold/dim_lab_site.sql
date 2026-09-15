-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_lab_site" (site_key text PRIMARY KEY, site_code text, site_name text, lims_platform text);

-- foundation:stage 8
INSERT INTO gold.dim_lab_site VALUES ('SITE_CLINTON','CLINTON','Clinton Laboratory','LIMS Clinton'),('SITE_HOUSTON','HOUSTON','Houston Laboratory','LIMS Houston');
