-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quarantine_records (
  quarantine_id NUMBER AUTOINCREMENT, source_table VARCHAR, source_row_number NUMBER,
  reason VARCHAR, source_data VARIANT, quarantined_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
);
