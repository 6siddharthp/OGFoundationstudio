-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.golden_attribute_lineage AS
WITH source_values AS (
  SELECT i.material_key,m.source_material_code,
    m.legacy_material_id master_role_value,
    TRY_TO_DATE(TO_VARCHAR(m.last_review_date)) last_review_date,
    f.key::VARCHAR attribute,NULLIF(TRIM(f.value::VARCHAR),'') candidate_value
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m
  JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code,
  LATERAL FLATTEN(INPUT=>OBJECT_CONSTRUCT_KEEP_NULL(
    'canonical_material_name',m.canonical_material_name,'business_line',m.business_line,
    'cas_number',m.cas_number,'supplier',m.supplier,'unit_of_measure',m.unit_of_measure,
    'hazard_classification',m.hazard_classification,'safety_data_sheet_ref',m.safety_data_sheet_ref
  )) f
  WHERE NULLIF(TRIM(f.value::VARCHAR),'') IS NOT NULL
), ranked AS (
  SELECT v.*,r.strategy,
    ROW_NUMBER() OVER (PARTITION BY v.material_key,v.attribute ORDER BY
      CASE WHEN r.strategy='most_recently_reviewed' THEN v.last_review_date END DESC NULLS LAST,
      CASE WHEN r.strategy='most_complete' THEN LENGTH(v.candidate_value) END DESC NULLS LAST,
      CASE WHEN r.strategy='source_priority' THEN IFF(v.master_role_value LIKE 'MAT-%',0,1) END ASC NULLS LAST,
      v.source_material_code,v.candidate_value) winner_rank
  FROM source_values v JOIN OGFS_DEMO.SILVER.material_survivorship_rules r ON r.attribute=v.attribute
), winners AS (
  SELECT * FROM ranked WHERE winner_rank=1
), override_values AS (
  SELECT o.golden_key material_key,
    CASE f.key::VARCHAR
      WHEN 'canonicalMaterialName' THEN 'canonical_material_name'
      WHEN 'businessLine' THEN 'business_line'
      WHEN 'casNumber' THEN 'cas_number'
      WHEN 'unitOfMeasure' THEN 'unit_of_measure'
      WHEN 'hazardClassification' THEN 'hazard_classification'
      WHEN 'safetyDataSheetRef' THEN 'safety_data_sheet_ref'
      ELSE f.key::VARCHAR END attribute,
    NULLIF(TRIM(f.value::VARCHAR),'') winning_value,o.source_material_code
  FROM OGFS_DEMO.SILVER.golden_record_overrides o,
    LATERAL FLATTEN(INPUT=>o.golden_values) f
  WHERE o.action IN ('attach','create') AND NULLIF(TRIM(f.value::VARCHAR),'') IS NOT NULL
  QUALIFY ROW_NUMBER() OVER (PARTITION BY o.golden_key,attribute ORDER BY o.decided_at DESC,o.action_id DESC)=1
), keys AS (
  SELECT DISTINCT i.material_key,r.attribute FROM OGFS_DEMO.SILVER.material_identity_map i
  CROSS JOIN OGFS_DEMO.SILVER.material_survivorship_rules r
)
SELECT k.material_key,k.attribute,
  COALESCE(o.winning_value,w.candidate_value) winning_value,
  IFF(o.winning_value IS NOT NULL,o.source_material_code,w.source_material_code) source_material_code,
  IFF(o.winning_value IS NOT NULL,'steward_override',r.strategy) winning_rule,
  ARRAY_AGG(DISTINCT IFF(v.candidate_value<>COALESCE(o.winning_value,w.candidate_value),v.candidate_value,NULL)) other_distinct_values
FROM keys k
JOIN OGFS_DEMO.SILVER.material_survivorship_rules r ON r.attribute=k.attribute
LEFT JOIN winners w ON w.material_key=k.material_key AND w.attribute=k.attribute
LEFT JOIN override_values o ON o.material_key=k.material_key AND o.attribute=k.attribute
LEFT JOIN source_values v ON v.material_key=k.material_key AND v.attribute=k.attribute
GROUP BY k.material_key,k.attribute,o.winning_value,o.source_material_code,
  w.candidate_value,w.source_material_code,r.strategy;
