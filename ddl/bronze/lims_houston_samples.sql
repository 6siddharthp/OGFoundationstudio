-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_houston_samples" (
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
"date_requested" text,
"date_received" text,
"date_started" text,
"date_completed" text,
"priority" text,
"submitter" text,
"project_reference" text,
"result_value" numeric,
"result_unit" text,
"spec_lower_limit" numeric,
"spec_upper_limit" numeric,
"sample_status" text,
"approval_status" text,
"approval_date" text,
"storage_location" text,
"retest_flag" boolean,
"comments" text,
"site_code" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_houston_samples" IS 'lims: 27 fields defined, 27 source columns, 23 auto-mapped, 4 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."lims_houston_samples" (source_row_number, "sample_id", "product_line", "material_code", "batch_lot_number", "container_id", "test_type", "test_method_version", "instrument_id", "analyst_id", "date_requested", "date_received", "date_started", "date_completed", "priority", "submitter", "project_reference", "result_value", "result_unit", "spec_lower_limit", "spec_upper_limit", "sample_status", "approval_status", "approval_date", "storage_location", "retest_flag", "comments", "site_code")
            SELECT row_number, raw_data ->> 'SAMPLE_NUMBER', raw_data ->> 'PRODUCT_LINE', raw_data ->> 'MATERIAL_CODE', raw_data ->> 'BATCH_LOT_NUMBER', raw_data ->> 'CONTAINER_ID', raw_data ->> 'ANALYSIS_TYPE', raw_data ->> 'TEST_METHOD_VERSION', raw_data ->> 'INSTRUMENT_ID', raw_data ->> 'ANALYST_ID', raw_data ->> 'DATE_REQUESTED', raw_data ->> 'DATE_RECEIVED', raw_data ->> 'DATE_STARTED', raw_data ->> 'DATE_COMPLETED', raw_data ->> 'PRIORITY', raw_data ->> 'SUBMITTER', raw_data ->> 'PROJECT_REFERENCE', NULLIF(raw_data ->> 'RESULT_VALUE', '')::numeric, raw_data ->> 'UOM', NULLIF(raw_data ->> 'SPEC_LOWER_LIMIT', '')::numeric, NULLIF(raw_data ->> 'SPEC_UPPER_LIMIT', '')::numeric, raw_data ->> 'SAMPLE_STATUS', raw_data ->> 'APPROVAL_STATUS', raw_data ->> 'APPROVAL_DATE', raw_data ->> 'STORAGE_LOCATION', CASE lower(raw_data ->> 'RERUN_FLAG') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'COMMENTS', raw_data ->> 'SITE_CODE'
            FROM foundation_staging_rows WHERE staging_table_id = 22 ORDER BY row_number;
