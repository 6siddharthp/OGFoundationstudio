-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."pilot_plant_run_match_view" AS
            SELECT *, false AS identity_match
            FROM silver."conformed_pilot_plant_run";
