-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT 'silver_lims_annandale' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL THEN 'Quantity type is unresolved for test method: '||COALESCE(TO_VARCHAR(s.test_type),'(missing)')
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'annandale' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_annandale s
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_houston' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL THEN 'Quantity type is unresolved for test method: '||COALESCE(TO_VARCHAR(s.test_type),'(missing)')
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'houston' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_houston s
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_curitiba' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL THEN 'Quantity type is unresolved for test method: '||COALESCE(TO_VARCHAR(s.test_type),'(missing)')
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'curitiba' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT 'silver_lims_buenos_aires' source_table,s.source_row_number source_row_number,'uom_conversion' rule_name,
      CASE WHEN CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL THEN 'Quantity type is unresolved for test method: '||COALESCE(TO_VARCHAR(s.test_type),'(missing)')
           WHEN u.canonical_code IS NULL THEN 'Unit is unrecognised: '||COALESCE(TO_VARCHAR(s.result_unit),'(missing)')
           ELSE 'Unit is recognised but no conversion path exists from '||u.canonical_code||' to '||qt.standard_unit END reason,
      'buenos_aires' site_code,'quarantined' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%APIGRAVITY%' THEN 'specific_gravity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%DENSITY%' THEN 'density'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%VISC%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('KV100','CCS','VI') THEN 'viscosity'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%FLASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%POURPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%CLOUDPOINT%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ANILINEPOINT%' THEN 'temperature'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULFUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%SULPHUR%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WEARMETALS%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ICP%' THEN 'sulfur_trace'
    WHEN REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%WATER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ASH%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%ACIDNUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') LIKE '%BASENUMBER%' OR REGEXP_REPLACE(UPPER(TRIM(s.test_type)), '[^A-Z0-9]', '') IN ('TAN','TBN') THEN 'concentration'
    ELSE NULL
  END IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL)));
