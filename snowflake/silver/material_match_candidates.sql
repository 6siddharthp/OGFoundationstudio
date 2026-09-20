-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_candidates AS
WITH base AS (
  SELECT DISTINCT source_material_code,canonical_material_name,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
pairs AS (
  SELECT l.source_material_code left_code,r.source_material_code right_code,
    l.canonical_material_name left_name,r.canonical_material_name right_name,
    JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name) similarity_score
  FROM base l JOIN base r ON l.source_material_code < r.source_material_code
  WHERE NOT (l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas)
)
SELECT left_code,right_code,left_name,right_name,similarity_score,85 similarity_threshold,'candidate_review' review_status
FROM pairs
WHERE similarity_score < 85 AND similarity_score >= 85*0.75
QUALIFY ROW_NUMBER() OVER (PARTITION BY left_code ORDER BY similarity_score DESC,right_code)=1;
