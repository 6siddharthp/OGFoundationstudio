-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_candidates AS
WITH base AS (
  SELECT DISTINCT i.material_key,m.source_material_code,m.legacy_material_id master_role_value,
    m.legacy_material_id legacy_role_value,m.canonical_material_name,m.business_line,
    NULLIF(UPPER(TRIM(TO_VARCHAR(m.viscosity_grade))),'') grade_0,
    NULLIF(UPPER(TRIM(TO_VARCHAR(m.supplier_grade))),'') grade_1,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m JOIN OGFS_DEMO.SILVER.material_identity_map i USING (source_material_code)
  WHERE m.source_material_code IS NOT NULL AND m.canonical_material_name IS NOT NULL
),
pairs AS (
  SELECT l.material_key left_material_key,r.material_key right_material_key,l.business_line,
    l.source_material_code left_code,r.source_material_code right_code,
    l.canonical_material_name left_name,r.canonical_material_name right_name,
    JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name) similarity_score,
    l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas same_cas,
    ((l.legacy_role_value LIKE 'LGC-%' AND r.master_role_value LIKE 'MAT-%')
      OR (r.legacy_role_value LIKE 'LGC-%' AND l.master_role_value LIKE 'MAT-%')) cas_attachment_pair,
    LOWER(TRIM(COALESCE(l.business_line,'')))=LOWER(TRIM(COALESCE(r.business_line,''))) same_business_line,
    (l.grade_0 IS NOT NULL AND r.grade_0 IS NOT NULL AND l.grade_0<>r.grade_0) grade_conflict_0,
    (l.grade_1 IS NOT NULL AND r.grade_1 IS NOT NULL AND l.grade_1<>r.grade_1) grade_conflict_1
  FROM base l JOIN base r ON l.source_material_code < r.source_material_code
    AND l.material_key <> r.material_key
    AND NOT (l.normalized_cas IS NOT NULL AND r.normalized_cas IS NOT NULL
      AND l.normalized_cas<>r.normalized_cas)
    AND NOT EXISTS (SELECT 1 FROM OGFS_DEMO.SILVER.decided_material_pairs d
      WHERE d.pair_key=l.source_material_code||'|'||r.source_material_code)
     AND NOT EXISTS (SELECT 1 FROM (SELECT source_material_code,action
       FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1) o
      WHERE LOWER(o.source_material_code) IN (LOWER(l.source_material_code),LOWER(r.source_material_code))
        AND o.action IN ('attach','reject','create'))
)
SELECT pairs.left_material_key,pairs.right_material_key,pairs.business_line,
  pairs.left_code,pairs.right_code,pairs.left_name,pairs.right_name,pairs.similarity_score,
  CASE WHEN same_cas THEN
    'Same CAS number, different grade ('||
      RTRIM(IFF(grade_conflict_0,'viscosity grade, ','')||IFF(grade_conflict_1,'supplier grade, ',''),', ')||')'
    ELSE 'Similar names' END review_reason,
  rules.name_similarity_threshold similarity_threshold,rules.review_band_floor,
  'candidate_review' review_status
FROM pairs CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules
 WHERE (same_cas AND cas_attachment_pair AND (grade_conflict_0 OR grade_conflict_1))
  OR (NOT same_cas AND same_business_line
    AND similarity_score < rules.name_similarity_threshold
    AND similarity_score >= rules.review_band_floor);
