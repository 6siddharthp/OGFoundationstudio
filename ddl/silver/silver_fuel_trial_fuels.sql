-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver."silver_fuel_trial_fuels" (
              source_row_number integer PRIMARY KEY,
              "trial_id" text,
"blend_id" text,
"fuel_type" text,
"trial_date" timestamp,
"trial_duration_hrs" numeric,
"cetane_number" numeric,
"emissions_nox_ppm" numeric,
"emissions_co_ppm" numeric,
"emissions_particulate_mgm3" numeric,
"combustion_efficiency_pct" numeric,
"injector_fouling_rating" numeric,
"water_content_ppm" numeric,
"sulfur_content_ppm" numeric,
"density_kgm3" numeric,
"flash_point_c" numeric,
"pass_fail" text,
"test_engineer_id" text,
"record_hash" text,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_fuel_trial_fuels" (
              source_row_number, "trial_id", "blend_id", "fuel_type", "trial_date", "trial_duration_hrs", "cetane_number", "emissions_nox_ppm", "emissions_co_ppm", "emissions_particulate_mgm3", "combustion_efficiency_pct", "injector_fouling_rating", "water_content_ppm", "sulfur_content_ppm", "density_kgm3", "flash_point_c", "pass_fail", "test_engineer_id", "record_hash", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."trialid" AS "trial_id",
  "row_data"."blendid" AS "blend_id",
  "row_data"."fueltype" AS "fuel_type",
  "row_data"."trialdate" AS "trial_date",
  "row_data"."trialduration_hrs" AS "trial_duration_hrs",
  "row_data"."cetanenumber" AS "cetane_number",
  "row_data"."emissionsnox_ppm" AS "emissions_nox_ppm",
  "row_data"."emissionsco_ppm" AS "emissions_co_ppm",
  "row_data"."emissionsparticulate_mgm3" AS "emissions_particulate_mgm3",
  "row_data"."combustionefficiency_pct" AS "combustion_efficiency_pct",
  "row_data"."injectorfoulingrating" AS "injector_fouling_rating",
  "row_data"."watercontent_ppm" AS "water_content_ppm",
  "row_data"."sulfurcontent_ppm" AS "sulfur_content_ppm",
  "row_data"."density_kgm3" AS "density_kgm3",
  "row_data"."flashpoint_c" AS "flash_point_c",
  "row_data"."passfail" AS "pass_fail",
  "row_data"."testengineerid" AS "test_engineer_id",
  MD5(COALESCE("row_data"."trialid", '')) AS "record_hash",
  'fuel_trial' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."fuel_trial" AS "row_data" WHERE NOT (FALSE)) AS "row_data";
