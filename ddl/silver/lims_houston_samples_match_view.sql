-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_houston_samples_match_view" AS
            SELECT *, false AS identity_match
            FROM silver."conformed_lims_houston_samples";
