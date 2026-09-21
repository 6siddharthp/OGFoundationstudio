-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_annandale_surrogate_key_view" AS
            SELECT "lims_annandale_key" AS surrogate_key, *
            FROM silver."conformed_lims_annandale";
