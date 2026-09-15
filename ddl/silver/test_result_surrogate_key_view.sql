-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."test_result_surrogate_key_view" AS
            SELECT "test_result_key" AS surrogate_key, *
            FROM silver."conformed_test_result";
