-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_lab_site" (site_key text PRIMARY KEY, site_code text, site_name text, lims_platform text);

-- foundation:stage 8
INSERT INTO gold.dim_lab_site VALUES
          ('SITE_ANNANDALE','annandale','Annandale Laboratory','LabWare'),
          ('SITE_HOUSTON','houston','Houston Laboratory','Thermo Fisher SampleManager'),
          ('SITE_CURITIBA','curitiba','Curitiba Laboratory','LabVantage'),
          ('SITE_BUENOS_AIRES','buenos_aires','Buenos Aires Laboratory','Custom in-house');
