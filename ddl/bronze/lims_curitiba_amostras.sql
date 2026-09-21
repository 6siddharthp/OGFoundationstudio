-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_curitiba_amostras" (
              source_row_number integer PRIMARY KEY,
              "product_line" text,
"material_code" text,
"batch_lot_number" text,
"container_id" text,
"test_type" text,
"test_method_version" text,
"instrument_id" text,
"reviewer_id" text,
"date_received" text,
"date_started" text,
"date_completed" text,
"priority" text,
"submitter" text,
"result_value" numeric,
"result_unit" text,
"approval_status" text,
"retest_flag" boolean,
"comments" text,
"site_code" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_curitiba_amostras" IS 'lims: 19 fields defined, 19 source columns, 19 auto-mapped, 0 manually mapped, 0 newly added.';
