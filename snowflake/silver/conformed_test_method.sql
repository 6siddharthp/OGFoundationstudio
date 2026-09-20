-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_method AS
WITH methods AS (SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_annandale_samples
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_houston_samples
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_curitiba_amostras
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lab_muestras_ba)
SELECT 'MTH_' || MD5(COALESCE(r.governed_standard_reference, m.test_type)) test_method_key,
 COALESCE(r.governed_standard_reference, m.test_type) governed_standard_reference,
 MIN(r.standard_body) standard_body, MIN(r.method_title) method_title,
 MIN(r.applies_to_business_line) applies_to_business_line, COUNT(*) source_record_count
FROM methods m LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference r
 ON REGEXP_REPLACE(UPPER(TRIM(m.test_type)), '[^A-Z0-9]', '') =
    REGEXP_REPLACE(UPPER(TRIM(r.source_method_name)), '[^A-Z0-9]', '')
GROUP BY COALESCE(r.governed_standard_reference, m.test_type);
