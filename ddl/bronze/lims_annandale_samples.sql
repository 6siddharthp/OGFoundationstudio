-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_annandale_samples" (
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
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_annandale_samples" IS 'lims: 28 fields defined, 28 source columns, 26 auto-mapped, 2 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."lims_annandale_samples" (source_row_number, "sample_id", "product_line", "material_code", "batch_lot_number", "container_id", "test_type", "test_method_version", "instrument_id", "analyst_id", "reviewer_id", "date_requested", "date_received", "date_started", "date_completed", "priority", "submitter", "project_reference", "result_value", "result_unit", "spec_lower_limit", "spec_upper_limit", "sample_status", "approval_status", "approval_date", "storage_location", "retest_flag", "comments", "site_code")
            SELECT row_number, raw_data ->> 'SAMPLE_ID', raw_data ->> 'PRODUCT_LINE', raw_data ->> 'MATERIAL_CODE', raw_data ->> 'BATCH_LOT_NUMBER', raw_data ->> 'CONTAINER_ID', raw_data ->> 'TEST_TYPE', raw_data ->> 'TEST_METHOD_VERSION', raw_data ->> 'INSTRUMENT_ID', raw_data ->> 'ANALYST_ID', raw_data ->> 'QA_APPROVER_ID', CASE
    WHEN NULLIF(raw_data ->> 'DATE_REQUESTED', '') IS NULL THEN NULL
    WHEN raw_data ->> 'DATE_REQUESTED' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'DATE_REQUESTED', (CASE
    WHEN split_part(raw_data ->> 'DATE_REQUESTED', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'DATE_REQUESTED', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'MM/DD/YYYY' END) || CASE WHEN length(raw_data ->> 'DATE_REQUESTED') = 10 THEN '' WHEN length(raw_data ->> 'DATE_REQUESTED') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'DATE_REQUESTED')::timestamp END, CASE
    WHEN NULLIF(raw_data ->> 'DATE_RECEIVED', '') IS NULL THEN NULL
    WHEN raw_data ->> 'DATE_RECEIVED' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'DATE_RECEIVED', (CASE
    WHEN split_part(raw_data ->> 'DATE_RECEIVED', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'DATE_RECEIVED', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'MM/DD/YYYY' END) || CASE WHEN length(raw_data ->> 'DATE_RECEIVED') = 10 THEN '' WHEN length(raw_data ->> 'DATE_RECEIVED') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'DATE_RECEIVED')::timestamp END, CASE
    WHEN NULLIF(raw_data ->> 'DATE_STARTED', '') IS NULL THEN NULL
    WHEN raw_data ->> 'DATE_STARTED' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'DATE_STARTED', (CASE
    WHEN split_part(raw_data ->> 'DATE_STARTED', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'DATE_STARTED', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'MM/DD/YYYY' END) || CASE WHEN length(raw_data ->> 'DATE_STARTED') = 10 THEN '' WHEN length(raw_data ->> 'DATE_STARTED') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'DATE_STARTED')::timestamp END, CASE
    WHEN NULLIF(raw_data ->> 'DATE_COMPLETED', '') IS NULL THEN NULL
    WHEN raw_data ->> 'DATE_COMPLETED' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'DATE_COMPLETED', (CASE
    WHEN split_part(raw_data ->> 'DATE_COMPLETED', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'DATE_COMPLETED', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'MM/DD/YYYY' END) || CASE WHEN length(raw_data ->> 'DATE_COMPLETED') = 10 THEN '' WHEN length(raw_data ->> 'DATE_COMPLETED') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'DATE_COMPLETED')::timestamp END, raw_data ->> 'PRIORITY', raw_data ->> 'SUBMITTER', raw_data ->> 'PROJECT_REFERENCE', NULLIF(raw_data ->> 'RESULT_VALUE', '')::numeric, raw_data ->> 'RESULT_UNIT', NULLIF(raw_data ->> 'SPEC_LOWER_LIMIT', '')::numeric, NULLIF(raw_data ->> 'SPEC_UPPER_LIMIT', '')::numeric, raw_data ->> 'SAMPLE_STATUS', raw_data ->> 'APPROVAL_STATUS', CASE
    WHEN NULLIF(raw_data ->> 'APPROVAL_DATE', '') IS NULL THEN NULL
    WHEN raw_data ->> 'APPROVAL_DATE' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'APPROVAL_DATE', (CASE
    WHEN split_part(raw_data ->> 'APPROVAL_DATE', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'APPROVAL_DATE', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'MM/DD/YYYY' END) || CASE WHEN length(raw_data ->> 'APPROVAL_DATE') = 10 THEN '' WHEN length(raw_data ->> 'APPROVAL_DATE') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'APPROVAL_DATE')::timestamp END, raw_data ->> 'STORAGE_LOCATION', CASE lower(raw_data ->> 'REPEAT_ANALYSIS_IND') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'COMMENTS', raw_data ->> 'SITE_CODE'
            FROM foundation_staging_rows WHERE staging_table_id = 11 ORDER BY row_number;
