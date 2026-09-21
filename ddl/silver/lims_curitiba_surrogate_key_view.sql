-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_curitiba_surrogate_key_view" AS
            SELECT "lims_curitiba_key" AS surrogate_key, *
            FROM silver."conformed_lims_curitiba";
