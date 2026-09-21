-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
SELECT i.material_key,
 MAX_BY(m.canonical_material_name,LENGTH(m.canonical_material_name)) canonical_material_name,
 MIN(m.business_line) business_line, MIN(m.cas_number) cas_number,
 MIN(m.supplier) supplier, MIN(m.unit_of_measure) unit_of_measure,
 MIN(m.hazard_classification) hazard_classification, MIN(m.source_material_code) source_material_code,
 COUNT(*) source_record_count, COUNT(DISTINCT m.canonical_material_name) source_name_count
FROM OGFS_DEMO.SILVER.silver_raw_material_master m
JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code
GROUP BY i.material_key;
