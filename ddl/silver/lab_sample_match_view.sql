-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."lab_sample_match_view" AS
            SELECT *, source_system_count > 1 AS identity_match
            FROM silver."conformed_lab_sample";
