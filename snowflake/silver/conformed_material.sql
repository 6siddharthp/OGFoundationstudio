-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
WITH base AS (
  SELECT i.material_key,
   MAX_BY(m.canonical_material_name,LENGTH(m.canonical_material_name)) canonical_material_name,
   MIN(m.business_line) business_line, MIN(m.cas_number) cas_number,
   MIN(m.supplier) supplier, MIN(m.unit_of_measure) unit_of_measure,
   MIN(m.hazard_classification) hazard_classification, MIN(m.source_material_code) source_material_code,
   COUNT(*) source_record_count, COUNT(DISTINCT m.canonical_material_name) source_name_count
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m
  JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code
  GROUP BY i.material_key
),
overrides AS (
  SELECT golden_key,
    MAX_BY(golden_values,decided_at) golden_values
  FROM OGFS_DEMO.SILVER.golden_record_overrides
  WHERE action IN ('attach','create')
  GROUP BY golden_key
)
SELECT b.material_key,
 COALESCE(o.golden_values:canonicalMaterialName::VARCHAR,b.canonical_material_name) canonical_material_name,
 COALESCE(o.golden_values:businessLine::VARCHAR,b.business_line) business_line,
 COALESCE(o.golden_values:casNumber::VARCHAR,b.cas_number) cas_number,
 COALESCE(o.golden_values:supplier::VARCHAR,b.supplier) supplier,
 COALESCE(o.golden_values:unitOfMeasure::VARCHAR,b.unit_of_measure) unit_of_measure,
 COALESCE(o.golden_values:hazardClassification::VARCHAR,b.hazard_classification) hazard_classification,
 b.source_material_code,b.source_record_count,b.source_name_count
FROM base b LEFT JOIN overrides o ON o.golden_key=b.material_key;
