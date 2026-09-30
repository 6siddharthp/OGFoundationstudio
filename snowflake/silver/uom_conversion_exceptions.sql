-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT 'silver_lims_annandale' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN 'Quantity type not set for this test method'
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'annandale' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_annandale s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_annandale_samples b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), '[^A-Z0-9]', '')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), '[^A-Z0-9]', '')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_houston' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN 'Quantity type not set for this test method'
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'houston' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_houston s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_houston_samples b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), '[^A-Z0-9]', '')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), '[^A-Z0-9]', '')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_curitiba' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN 'Quantity type not set for this test method'
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'curitiba' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_curitiba_amostras b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), '[^A-Z0-9]', '')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), '[^A-Z0-9]', '')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_buenos_aires' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN 'Quantity type not set for this test method'
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'buenos_aires' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
    LEFT JOIN OGFS_DEMO.BRONZE.lab_muestras_ba b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), '[^A-Z0-9]', '')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), '[^A-Z0-9]', '')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL)));
