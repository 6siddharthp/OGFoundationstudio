-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
WITH base AS (
  SELECT i.material_key,
   MIN(m.source_material_code) source_material_code,
   COUNT(*) source_record_count, COUNT(DISTINCT m.canonical_material_name) source_name_count
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m
  JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code
  GROUP BY i.material_key
)
SELECT b.material_key,
 MAX(IFF(l.attribute='canonical_material_name',l.winning_value,NULL)) canonical_material_name,
 MAX(IFF(l.attribute='business_line',l.winning_value,NULL)) business_line,
 MAX(IFF(l.attribute='cas_number',l.winning_value,NULL)) cas_number,
 MAX(IFF(l.attribute='supplier',l.winning_value,NULL)) supplier,
 MAX(IFF(l.attribute='unit_of_measure',l.winning_value,NULL)) unit_of_measure,
 MAX(IFF(l.attribute='hazard_classification',l.winning_value,NULL)) hazard_classification,
 MAX(IFF(l.attribute='safety_data_sheet_ref',l.winning_value,NULL)) safety_data_sheet_ref,
 b.source_material_code,b.source_record_count,b.source_name_count
 FROM base b LEFT JOIN OGFS_DEMO.SILVER.golden_attribute_lineage l ON l.material_key=b.material_key
 GROUP BY b.material_key,b.source_material_code,b.source_record_count,b.source_name_count
 UNION ALL
 SELECT o.golden_key material_key,
   o.golden_values:canonical_material_name::VARCHAR canonical_material_name,
   o.golden_values:business_line::VARCHAR business_line,
   o.golden_values:cas_number::VARCHAR cas_number,
   o.golden_values:supplier::VARCHAR supplier,
   o.golden_values:unit_of_measure::VARCHAR unit_of_measure,
   o.golden_values:hazard_classification::VARCHAR hazard_classification,
   o.golden_values:safety_data_sheet_ref::VARCHAR safety_data_sheet_ref,
   o.source_material_code,1 source_record_count,1 source_name_count
  FROM (SELECT * FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1) o
  WHERE o.action='create'
   AND NOT EXISTS (SELECT 1 FROM OGFS_DEMO.SILVER.silver_raw_material_master m
     WHERE LOWER(m.source_material_code)=LOWER(o.source_material_code))
 QUALIFY ROW_NUMBER() OVER (PARTITION BY o.golden_key ORDER BY o.decided_at DESC,o.action_id DESC)=1;
