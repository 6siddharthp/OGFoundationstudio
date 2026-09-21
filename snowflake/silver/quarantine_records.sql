-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quarantine_records (
  quarantine_id NUMBER AUTOINCREMENT, source_table VARCHAR, source_row_number NUMBER,
  rule_name VARCHAR, reason VARCHAR, site_code VARCHAR, review_status VARCHAR,
  source_data VARIANT, quarantined_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
);
