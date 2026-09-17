-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."tox_trial" (
              source_row_number integer PRIMARY KEY,
              "trialid" text,
"compoundid" text,
"trialtype" text,
"cro_name" text,
"studyprotocolid" text,
"trialdate" timestamp,
"speciestested" text,
"exposureroute" text,
"exposurelevel_mgkg" numeric,
"exposureduration_days" numeric,
"toxicityscore_1to5" numeric,
"ld50_value" numeric,
"noael_value" numeric,
"outcomestatus" text,
"regulatoryframework" text,
"reportreference" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."tox_trial" IS 'toxicology_trial_chemicals: 16 fields defined, 16 source columns, 16 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."tox_trial" (source_row_number, "trialid", "compoundid", "trialtype", "cro_name", "studyprotocolid", "trialdate", "speciestested", "exposureroute", "exposurelevel_mgkg", "exposureduration_days", "toxicityscore_1to5", "ld50_value", "noael_value", "outcomestatus", "regulatoryframework", "reportreference")
            SELECT row_number, raw_data ->> 'TRIAL_ID', raw_data ->> 'COMPOUND_ID', raw_data ->> 'TRIAL_TYPE', raw_data ->> 'CRO_NAME', raw_data ->> 'STUDY_PROTOCOL_ID', CASE
    WHEN NULLIF(raw_data ->> 'TRIAL_DATE', '') IS NULL THEN NULL
    WHEN raw_data ->> 'TRIAL_DATE' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'TRIAL_DATE', CASE WHEN length(raw_data ->> 'TRIAL_DATE') = 10 THEN 'DD/MM/YYYY' WHEN length(raw_data ->> 'TRIAL_DATE') = 16 THEN 'DD/MM/YYYY HH24:MI' ELSE 'DD/MM/YYYY HH24:MI:SS' END)
    ELSE raw_data ->> 'TRIAL_DATE'::timestamp END, raw_data ->> 'SPECIES_TESTED', raw_data ->> 'EXPOSURE_ROUTE', NULLIF(raw_data ->> 'EXPOSURE_LEVEL_MGKG', '')::numeric, NULLIF(raw_data ->> 'EXPOSURE_DURATION_DAYS', '')::numeric, NULLIF(raw_data ->> 'TOXICITY_SCORE_1TO5', '')::numeric, NULLIF(raw_data ->> 'LD50_VALUE', '')::numeric, NULLIF(raw_data ->> 'NOAEL_VALUE', '')::numeric, raw_data ->> 'OUTCOME_STATUS', raw_data ->> 'REGULATORY_FRAMEWORK', raw_data ->> 'REPORT_REFERENCE'
            FROM foundation_staging_rows WHERE staging_table_id = 10 ORDER BY row_number;
