-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_identity_map AS
WITH base AS (
  SELECT DISTINCT source_material_code, legacy_material_id master_role_value,
    legacy_material_id legacy_role_value,canonical_material_name,cas_number,
    NULLIF(UPPER(TRIM(TO_VARCHAR(viscosity_grade))),'') grade_0,
    NULLIF(UPPER(TRIM(TO_VARCHAR(supplier_grade))),'') grade_1,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), '[^A-Z0-9]', '') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), '[^A-Z0-9]', ''), '') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
canonical_targets AS (
  SELECT * FROM base WHERE master_role_value LIKE 'MAT-%'
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY master_role_value
    ORDER BY LENGTH(canonical_material_name) DESC,normalized_name,source_material_code
  )=1
),
ranked_targets AS (
  SELECT b.source_material_code,t.normalized_name target_name,
    JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) similarity_score,
    CASE WHEN b.legacy_role_value=t.master_role_value THEN 'raw_material_master_xref'
         WHEN b.normalized_cas=t.normalized_cas THEN 'cas_number'
         ELSE 'canonical_name_similarity' END match_rule,
    ROW_NUMBER() OVER (PARTITION BY b.source_material_code ORDER BY
      IFF(b.legacy_role_value=t.master_role_value,1,0) DESC,
      IFF(b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas,1,0) DESC,
      JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) DESC,
      t.normalized_name) target_rank
  FROM base b CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules JOIN canonical_targets t ON
    b.legacy_role_value=t.master_role_value
    OR (b.legacy_role_value LIKE 'LGC-%' AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas
      AND (b.grade_0 IS NULL OR t.grade_0 IS NULL OR b.grade_0=t.grade_0)
      AND (b.grade_1 IS NULL OR t.grade_1 IS NULL OR b.grade_1=t.grade_1))
    OR ((b.normalized_cas IS NULL OR t.normalized_cas IS NULL)
      AND JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) >= rules.name_similarity_threshold)
),
cas_grade_conflicts AS (
  SELECT DISTINCT b.source_material_code
  FROM base b JOIN canonical_targets t ON b.legacy_role_value LIKE 'LGC-%'
    AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas
  WHERE (b.grade_0 IS NOT NULL AND t.grade_0 IS NOT NULL AND b.grade_0<>t.grade_0)
    OR (b.grade_1 IS NOT NULL AND t.grade_1 IS NOT NULL AND b.grade_1<>t.grade_1)
),
current_overrides AS (
  SELECT *
  FROM OGFS_DEMO.SILVER.golden_record_overrides
  QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1
),
resolved AS (
  SELECT b.*,r.target_name,r.match_rule,o.action override_action,o.golden_key override_golden_key,
    c.source_material_code IS NOT NULL has_cas_grade_conflict
  FROM base b LEFT JOIN ranked_targets r ON r.source_material_code=b.source_material_code AND r.target_rank=1
  LEFT JOIN current_overrides o ON LOWER(o.source_material_code)=LOWER(b.source_material_code)
  LEFT JOIN cas_grade_conflicts c ON c.source_material_code=b.source_material_code
)
SELECT source_material_code,canonical_material_name,cas_number,
  COALESCE(
    IFF(override_action IN ('attach','create'),override_golden_key,NULL),
     IFF(override_action='reject','MAT_'||MD5(normalized_name||':'||source_material_code),NULL),
    'MAT_'||MD5(IFF(target_name IS NULL AND has_cas_grade_conflict,
      normalized_name||':'||source_material_code,COALESCE(target_name,normalized_name)))
  ) material_key,
  CASE WHEN override_action IN ('attach','create') THEN 'golden_record_override'
        WHEN override_action='reject' THEN 'steward_separate'
       ELSE COALESCE(match_rule,'unmatched_source_record') END match_rule,
  rules.name_similarity_threshold similarity_threshold
FROM resolved CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules;
