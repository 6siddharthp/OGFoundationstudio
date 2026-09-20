-- Foundation Studio · generated orchestration
CREATE OR REPLACE VIEW OGFS_DEMO.GOLD.orchestration_freshness AS
SELECT source_table,MAX(completed_at) last_successful_load
FROM OGFS_DEMO.BRONZE.orchestration_run_log WHERE status='SUCCEEDED' GROUP BY source_table;
