-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_buenos_aires_surrogate_key_view" AS
            SELECT "lims_buenos_aires_key" AS surrogate_key, *
            FROM silver."conformed_lims_buenos_aires";
