-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_curitiba_amostras" (
              source_row_number integer PRIMARY KEY,
              "sample_id" text,
"product_line" text,
"material_code" text,
"batch_lot_number" text,
"container_id" text,
"test_type" text,
"test_method_version" text,
"instrument_id" text,
"analyst_id" text,
"reviewer_id" text,
"date_requested" timestamp,
"date_received" timestamp,
"date_started" timestamp,
"date_completed" timestamp,
"priority" text,
"submitter" text,
"result_value" numeric,
"result_unit" text,
"sample_status" text,
"approval_status" text,
"retest_flag" boolean,
"comments" text,
"site_code" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_curitiba_amostras" IS 'lims: 23 fields defined, 23 source columns, 19 auto-mapped, 4 manually mapped, 0 newly added.';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_curitiba_amostras"."sample_id" IS 'Manually mapped from AMOSTRA_ID';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_curitiba_amostras"."analyst_id" IS 'Manually mapped from TECNICO_ID';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_curitiba_amostras"."date_requested" IS 'Manually mapped from DATA_SOLICITADA';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_curitiba_amostras"."sample_status" IS 'Manually mapped from STATUS_AMOSTRA';

-- foundation:stage 3
INSERT INTO bronze."lims_curitiba_amostras" (source_row_number, "sample_id", "product_line", "material_code", "batch_lot_number", "container_id", "test_type", "test_method_version", "instrument_id", "analyst_id", "reviewer_id", "date_requested", "date_received", "date_started", "date_completed", "priority", "submitter", "result_value", "result_unit", "sample_status", "approval_status", "retest_flag", "comments", "site_code")
            SELECT row_number, raw_data ->> 'AMOSTRA_ID', raw_data ->> 'PRODUCT_LINE', raw_data ->> 'MATERIAL_CODE', raw_data ->> 'BATCH_LOT_NUMBER', raw_data ->> 'CONTAINER_ID', raw_data ->> 'TEST_TYPE', raw_data ->> 'TEST_METHOD_VERSION', raw_data ->> 'INSTRUMENT_ID', raw_data ->> 'TECNICO_ID', raw_data ->> 'REVIEWER_ID', NULLIF(raw_data ->> 'DATA_SOLICITADA', '')::timestamp, NULLIF(raw_data ->> 'DATE_RECEIVED', '')::timestamp, NULLIF(raw_data ->> 'DATE_STARTED', '')::timestamp, NULLIF(raw_data ->> 'DATE_COMPLETED', '')::timestamp, raw_data ->> 'PRIORITY', raw_data ->> 'SUBMITTER', NULLIF(raw_data ->> 'RESULT_VALUE', '')::numeric, raw_data ->> 'RESULT_UNIT', raw_data ->> 'STATUS_AMOSTRA', raw_data ->> 'APPROVAL_STATUS', CASE lower(raw_data ->> 'RETEST_FLAG') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'COMMENTS', raw_data ->> 'SITE_CODE'
            FROM foundation_staging_rows WHERE staging_table_id = 12 ORDER BY row_number;
