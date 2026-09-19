-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lab_muestras_ba_surrogate_key_view" AS
            SELECT "lab_muestras_ba_key" AS surrogate_key, *
            FROM silver."conformed_lab_muestras_ba";
