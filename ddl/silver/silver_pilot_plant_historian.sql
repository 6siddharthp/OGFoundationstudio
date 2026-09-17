-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver."silver_pilot_plant_historian" (
              source_row_number integer PRIMARY KEY,
              "run_id" text,
"business_line" text,
"unit" text,
"start_timestamp" timestamp,
"end_timestamp" timestamp,
"yield_percent" numeric,
"throughput_kg_hr" numeric,
"temperature_c" numeric,
"pressure_bar" numeric,
"flow_rate_lmin" numeric,
"p_h_level" numeric,
"agitation_rpm" numeric,
"feedstock_material_id" text,
"product_material_id" text,
"batch_operator" text,
"deviation_flag" boolean,
"deviation_description" text,
"safety_incident_flag" boolean,
"energy_consumption_k_wh" numeric,
"waste_generated_kg" numeric,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_pilot_plant_historian" (
              source_row_number, "run_id", "business_line", "unit", "start_timestamp", "end_timestamp", "yield_percent", "throughput_kg_hr", "temperature_c", "pressure_bar", "flow_rate_lmin", "p_h_level", "agitation_rpm", "feedstock_material_id", "product_material_id", "batch_operator", "deviation_flag", "deviation_description", "safety_incident_flag", "energy_consumption_k_wh", "waste_generated_kg", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."runid" AS "run_id",
  "row_data"."businessline" AS "business_line",
  "row_data"."unit" AS "unit",
  "row_data"."starttimestamp" AS "start_timestamp",
  "row_data"."endtimestamp" AS "end_timestamp",
  "row_data"."yield_percent" AS "yield_percent",
  "row_data"."throughput_kg_hr" AS "throughput_kg_hr",
  "row_data"."temperature_c" AS "temperature_c",
  "row_data"."pressure_bar" AS "pressure_bar",
  "row_data"."flowrate_lmin" AS "flow_rate_lmin",
  "row_data"."ph_level" AS "p_h_level",
  "row_data"."agitation_rpm" AS "agitation_rpm",
  "row_data"."feedstockmaterialid" AS "feedstock_material_id",
  "row_data"."productmaterialid" AS "product_material_id",
  "row_data"."batchoperator" AS "batch_operator",
  "row_data"."deviationflag" AS "deviation_flag",
  "row_data"."deviationdescription" AS "deviation_description",
  "row_data"."safetyincidentflag" AS "safety_incident_flag",
  "row_data"."energyconsumption_kwh" AS "energy_consumption_k_wh",
  "row_data"."wastegenerated_kg" AS "waste_generated_kg",
  'pilot_plant_historian' AS "source_table"
FROM (SELECT "row_data".* FROM "bronze"."pilot_plant_historian" AS "row_data" WHERE NOT (FALSE)) AS "row_data";
