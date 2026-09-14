-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_material" (material_key text PRIMARY KEY, canonical_material_name text, business_line text, cas_number text, supplier text, unit_of_measure text, hazard_classification text);

-- foundation:stage 8
INSERT INTO gold.dim_material SELECT material_key, canonical_material_name, business_line, cas_number, supplier, unit_of_measure, hazard_classification FROM silver.conformed_material;
