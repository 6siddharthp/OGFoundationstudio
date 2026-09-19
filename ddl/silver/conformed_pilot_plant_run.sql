-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.conformed_pilot_plant_run (
            pilot_run_key text PRIMARY KEY, business_line text, run_date timestamp, feedstock_material_key text,
            product_material_key text, yield_percent numeric, throughput_kg_hr numeric, temperature_c numeric,
            pressure_bar numeric, deviation_flag boolean
          );
