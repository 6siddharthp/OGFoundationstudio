-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_houston_surrogate_key_view" AS
            SELECT "lims_houston_key" AS surrogate_key, *
            FROM silver."conformed_lims_houston";
