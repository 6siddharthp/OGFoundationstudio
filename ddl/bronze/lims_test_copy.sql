-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_test_copy" (
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
COMMENT ON TABLE bronze."lims_test_copy" IS 'lims: 28 fields defined, 28 source columns, 23 auto-mapped, 5 manually mapped, 0 newly added.';
