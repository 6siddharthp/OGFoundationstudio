-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.conformed_lab_sample (
            lab_sample_key text PRIMARY KEY, material_key text, test_method_key text, site_code text,
            business_line text, completion_date timestamp, requested_date timestamp, sample_status text,
            source_system_count integer NOT NULL
          );

-- foundation:stage 6
INSERT INTO silver.conformed_lab_sample (
            lab_sample_key, material_key, test_method_key, site_code, business_line, completion_date,
            requested_date, sample_status, source_system_count
          )
          
          SELECT 'SMP_' || md5('buenos_aires:' || source_row_number), 
            'MAT_' || md5(lower(trim(material_code))) material_key,
            'MTH_' || md5(test_type) test_method_key,
            'buenos_aires' site_code, product_line business_line, date_completed completion_date,
            date_requested requested_date, sample_status, 1 source_system_count
          FROM silver."silver_lims_buenos_aires" UNION ALL 
          SELECT 'SMP_' || md5('annandale:' || source_row_number), 
            'MAT_' || md5(lower(trim(material_code))) material_key,
            'MTH_' || md5(test_type) test_method_key,
            'annandale' site_code, product_line business_line, date_completed completion_date,
            date_requested requested_date, sample_status, 1 source_system_count
          FROM silver."silver_lims_annandale" UNION ALL 
          SELECT 'SMP_' || md5('curitiba:' || source_row_number), 
            'MAT_' || md5(lower(trim(material_code))) material_key,
            'MTH_' || md5(test_type) test_method_key,
            'curitiba' site_code, product_line business_line, date_completed completion_date,
            date_requested requested_date, sample_status, 1 source_system_count
          FROM silver."silver_lims_curitiba" UNION ALL 
          SELECT 'SMP_' || md5('houston:' || source_row_number), 
            'MAT_' || md5(lower(trim(material_code))) material_key,
            'MTH_' || md5(test_type) test_method_key,
            'houston' site_code, product_line business_line, date_completed completion_date,
            date_requested requested_date, sample_status, 1 source_system_count
          FROM silver."silver_lims_houston";
