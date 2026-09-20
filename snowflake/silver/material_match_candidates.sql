-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_candidates AS
WITH base AS (
  SELECT DISTINCT i.material_key,m.source_material_code,m.canonical_material_name,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m JOIN OGFS_DEMO.SILVER.material_identity_map i USING (source_material_code)
  WHERE m.source_material_code IS NOT NULL AND m.canonical_material_name IS NOT NULL
),
pairs AS (
  SELECT l.material_key left_material_key,r.material_key right_material_key,
    l.source_material_code left_code,r.source_material_code right_code,
    l.canonical_material_name left_name,r.canonical_material_name right_name,
    JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name) similarity_score
  FROM base l JOIN base r ON l.material_key < r.material_key
  WHERE NOT (l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas)
)
SELECT left_material_key,right_material_key,MIN(left_code) left_code,MIN(right_code) right_code,
  MIN(left_name) left_name,MIN(right_name) right_name,MAX(similarity_score) similarity_score,
  85 similarity_threshold,'candidate_review' review_status
FROM pairs
WHERE similarity_score < 85 AND similarity_score >= 85*0.75
GROUP BY left_material_key,right_material_key
QUALIFY ROW_NUMBER() OVER (PARTITION BY left_material_key ORDER BY MAX(similarity_score) DESC,right_material_key)=1;
