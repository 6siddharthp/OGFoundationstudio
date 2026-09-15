-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_test_method" (test_method_key text PRIMARY KEY, governed_standard_reference text, standard_body text, method_title text, applies_to_business_line text);

-- foundation:stage 8
INSERT INTO gold.dim_test_method SELECT test_method_key, governed_standard_reference, standard_body, method_title, applies_to_business_line FROM silver.conformed_test_method;
