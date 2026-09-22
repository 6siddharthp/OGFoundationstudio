-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.unrecognized_units AS
SELECT source_data:result_unit::VARCHAR recorded_unit,reason,site_code,COUNT(*) occurrence_count
FROM OGFS_DEMO.SILVER.quarantine_records
WHERE rule_name='uom_conversion' AND reason LIKE 'Unit is unrecognised:%'
GROUP BY recorded_unit,reason,site_code;
