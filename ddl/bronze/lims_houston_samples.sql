-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_houston_samples" (
              source_row_number integer PRIMARY KEY,
              "product_line" text,
"material_code" text,
"batch_lot_number" text,
"container_id" text,
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
"spec_lower_limit" numeric,
"spec_upper_limit" numeric,
"sample_status" text,
"approval_status" text,
"approval_date" text,
"storage_location" text,
"comments" text,
"site_code" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_houston_samples" IS 'lims: 23 fields defined, 23 source columns, 23 auto-mapped, 0 manually mapped, 0 newly added.';
