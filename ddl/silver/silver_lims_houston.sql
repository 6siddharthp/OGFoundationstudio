-- HUMAN EDIT VALIDATION: preserve this Git-side comment
-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver."silver_lims_houston" (
              source_row_number integer PRIMARY KEY,
              "sample_number" text,
"business_line" text,
"material_id" text,
"lot_number" text,
"container_ref" text,
"analysis_type" text,
"method_version" text,
"instrument_code" text,
"tested_by" text,
"reviewed_by" text,
"req_date" timestamp,
"received_date" timestamp,
"start_date" timestamp,
"comp_date" timestamp,
"priority_level" numeric,
"requested_by" text,
"project_code" text,
"value" numeric,
"uom" text,
"lower_spec_limit" numeric,
"upper_spec_limit" numeric,
"status" text,
"approval_state" text,
"approval_date" timestamp,
"storage_loc" text,
"retest_indicator" boolean,
"notes" text,
"location" text,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_lims_houston" (
              source_row_number, "sample_number", "business_line", "material_id", "lot_number", "container_ref", "analysis_type", "method_version", "instrument_code", "tested_by", "reviewed_by", "req_date", "received_date", "start_date", "comp_date", "priority_level", "requested_by", "project_code", "value", "uom", "lower_spec_limit", "upper_spec_limit", "status", "approval_state", "approval_date", "storage_loc", "retest_indicator", "notes", "location", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."samplenumber" AS "sample_number",
  TRIM("row_data"."businessline") AS "business_line",
  "row_data"."materialid" AS "material_id",
  "row_data"."lotnumber" AS "lot_number",
  "row_data"."containerref" AS "container_ref",
  COALESCE((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."analysistype" AS VARCHAR)))), NULL) AS "analysis_type",
  "row_data"."methodversion" AS "method_version",
  "row_data"."instrumentcode" AS "instrument_code",
  "row_data"."testedby" AS "tested_by",
  "row_data"."reviewedby" AS "reviewed_by",
  "row_data"."reqdate" AS "req_date",
  "row_data"."receiveddate" AS "received_date",
  "row_data"."startdate" AS "start_date",
  "row_data"."compdate" AS "comp_date",
  "row_data"."prioritylevel" AS "priority_level",
  "row_data"."requestedby" AS "requested_by",
  "row_data"."projectcode" AS "project_code",
  "row_data"."value" AS "value",
  COALESCE((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."uom" AS VARCHAR)))), NULL) AS "uom",
  "row_data"."lowerspeclimit" AS "lower_spec_limit",
  "row_data"."upperspeclimit" AS "upper_spec_limit",
  COALESCE((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."status" AS VARCHAR)))), NULL) AS "status",
  "row_data"."approvalstate" AS "approval_state",
  "row_data"."approvaldate" AS "approval_date",
  "row_data"."storageloc" AS "storage_loc",
  "row_data"."retestindicator" AS "retest_indicator",
  "row_data"."notes" AS "notes",
  "row_data"."location" AS "location",
  'lims_houston_samples' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."lims_houston_samples" AS "row_data" WHERE NOT (COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."analysistype" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."uom" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."status" AS VARCHAR)))) IS NULL), FALSE))) AS "row_data";
