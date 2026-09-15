-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."test_method_surrogate_key_view" AS
            SELECT "test_method_key" AS surrogate_key, *
            FROM silver."conformed_test_method";
