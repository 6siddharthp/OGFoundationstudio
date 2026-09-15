-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lab_sample_surrogate_key_view" AS
            SELECT "lab_sample_key" AS surrogate_key, *
            FROM silver."conformed_lab_sample";
