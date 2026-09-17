-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.quarantine_records (
          quarantine_id bigserial PRIMARY KEY, source_table text NOT NULL, source_row_number integer NOT NULL,
          reason text NOT NULL, source_data jsonb NOT NULL, quarantined_at timestamptz NOT NULL DEFAULT now()
        );

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'engine_test_cell', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))) IS NULL THEN 'TestStandard: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."engine_test_cell" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lab_muestras_ba', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL THEN 'test_type: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL THEN 'result_unit: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL THEN 'sample_status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lab_muestras_ba" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lims_annandale_samples', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL THEN 'test_type: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL THEN 'result_unit: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL THEN 'sample_status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lims_annandale_samples" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lims_curitiba_amostras', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL THEN 'test_type: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL THEN 'result_unit: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL THEN 'sample_status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lims_curitiba_amostras" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE);

-- foundation:stage 5
INSERT INTO silver.quarantine_records (source_table, source_row_number, reason, source_data)
              SELECT 'lims_houston_samples', "row_data"."source_row_number", CASE WHEN (SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL THEN 'test_type: Code lookup failed'
WHEN (SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL THEN 'result_unit: Code lookup failed'
WHEN (SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL THEN 'sample_status: Code lookup failed' ELSE 'Silver rule failed' END,
                to_jsonb("row_data") - 'source_row_number' - 'loaded_at'
              FROM "bronze"."lims_houston_samples" AS "row_data"
              WHERE COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."test_type" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_unit" FROM "reference_data"."governed_uom_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_unit" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."result_unit" AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT "ref"."governed_status" FROM "reference_data"."governed_sample_status_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_value" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."sample_status" AS VARCHAR)))) IS NULL), FALSE);
-- foundation:stage 4
CREATE TABLE silver."silver_engine_test_cell_lubricants" (
              source_row_number integer PRIMARY KEY,
              "test_id" text,
"formulation_id" text,
"engine_type" text,
"test_standard" text,
"test_cell_id" text,
"test_date" timestamp,
"test_duration_hrs" numeric,
"oil_charge_volume_l" numeric,
"wear_rate_mg" numeric,
"fuel_economy_pct_vs_baseline" numeric,
"deposit_rating_1_to_10" numeric,
"viscosity_at_40_c" numeric,
"viscosity_at_100_c" numeric,
"oxidation_index" numeric,
"tan_mg_ko_hg" numeric,
"fuel_dilution_pct" numeric,
"wear_metals_ppm" numeric,
"pass_fail" text,
"test_engineer_id" text,
"certification_batch" text,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_engine_test_cell_lubricants" (
              source_row_number, "test_id", "formulation_id", "engine_type", "test_standard", "test_cell_id", "test_date", "test_duration_hrs", "oil_charge_volume_l", "wear_rate_mg", "fuel_economy_pct_vs_baseline", "deposit_rating_1_to_10", "viscosity_at_40_c", "viscosity_at_100_c", "oxidation_index", "tan_mg_ko_hg", "fuel_dilution_pct", "wear_metals_ppm", "pass_fail", "test_engineer_id", "certification_batch", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."testid" AS "test_id",
  "row_data"."formulationid" AS "formulation_id",
  "row_data"."enginetype" AS "engine_type",
  COALESCE((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))), NULL) AS "test_standard",
  "row_data"."testcellid" AS "test_cell_id",
  "row_data"."testdate" AS "test_date",
  "row_data"."testduration_hrs" AS "test_duration_hrs",
  "row_data"."oilchargevolume_l" AS "oil_charge_volume_l",
  "row_data"."wearrate_mg" AS "wear_rate_mg",
  "row_data"."fueleconomy_pct_vs_baseline" AS "fuel_economy_pct_vs_baseline",
  "row_data"."depositrating_1to10" AS "deposit_rating_1_to_10",
  "row_data"."viscosityat40c" AS "viscosity_at_40_c",
  "row_data"."viscosityat100c" AS "viscosity_at_100_c",
  "row_data"."oxidationindex" AS "oxidation_index",
  "row_data"."tan_mgkohg" AS "tan_mg_ko_hg",
  "row_data"."fueldilution_pct" AS "fuel_dilution_pct",
  "row_data"."wearmetalsppm" AS "wear_metals_ppm",
  "row_data"."passfail" AS "pass_fail",
  "row_data"."testengineerid" AS "test_engineer_id",
  "row_data"."certificationbatch" AS "certification_batch",
  'engine_test_cell' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."engine_test_cell" AS "row_data" WHERE NOT (COALESCE(((SELECT "ref"."governed_standard_reference" FROM "reference_data"."governed_astm_ilsac_test_method_reference" AS "ref" WHERE LOWER(TRIM(CAST("ref"."source_method_name" AS VARCHAR))) = LOWER(TRIM(CAST("row_data"."teststandard" AS VARCHAR)))) IS NULL), FALSE))) AS "row_data";
