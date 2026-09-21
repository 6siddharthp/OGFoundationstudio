-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.lims_curitiba_amostras AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       AMOSTRA_ID::VARCHAR AS sample_id,
       PRODUCT_LINE::VARCHAR AS product_line,
       MATERIAL_CODE::VARCHAR AS material_code,
       BATCH_LOT_NUMBER::VARCHAR AS batch_lot_number,
       CONTAINER_ID::VARCHAR AS container_id,
       TEST_TYPE::VARCHAR AS test_type,
       TEST_METHOD_VERSION::VARCHAR AS test_method_version,
       INSTRUMENT_ID::VARCHAR AS instrument_id,
       TECNICO_ID::VARCHAR AS analyst_id,
       REVIEWER_ID::VARCHAR AS reviewer_id,
       DATA_SOLICITADA::VARCHAR AS date_requested,
       DATE_RECEIVED::VARCHAR AS date_received,
       DATE_STARTED::VARCHAR AS date_started,
       DATE_COMPLETED::VARCHAR AS date_completed,
       PRIORITY::VARCHAR AS priority,
       SUBMITTER::VARCHAR AS submitter,
       TRY_TO_DECIMAL(TO_VARCHAR(RESULT_VALUE), 38, 10)::NUMBER AS result_value,
       RESULT_UNIT::VARCHAR AS result_unit,
       STATUS_AMOSTRA::VARCHAR AS sample_status,
       APPROVAL_STATUS::VARCHAR AS approval_status,
       TRY_TO_BOOLEAN(TO_VARCHAR(RETEST_FLAG))::BOOLEAN AS retest_flag,
       COMMENTS::VARCHAR AS comments,
       SITE_CODE::VARCHAR AS site_code,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.LIMS_CURITIBA_AMOSTRAS;
