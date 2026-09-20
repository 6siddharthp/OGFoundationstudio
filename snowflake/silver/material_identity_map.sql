-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_identity_map AS
WITH base AS (
  SELECT DISTINCT source_material_code, canonical_material_name, cas_number,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
scored_pairs AS (
  SELECT l.source_material_code left_code, r.source_material_code right_code,
    IFF(l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas, 100,
      JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name)) similarity_score,
    IFF(l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas, 'cas_number', 'canonical_name_similarity') match_rule
  FROM base l JOIN base r ON l.source_material_code < r.source_material_code
),
automatic_pairs AS (
  SELECT * FROM scored_pairs WHERE match_rule='cas_number' OR similarity_score >= 85
),
peers AS (
  SELECT left_code source_material_code,right_code peer_code,match_rule FROM automatic_pairs
  UNION ALL SELECT right_code,left_code,match_rule FROM automatic_pairs
),
anchors AS (
  SELECT b.source_material_code,
    LEAST(b.source_material_code,COALESCE(MIN(p.peer_code),b.source_material_code)) group_anchor,
    IFF(COUNT_IF(p.match_rule='cas_number')>0,'cas_number',
      IFF(COUNT(p.peer_code)>0,'canonical_name_similarity','raw_material_master_xref')) match_rule
  FROM base b LEFT JOIN peers p ON p.source_material_code=b.source_material_code
  GROUP BY b.source_material_code
)
SELECT b.source_material_code,b.canonical_material_name,b.cas_number,
  'MAT_'||MD5(a.group_anchor) material_key,a.match_rule,85 similarity_threshold
FROM base b JOIN anchors a USING (source_material_code);
