-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."fact_test_result" (test_result_key text PRIMARY KEY, lab_sample_key text REFERENCES gold.fact_lab_sample(lab_sample_key), test_method_key text REFERENCES gold.dim_test_method(test_method_key), material_key text REFERENCES gold.dim_material(material_key), date_key integer REFERENCES gold.dim_date(date_key), result_value numeric, result_unit text, spec_lower_limit numeric, spec_upper_limit numeric, within_spec boolean);

-- foundation:stage 9
INSERT INTO gold.fact_test_result SELECT test_result_key, lab_sample_key, test_method_key, material_key, to_char(result_date,'YYYYMMDD')::integer, result_value, result_unit, spec_lower_limit, spec_upper_limit, within_spec FROM silver.conformed_test_result;
