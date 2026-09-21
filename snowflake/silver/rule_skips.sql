-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.rule_skips (
  source_table VARCHAR,site_code VARCHAR,canonical_field VARCHAR,rule_type VARCHAR,
  unavailable_inputs ARRAY,reason VARCHAR,recorded_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
);
