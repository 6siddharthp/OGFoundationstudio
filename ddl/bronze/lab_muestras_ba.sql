-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lab_muestras_ba" (
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
"project_reference" numeric,
"result_value" text,
"result_unit" numeric,
"spec_lower_limit" numeric,
"spec_upper_limit" text,
"sample_status" text,
"approval_status" text,
"approval_date" text,
"storage_location" boolean,
"retest_flag" text,
"site_code" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lab_muestras_ba" IS 'lims: 27 fields defined, 27 source columns, 9 auto-mapped, 18 manually mapped, 0 newly added.';
