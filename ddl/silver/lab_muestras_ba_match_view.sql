-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lab_muestras_ba_match_view" AS
            SELECT *, false AS identity_match
            FROM silver."conformed_lab_muestras_ba";
