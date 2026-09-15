-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."engine_test_cell" (
              source_row_number integer PRIMARY KEY,
              "testid" text,
"formulationid" text,
"enginetype" text,
"teststandard" text,
"testcellid" text,
"testdate" timestamp,
"testduration_hrs" numeric,
"oilchargevolume_l" numeric,
"wearrate_mg" numeric,
"fueleconomy_pct_vs_baseline" numeric,
"depositrating_1to10" numeric,
"viscosityat40c" numeric,
"viscosityat100c" numeric,
"oxidationindex" numeric,
"tan_mgkohg" numeric,
"fueldilution_pct" numeric,
"wearmetalsppm" numeric,
"passfail" text,
"testengineerid" text,
"certificationbatch" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."engine_test_cell" IS 'engine_test_cell_lubricants: 20 fields defined, 20 source columns, 20 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."engine_test_cell" (source_row_number, "testid", "formulationid", "enginetype", "teststandard", "testcellid", "testdate", "testduration_hrs", "oilchargevolume_l", "wearrate_mg", "fueleconomy_pct_vs_baseline", "depositrating_1to10", "viscosityat40c", "viscosityat100c", "oxidationindex", "tan_mgkohg", "fueldilution_pct", "wearmetalsppm", "passfail", "testengineerid", "certificationbatch")
            SELECT row_number, raw_data ->> 'TEST_ID', raw_data ->> 'FORMULATION_ID', raw_data ->> 'ENGINE_TYPE', raw_data ->> 'TEST_STANDARD', raw_data ->> 'TEST_CELL_ID', NULLIF(raw_data ->> 'TEST_DATE', '')::timestamp, NULLIF(raw_data ->> 'TEST_DURATION_HRS', '')::numeric, NULLIF(raw_data ->> 'OIL_CHARGE_VOLUME_L', '')::numeric, NULLIF(raw_data ->> 'WEAR_RATE_MG', '')::numeric, NULLIF(raw_data ->> 'FUEL_ECONOMY_PCT_VS_BASELINE', '')::numeric, NULLIF(raw_data ->> 'DEPOSIT_RATING_1TO10', '')::numeric, NULLIF(raw_data ->> 'VISCOSITY_AT40_C', '')::numeric, NULLIF(raw_data ->> 'VISCOSITY_AT100_C', '')::numeric, NULLIF(raw_data ->> 'OXIDATION_INDEX', '')::numeric, NULLIF(raw_data ->> 'TAN_MG_KOHG', '')::numeric, NULLIF(raw_data ->> 'FUEL_DILUTION_PCT', '')::numeric, NULLIF(raw_data ->> 'WEAR_METALS_PPM', '')::numeric, raw_data ->> 'PASS_FAIL', raw_data ->> 'TEST_ENGINEER_ID', raw_data ->> 'CERTIFICATION_BATCH'
            FROM foundation_staging_rows WHERE staging_table_id = 5 ORDER BY row_number;
