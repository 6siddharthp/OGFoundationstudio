-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE."lims_curitiba_amostras" AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       "PRODUCT_LINE"::VARCHAR AS "product_line",
       "MATERIAL_CODE"::VARCHAR AS "material_code",
       "BATCH_LOT_NUMBER"::VARCHAR AS "batch_lot_number",
       "CONTAINER_ID"::VARCHAR AS "container_id",
       "TEST_TYPE"::VARCHAR AS "test_type",
       "TEST_METHOD_VERSION"::VARCHAR AS "test_method_version",
       "INSTRUMENT_ID"::VARCHAR AS "instrument_id",
       "REVIEWER_ID"::VARCHAR AS "reviewer_id",
       COALESCE(TRY_TO_TIMESTAMP_NTZ("DATE_RECEIVED", 'DD/MM/YYYY'), TRY_TO_TIMESTAMP_NTZ("DATE_RECEIVED"))::TIMESTAMP_NTZ AS "date_received",
       COALESCE(TRY_TO_TIMESTAMP_NTZ("DATE_STARTED", 'DD/MM/YYYY'), TRY_TO_TIMESTAMP_NTZ("DATE_STARTED"))::TIMESTAMP_NTZ AS "date_started",
       COALESCE(TRY_TO_TIMESTAMP_NTZ("DATE_COMPLETED", 'DD/MM/YYYY'), TRY_TO_TIMESTAMP_NTZ("DATE_COMPLETED"))::TIMESTAMP_NTZ AS "date_completed",
       "PRIORITY"::VARCHAR AS "priority",
       "SUBMITTER"::VARCHAR AS "submitter",
       TRY_TO_DECIMAL(TO_VARCHAR("RESULT_VALUE"), 38, 10)::NUMBER AS "result_value",
       "RESULT_UNIT"::VARCHAR AS "result_unit",
       "APPROVAL_STATUS"::VARCHAR AS "approval_status",
       TRY_TO_BOOLEAN("RETEST_FLAG")::BOOLEAN AS "retest_flag",
       "COMMENTS"::VARCHAR AS "comments",
       "SITE_CODE"::VARCHAR AS "site_code",
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE."LIMS_CURITIBA_AMOSTRAS";
