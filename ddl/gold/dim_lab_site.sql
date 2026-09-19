-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_lab_site" (site_key text PRIMARY KEY, site_code text, site_name text);

-- foundation:stage 8
INSERT INTO gold.dim_lab_site VALUES
          ('SITE_ANNANDALE','annandale','Annandale'),
          ('SITE_HOUSTON','houston','Houston'),
          ('SITE_CURITIBA','curitiba','Curitiba'),
          ('SITE_BUENOS_AIRES','buenos_aires','Buenos Aires');
