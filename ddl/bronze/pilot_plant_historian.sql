-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."pilot_plant_historian" (
              source_row_number integer PRIMARY KEY,
              "runid" text,
"businessline" text,
"unit" text,
"starttimestamp" timestamp,
"endtimestamp" timestamp,
"yield_percent" numeric,
"throughput_kg_hr" numeric,
"temperature_c" numeric,
"pressure_bar" numeric,
"flowrate_lmin" numeric,
"ph_level" numeric,
"agitation_rpm" numeric,
"feedstockmaterialid" text,
"productmaterialid" text,
"batchoperator" text,
"deviationflag" boolean,
"deviationdescription" text,
"safetyincidentflag" boolean,
"energyconsumption_kwh" numeric,
"wastegenerated_kg" numeric,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."pilot_plant_historian" IS 'pilot_plant_historian: 20 fields defined, 20 source columns, 20 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."pilot_plant_historian" (source_row_number, "runid", "businessline", "unit", "starttimestamp", "endtimestamp", "yield_percent", "throughput_kg_hr", "temperature_c", "pressure_bar", "flowrate_lmin", "ph_level", "agitation_rpm", "feedstockmaterialid", "productmaterialid", "batchoperator", "deviationflag", "deviationdescription", "safetyincidentflag", "energyconsumption_kwh", "wastegenerated_kg")
            SELECT row_number, raw_data ->> 'RUN_ID', raw_data ->> 'BUSINESS_LINE', raw_data ->> 'UNIT', CASE
    WHEN NULLIF(raw_data ->> 'START_TIMESTAMP', '') IS NULL THEN NULL
    WHEN raw_data ->> 'START_TIMESTAMP' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'START_TIMESTAMP', (CASE
    WHEN split_part(raw_data ->> 'START_TIMESTAMP', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'START_TIMESTAMP', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'DD/MM/YYYY' END) || CASE WHEN length(raw_data ->> 'START_TIMESTAMP') = 10 THEN '' WHEN length(raw_data ->> 'START_TIMESTAMP') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'START_TIMESTAMP')::timestamp END, CASE
    WHEN NULLIF(raw_data ->> 'END_TIMESTAMP', '') IS NULL THEN NULL
    WHEN raw_data ->> 'END_TIMESTAMP' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'END_TIMESTAMP', (CASE
    WHEN split_part(raw_data ->> 'END_TIMESTAMP', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'END_TIMESTAMP', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'DD/MM/YYYY' END) || CASE WHEN length(raw_data ->> 'END_TIMESTAMP') = 10 THEN '' WHEN length(raw_data ->> 'END_TIMESTAMP') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'END_TIMESTAMP')::timestamp END, NULLIF(raw_data ->> 'YIELD_PERCENT', '')::numeric, NULLIF(raw_data ->> 'THROUGHPUT_KG_HR', '')::numeric, NULLIF(raw_data ->> 'TEMPERATURE_C', '')::numeric, NULLIF(raw_data ->> 'PRESSURE_BAR', '')::numeric, NULLIF(raw_data ->> 'FLOW_RATE_LMIN', '')::numeric, NULLIF(raw_data ->> 'P_H_LEVEL', '')::numeric, NULLIF(raw_data ->> 'AGITATION_RPM', '')::numeric, raw_data ->> 'FEEDSTOCK_MATERIAL_ID', raw_data ->> 'PRODUCT_MATERIAL_ID', raw_data ->> 'BATCH_OPERATOR', CASE lower(raw_data ->> 'DEVIATION_FLAG') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'DEVIATION_DESCRIPTION', CASE lower(raw_data ->> 'SAFETY_INCIDENT_FLAG') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, NULLIF(raw_data ->> 'ENERGY_CONSUMPTION_K_WH', '')::numeric, NULLIF(raw_data ->> 'WASTE_GENERATED_KG', '')::numeric
            FROM foundation_staging_rows WHERE staging_table_id = 9 ORDER BY row_number;
