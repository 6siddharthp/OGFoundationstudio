-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_groups AS
WITH direct_pairs AS (
  SELECT left_code source_code,right_code neighbor_code,MAX(similarity_score) similarity_score
  FROM OGFS_DEMO.SILVER.material_match_candidates GROUP BY left_code,right_code
  UNION ALL
  SELECT right_code,left_code,MAX(similarity_score)
  FROM OGFS_DEMO.SILVER.material_match_candidates GROUP BY right_code,left_code
), neighbor_stats AS (
  SELECT source_code,COUNT(*) neighbor_count,MAX(similarity_score) top_score
  FROM direct_pairs GROUP BY source_code
), anchor_options AS (
  SELECT source_code,source_code anchor_source_code,neighbor_count,top_score FROM neighbor_stats
  UNION ALL
  SELECT p.source_code,p.neighbor_code,s.neighbor_count,s.top_score
  FROM direct_pairs p JOIN neighbor_stats s ON s.source_code=p.neighbor_code
), chosen_anchors AS (
  SELECT source_code,anchor_source_code
  FROM anchor_options
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY source_code
    ORDER BY neighbor_count DESC,top_score DESC,anchor_source_code ASC
  )=1
), assigned AS (
  SELECT c.anchor_source_code,c.source_code,
    IFF(c.source_code=c.anchor_source_code,100,p.similarity_score) anchor_score
  FROM chosen_anchors c
  LEFT JOIN direct_pairs p ON p.source_code=c.source_code AND p.neighbor_code=c.anchor_source_code
), active_anchors AS (
  SELECT DISTINCT anchor_source_code FROM assigned WHERE source_code<>anchor_source_code
), members AS (
  SELECT a.anchor_source_code,a.source_code,a.anchor_score
  FROM assigned a JOIN active_anchors g ON g.anchor_source_code=a.anchor_source_code
  UNION ALL
  SELECT g.anchor_source_code,g.anchor_source_code,100
  FROM active_anchors g
  WHERE NOT EXISTS (
    SELECT 1 FROM assigned a
    WHERE a.anchor_source_code=g.anchor_source_code AND a.source_code=g.anchor_source_code
  )
), member_arrays AS (
  SELECT anchor_source_code,
    ARRAY_AGG(source_code) WITHIN GROUP (ORDER BY source_code) member_source_records,
    ARRAY_AGG(OBJECT_CONSTRUCT('source_code',source_code,'score',anchor_score))
      WITHIN GROUP (ORDER BY source_code) member_anchor_scores
  FROM members GROUP BY anchor_source_code HAVING COUNT(*)>=2
), group_pairs AS (
  SELECT m.anchor_source_code,
    ARRAY_AGG(OBJECT_CONSTRUCT('left',p.left_code,'right',p.right_code,'score',p.similarity_score,
      'reason',p.review_reason))
      WITHIN GROUP (ORDER BY p.left_code,p.right_code) pairwise_scores,
    MIN(p.business_line) business_line,
    LISTAGG(DISTINCT p.review_reason,'; ') WITHIN GROUP (ORDER BY p.review_reason) review_reason
  FROM member_arrays m
  JOIN members l ON l.anchor_source_code=m.anchor_source_code
  JOIN OGFS_DEMO.SILVER.material_match_candidates p ON p.left_code=l.source_code
  JOIN members r ON r.anchor_source_code=m.anchor_source_code AND r.source_code=p.right_code
  GROUP BY m.anchor_source_code
)
SELECT 'GRP_'||MD5(m.anchor_source_code) group_id,m.member_source_records,
  p.pairwise_scores,p.business_line,m.anchor_source_code,m.member_anchor_scores,p.review_reason
FROM member_arrays m JOIN group_pairs p ON p.anchor_source_code=m.anchor_source_code;
