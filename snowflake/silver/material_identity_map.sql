-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_identity_map AS
WITH base AS (
  SELECT DISTINCT source_material_code, legacy_material_id, canonical_material_name, cas_number,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
canonical_targets AS (
  SELECT * FROM base WHERE legacy_material_id LIKE 'MAT-%'
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY legacy_material_id
    ORDER BY LENGTH(canonical_material_name) DESC,normalized_name,source_material_code
  )=1
),
ranked_targets AS (
  SELECT b.source_material_code,t.normalized_name target_name,
    JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) similarity_score,
    CASE WHEN b.legacy_material_id=t.legacy_material_id THEN 'raw_material_master_xref'
         WHEN b.normalized_cas=t.normalized_cas THEN 'cas_number'
         ELSE 'canonical_name_similarity' END match_rule,
    ROW_NUMBER() OVER (PARTITION BY b.source_material_code ORDER BY
      IFF(b.legacy_material_id=t.legacy_material_id,1,0) DESC,
      IFF(b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas,1,0) DESC,
      JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) DESC,
      t.normalized_name) target_rank
  FROM base b JOIN canonical_targets t ON
    b.legacy_material_id=t.legacy_material_id
    OR (b.legacy_material_id LIKE 'LGC-%' AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas)
    OR ((b.normalized_cas IS NULL OR t.normalized_cas IS NULL)
      AND JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) >= 85)
),
resolved AS (
  SELECT b.*,r.target_name,r.match_rule
  FROM base b LEFT JOIN ranked_targets r ON r.source_material_code=b.source_material_code AND r.target_rank=1
)
SELECT source_material_code,canonical_material_name,cas_number,
  'MAT_'||MD5(COALESCE(target_name,normalized_name)) material_key,
  COALESCE(match_rule,'unmatched_source_record') match_rule,85 similarity_threshold
FROM resolved;
