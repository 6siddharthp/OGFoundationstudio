-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."pilot_plant_run_surrogate_key_view" AS
            SELECT "pilot_run_key" AS surrogate_key, *
            FROM silver."conformed_pilot_plant_run";
