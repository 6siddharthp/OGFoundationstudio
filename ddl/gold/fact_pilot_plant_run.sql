-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."fact_pilot_plant_run" (pilot_run_key text PRIMARY KEY, business_line_key text REFERENCES gold.dim_business_line(business_line_key), date_key integer REFERENCES gold.dim_date(date_key), feedstock_material_key text REFERENCES gold.dim_material(material_key), product_material_key text REFERENCES gold.dim_material(material_key), yield_percent numeric, throughput_kg_hr numeric, temperature_c numeric, pressure_bar numeric, deviation_flag boolean);

-- foundation:stage 9
INSERT INTO gold.fact_pilot_plant_run SELECT pilot_run_key,
            CASE lower(business_line) WHEN 'lubricants' THEN 'BIZ_LUBRICANTS' WHEN 'fuels' THEN 'BIZ_FUELS' WHEN 'chemicals' THEN 'BIZ_CHEMICALS' END,
            to_char(run_date,'YYYYMMDD')::integer, feedstock_material_key, product_material_key,
            yield_percent, throughput_kg_hr, temperature_c, pressure_bar, deviation_flag
          FROM silver.conformed_pilot_plant_run;
