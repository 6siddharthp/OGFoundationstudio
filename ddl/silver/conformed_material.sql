-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.conformed_material (
            material_key text PRIMARY KEY, canonical_material_name text, business_line text, cas_number text,
            supplier text, unit_of_measure text, hazard_classification text,
            source_material_code text,
            source_record_count integer NOT NULL
          );

-- foundation:stage 6
INSERT INTO silver.conformed_material (
            material_key, canonical_material_name, business_line, cas_number, supplier, unit_of_measure,
            hazard_classification, source_material_code, source_record_count
          )
          SELECT 'MAT_' || md5(lower(trim(canonical_material_name))), canonical_material_name,
            min(business_line), min(cas_number), min(supplier), min(unit_of_measure),
            min(hazard_classification), min(source_material_code), count(*)::integer
          FROM silver."silver_raw_material_master"
          GROUP BY canonical_material_name;
