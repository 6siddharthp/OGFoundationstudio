-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."fuel_trial" (
              source_row_number integer PRIMARY KEY,
              "trialid" text,
"blendid" text,
"fueltype" text,
"trialdate" timestamp,
"trialduration_hrs" numeric,
"cetanenumber" numeric,
"emissionsnox_ppm" numeric,
"emissionsco_ppm" numeric,
"emissionsparticulate_mgm3" numeric,
"combustionefficiency_pct" numeric,
"injectorfoulingrating" numeric,
"watercontent_ppm" numeric,
"sulfurcontent_ppm" numeric,
"density_kgm3" numeric,
"flashpoint_c" numeric,
"passfail" text,
"testengineerid" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."fuel_trial" IS 'fuel_trial_fuels: 17 fields defined, 17 source columns, 17 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."fuel_trial" (source_row_number, "trialid", "blendid", "fueltype", "trialdate", "trialduration_hrs", "cetanenumber", "emissionsnox_ppm", "emissionsco_ppm", "emissionsparticulate_mgm3", "combustionefficiency_pct", "injectorfoulingrating", "watercontent_ppm", "sulfurcontent_ppm", "density_kgm3", "flashpoint_c", "passfail", "testengineerid")
            SELECT row_number, raw_data ->> 'TRIAL_ID', raw_data ->> 'BLEND_ID', raw_data ->> 'FUEL_TYPE', CASE
    WHEN NULLIF(raw_data ->> 'TRIAL_DATE', '') IS NULL THEN NULL
    WHEN raw_data ->> 'TRIAL_DATE' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'TRIAL_DATE', (CASE
    WHEN split_part(raw_data ->> 'TRIAL_DATE', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'TRIAL_DATE', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'DD/MM/YYYY' END) || CASE WHEN length(raw_data ->> 'TRIAL_DATE') = 10 THEN '' WHEN length(raw_data ->> 'TRIAL_DATE') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'TRIAL_DATE')::timestamp END, NULLIF(raw_data ->> 'TRIAL_DURATION_HRS', '')::numeric, NULLIF(raw_data ->> 'CETANE_NUMBER', '')::numeric, NULLIF(raw_data ->> 'EMISSIONS_NOX_PPM', '')::numeric, NULLIF(raw_data ->> 'EMISSIONS_CO_PPM', '')::numeric, NULLIF(raw_data ->> 'EMISSIONS_PARTICULATE_MGM3', '')::numeric, NULLIF(raw_data ->> 'COMBUSTION_EFFICIENCY_PCT', '')::numeric, NULLIF(raw_data ->> 'INJECTOR_FOULING_RATING', '')::numeric, NULLIF(raw_data ->> 'WATER_CONTENT_PPM', '')::numeric, NULLIF(raw_data ->> 'SULFUR_CONTENT_PPM', '')::numeric, NULLIF(raw_data ->> 'DENSITY_KGM3', '')::numeric, NULLIF(raw_data ->> 'FLASH_POINT_C', '')::numeric, raw_data ->> 'PASS_FAIL', raw_data ->> 'TEST_ENGINEER_ID'
            FROM foundation_staging_rows WHERE staging_table_id = 6 ORDER BY row_number;
