-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.GOLD.dim_test_method (
  test_method_sk NUMBER AUTOINCREMENT PRIMARY KEY,
  test_method_key VARCHAR,
  governed_standard_reference VARCHAR,
  standard_body VARCHAR,
  method_title VARCHAR,
  applies_to_business_line VARCHAR,
  valid_from TIMESTAMP_TZ,
  valid_to TIMESTAMP_TZ,
  is_current BOOLEAN
);

-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_test_method d SET valid_from='1900-01-01'::TIMESTAMP_TZ
WHERE d.valid_from=(SELECT MIN(history.valid_from) FROM OGFS_DEMO.GOLD.dim_test_method history WHERE history.test_method_key=d.test_method_key);

-- foundation:stage 3
SET gold_scd_effective_at=CURRENT_TIMESTAMP();

-- foundation:stage 3
MERGE INTO OGFS_DEMO.GOLD.dim_test_method d
USING (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
ON d.test_method_key = s.test_method_key AND d.is_current = TRUE
WHEN MATCHED AND HASH(d.governed_standard_reference,d.standard_body,d.applies_to_business_line) <> HASH(s.governed_standard_reference,s.standard_body,s.applies_to_business_line) THEN UPDATE SET d.valid_to=$gold_scd_effective_at,d.is_current=FALSE
WHEN NOT MATCHED THEN INSERT (test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line,valid_from,valid_to,is_current) VALUES (s.test_method_key,s.governed_standard_reference,s.standard_body,s.method_title,s.applies_to_business_line,'1900-01-01'::TIMESTAMP_TZ,'9999-12-31'::TIMESTAMP_TZ,TRUE);

-- foundation:stage 3
INSERT INTO OGFS_DEMO.GOLD.dim_test_method (test_method_key,governed_standard_reference,standard_body,method_title,applies_to_business_line,valid_from,valid_to,is_current)
SELECT s.test_method_key,s.governed_standard_reference,s.standard_body,s.method_title,s.applies_to_business_line,$gold_scd_effective_at,'9999-12-31'::TIMESTAMP_TZ,TRUE
FROM (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
WHERE NOT EXISTS (
  SELECT 1 FROM OGFS_DEMO.GOLD.dim_test_method current_row
  WHERE current_row.test_method_key=s.test_method_key AND current_row.is_current=TRUE AND HASH(current_row.governed_standard_reference,current_row.standard_body,current_row.applies_to_business_line) = HASH(s.governed_standard_reference,s.standard_body,s.applies_to_business_line)
);

-- foundation:stage 3
UPDATE OGFS_DEMO.GOLD.dim_test_method d
SET method_title=s.method_title
FROM (SELECT source_raw.test_method_key,source_raw.governed_standard_reference,source_raw.standard_body,source_raw.method_title,source_raw.applies_to_business_line FROM (SELECT * FROM OGFS_DEMO.SILVER.conformed_test_method) source_raw) s
WHERE d.test_method_key=s.test_method_key
  AND (d.method_title IS DISTINCT FROM s.method_title);
