-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."fact_lab_sample" (lab_sample_key text PRIMARY KEY, material_key text REFERENCES gold.dim_material(material_key), test_method_key text REFERENCES gold.dim_test_method(test_method_key), site_key text REFERENCES gold.dim_lab_site(site_key), business_line_key text REFERENCES gold.dim_business_line(business_line_key), date_key integer REFERENCES gold.dim_date(date_key), turnaround_days numeric, sample_status text, source_system_count integer);

-- foundation:stage 9
INSERT INTO gold.fact_lab_sample
          SELECT lab_sample_key, material_key, test_method_key,
            'SITE_' || upper(site_code),
            CASE lower(business_line) WHEN 'lubricants' THEN 'BIZ_LUBRICANTS' WHEN 'fuels' THEN 'BIZ_FUELS' WHEN 'chemicals' THEN 'BIZ_CHEMICALS' END,
            to_char(completion_date,'YYYYMMDD')::integer,
            extract(epoch from (completion_date-requested_date))/86400, sample_status, source_system_count
          FROM silver.conformed_lab_sample;
