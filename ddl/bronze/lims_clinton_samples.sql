-- Foundation Studio · PostgreSQL execution SQL

-- Trial by Sid
-- foundation:stage 2
CREATE TABLE bronze."lims_clinton_samples" (
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
"project_reference" text,
"result_value" numeric,
"result_unit" text,
"spec_lower_limit" numeric,
"spec_upper_limit" numeric,
"sample_status" text,
"approval_status" text,
"approval_date" timestamp,
"storage_location" text,
"retest_flag" boolean,
"comments" text,
"site_code" text,
"lab_notebook_ref" text,
"chain_of_custody_id" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_clinton_samples" IS 'lims_clinton_nj: 28 fields defined, 30 source columns, 26 auto-mapped, 2 manually mapped, 2 newly added.';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_clinton_samples"."reviewer_id" IS 'Manually mapped from QA_APPROVER_ID';

-- foundation:stage 2
COMMENT ON COLUMN bronze."lims_clinton_samples"."retest_flag" IS 'Manually mapped from REPEAT_ANALYSIS_IND';

-- foundation:stage 3
INSERT INTO bronze."lims_clinton_samples" (source_row_number, "sample_id", "product_line", "material_code", "batch_lot_number", "container_id", "test_type", "test_method_version", "instrument_id", "analyst_id", "reviewer_id", "date_requested", "date_received", "date_started", "date_completed", "priority", "submitter", "project_reference", "result_value", "result_unit", "spec_lower_limit", "spec_upper_limit", "sample_status", "approval_status", "approval_date", "storage_location", "retest_flag", "comments", "site_code", "lab_notebook_ref", "chain_of_custody_id")
            SELECT row_number, raw_data ->> 'SAMPLE_ID', raw_data ->> 'PRODUCT_LINE', raw_data ->> 'MATERIAL_CODE', raw_data ->> 'BATCH_LOT_NUMBER', raw_data ->> 'CONTAINER_ID', raw_data ->> 'TEST_TYPE', raw_data ->> 'TEST_METHOD_VERSION', raw_data ->> 'INSTRUMENT_ID', raw_data ->> 'ANALYST_ID', raw_data ->> 'QA_APPROVER_ID', NULLIF(raw_data ->> 'DATE_REQUESTED', '')::timestamp, NULLIF(raw_data ->> 'DATE_RECEIVED', '')::timestamp, NULLIF(raw_data ->> 'DATE_STARTED', '')::timestamp, NULLIF(raw_data ->> 'DATE_COMPLETED', '')::timestamp, raw_data ->> 'PRIORITY', raw_data ->> 'SUBMITTER', raw_data ->> 'PROJECT_REFERENCE', NULLIF(raw_data ->> 'RESULT_VALUE', '')::numeric, raw_data ->> 'RESULT_UNIT', NULLIF(raw_data ->> 'SPEC_LOWER_LIMIT', '')::numeric, NULLIF(raw_data ->> 'SPEC_UPPER_LIMIT', '')::numeric, raw_data ->> 'SAMPLE_STATUS', raw_data ->> 'APPROVAL_STATUS', NULLIF(raw_data ->> 'APPROVAL_DATE', '')::timestamp, raw_data ->> 'STORAGE_LOCATION', CASE lower(raw_data ->> 'REPEAT_ANALYSIS_IND') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'COMMENTS', raw_data ->> 'SITE_CODE', raw_data ->> 'LAB_NOTEBOOK_REF', raw_data ->> 'CHAIN_OF_CUSTODY_ID'
            FROM foundation_staging_rows WHERE staging_table_id = 1 ORDER BY row_number;
