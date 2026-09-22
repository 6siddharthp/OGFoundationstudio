-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.SILVER.golden_record_overrides (
  action_id VARCHAR,item_key VARCHAR,action VARCHAR,golden_key VARCHAR,
  source_table VARCHAR,source_row_number NUMBER,source_material_code VARCHAR,golden_values VARIANT,
  actor VARCHAR,decided_at TIMESTAMP_TZ,rationale VARCHAR
);
