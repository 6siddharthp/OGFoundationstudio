-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.quarantine_records (
          quarantine_id bigserial PRIMARY KEY, source_table text NOT NULL, source_row_number integer NOT NULL,
          reason text NOT NULL, source_data jsonb NOT NULL, quarantined_at timestamptz NOT NULL DEFAULT now()
        );

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lims_clinton_samples', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL THEN 'Test_Type: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL THEN 'Result_Unit: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL THEN 'Sample_Status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lims_clinton_samples" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lims_houston_samples', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."analysistype" AS VARCHAR)))) IS NULL THEN 'AnalysisType: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."uom" AS VARCHAR)))) IS NULL THEN 'UOM: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."status" AS VARCHAR)))) IS NULL THEN 'Status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lims_houston_samples" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."analysistype" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."uom" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."status" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'engine_test_cell', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))) IS NULL THEN 'TestStandard: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."engine_test_cell" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))) IS NULL), FALSE);
-- foundation:stage 4
CREATE TABLE silver."silver_lims_clinton_nj" (
              source_row_number integer PRIMARY KEY,
              "sample_id" text,
"product_line" text,
"material_codesid" text,
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
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_lims_clinton_nj" (
              source_row_number, "sample_id", "product_line", "material_codesid", "batch_lot_number", "container_id", "test_type", "test_method_version", "instrument_id", "analyst_id", "reviewer_id", "date_requested", "date_received", "date_started", "date_completed", "priority", "submitter", "project_reference", "result_value", "result_unit", "spec_lower_limit", "spec_upper_limit", "sample_status", "approval_status", "approval_date", "storage_location", "retest_flag", "comments", "site_code", "lab_notebook_ref", "chain_of_custody_id", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."sample_id" AS "sample_id",
  "row_data"."product_line" AS "product_line",
  "row_data"."material_code" AS "material_codesid",
  "row_data"."batch_lot_number" AS "batch_lot_number",
  "row_data"."container_id" AS "container_id",
  COALESCE((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))), NULL) AS "test_type",
  "row_data"."test_method_version" AS "test_method_version",
  "row_data"."instrument_id" AS "instrument_id",
  "row_data"."analyst_id" AS "analyst_id",
  "row_data"."reviewer_id" AS "reviewer_id",
  "row_data"."date_requested" AS "date_requested",
  "row_data"."date_received" AS "date_received",
  "row_data"."date_started" AS "date_started",
  "row_data"."date_completed" AS "date_completed",
  "row_data"."priority" AS "priority",
  "row_data"."submitter" AS "submitter",
  "row_data"."project_reference" AS "project_reference",
  "row_data"."result_value" AS "result_value",
  COALESCE((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))), NULL) AS "result_unit",
  "row_data"."spec_lower_limit" AS "spec_lower_limit",
  "row_data"."spec_upper_limit" AS "spec_upper_limit",
  COALESCE((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))), NULL) AS "sample_status",
  "row_data"."approval_status" AS "approval_status",
  "row_data"."approval_date" AS "approval_date",
  "row_data"."storage_location" AS "storage_location",
  "row_data"."retest_flag" AS "retest_flag",
  "row_data"."comments" AS "comments",
  "row_data"."site_code" AS "site_code",
  "row_data"."lab_notebook_ref" AS "lab_notebook_ref",
  "row_data"."chain_of_custody_id" AS "chain_of_custody_id",
  'lims_clinton_samples' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."lims_clinton_samples" AS "row_data" WHERE NOT (COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE))) AS "row_data";
