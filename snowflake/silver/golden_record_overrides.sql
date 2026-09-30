-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.SILVER.golden_record_overrides (
  action_id VARCHAR,item_key VARCHAR,action VARCHAR,golden_key VARCHAR,
  source_table VARCHAR,source_row_number NUMBER,source_material_code VARCHAR,golden_values VARIANT,
  actor VARCHAR,decided_at TIMESTAMP_TZ,rationale VARCHAR
);

-- foundation:stage 3
-- Foundation Studio · governed golden-record overrides
CREATE TABLE IF NOT EXISTS OGFS_DEMO.SILVER.GOLDEN_RECORD_OVERRIDES (
  ACTION_ID VARCHAR, ITEM_KEY VARCHAR, ACTION VARCHAR, GOLDEN_KEY VARCHAR,
  SOURCE_TABLE VARCHAR, SOURCE_ROW_NUMBER NUMBER, SOURCE_MATERIAL_CODE VARCHAR, GOLDEN_VALUES VARIANT,
  ACTOR VARCHAR, DECIDED_AT TIMESTAMP_TZ, RATIONALE VARCHAR
);

-- foundation:stage 3
DELETE FROM OGFS_DEMO.SILVER.GOLDEN_RECORD_OVERRIDES;
