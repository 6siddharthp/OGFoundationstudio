-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver."silver_toxicology_trial_chemicals" (
              source_row_number integer PRIMARY KEY,
              "trial_id" text,
"compound_id" text,
"trial_type" text,
"cro_name" text,
"study_protocol_id" text,
"trial_date" timestamp,
"species_tested" text,
"exposure_route" text,
"exposure_level_mgkg" numeric,
"exposure_duration_days" numeric,
"toxicity_score_1_to_5" numeric,
"ld50_value" numeric,
"noael_value" numeric,
"outcome_status" text,
"regulatory_framework" text,
"report_reference" text,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_toxicology_trial_chemicals" (
              source_row_number, "trial_id", "compound_id", "trial_type", "cro_name", "study_protocol_id", "trial_date", "species_tested", "exposure_route", "exposure_level_mgkg", "exposure_duration_days", "toxicity_score_1_to_5", "ld50_value", "noael_value", "outcome_status", "regulatory_framework", "report_reference", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."trialid" AS "trial_id",
  "row_data"."compoundid" AS "compound_id",
  "row_data"."trialtype" AS "trial_type",
  "row_data"."cro_name" AS "cro_name",
  "row_data"."studyprotocolid" AS "study_protocol_id",
  "row_data"."trialdate" AS "trial_date",
  "row_data"."speciestested" AS "species_tested",
  "row_data"."exposureroute" AS "exposure_route",
  "row_data"."exposurelevel_mgkg" AS "exposure_level_mgkg",
  "row_data"."exposureduration_days" AS "exposure_duration_days",
  "row_data"."toxicityscore_1to5" AS "toxicity_score_1_to_5",
  "row_data"."ld50_value" AS "ld50_value",
  "row_data"."noael_value" AS "noael_value",
  "row_data"."outcomestatus" AS "outcome_status",
  "row_data"."regulatoryframework" AS "regulatory_framework",
  "row_data"."reportreference" AS "report_reference",
  'tox_trial' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."tox_trial" AS "row_data" WHERE NOT (FALSE)) AS "row_data";
