-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
SELECT 'MAT_' || MD5(LOWER(TRIM(canonical_material_name))) AS material_key,
 canonical_material_name, MIN(business_line) business_line, MIN(cas_number) cas_number,
 MIN(supplier) supplier, MIN(unit_of_measure) unit_of_measure,
 MIN(hazard_classification) hazard_classification, MIN(source_material_code) source_material_code,
 COUNT(*) source_record_count
FROM OGFS_DEMO.SILVER.silver_raw_material_master
GROUP BY canonical_material_name;
