-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.conformed_pilot_plant_run (
            pilot_run_key text PRIMARY KEY, business_line text, run_date timestamp, feedstock_material_key text,
            product_material_key text, yield_percent numeric, throughput_kg_hr numeric, temperature_c numeric,
            pressure_bar numeric, deviation_flag boolean
          );

-- foundation:stage 6
INSERT INTO silver.conformed_pilot_plant_run
          SELECT 'RUN_' || md5(source_row_number::text), business_line, start_timestamp,
            NULL::text, NULL::text, yield_percent, throughput_kg_hr, temperature_c, pressure_bar,
            coalesce(deviation_flag, false)
          FROM silver."silver_pilot_plant_historian";
