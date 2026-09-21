-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lims_buenos_aires_match_view" AS
            SELECT *, false AS identity_match
            FROM silver."conformed_lims_buenos_aires";
