-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_houston_samples_surrogate_key_view" AS
            SELECT "lims_houston_samples_key" AS surrogate_key, *
            FROM silver."conformed_lims_houston_samples";
