-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE.raw_material_master AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       CANONICAL_MATERIAL_NAME::VARCHAR AS canonical_material_name,
       BUSINESS_LINE::VARCHAR AS business_line,
       SOURCE_MATERIAL_CODE::VARCHAR AS source_material_code,
       LEGACY_MATERIAL_ID::VARCHAR AS legacy_material_id,
       CASNUMBER::VARCHAR AS cas_number,
       SUPPLIER::VARCHAR AS supplier,
       SUPPLIER_GRADE::VARCHAR AS supplier_grade,
       UNIT_OF_MEASURE::VARCHAR AS unit_of_measure,
       TRY_TO_DECIMAL(TO_VARCHAR(DENSITY), 38, 10)::NUMBER AS density,
       TRY_TO_DECIMAL(TO_VARCHAR(VISCOSITY_GRADE), 38, 10)::NUMBER AS viscosity_grade,
       HAZARD_CLASSIFICATION::VARCHAR AS hazard_classification,
       SAFETY_DATA_SHEET_REF::VARCHAR AS safety_data_sheet_ref,
       TRY_TO_DECIMAL(TO_VARCHAR(SHELF_LIFE_MONTHS), 38, 10)::NUMBER AS shelf_life_months,
       STORAGE_CONDITIONS::VARCHAR AS storage_conditions,
       TRY_TO_BOOLEAN(TO_VARCHAR(APPROVED_FOR_USE))::BOOLEAN AS approved_for_use,
       TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(LAST_REVIEW_DATE))::TIMESTAMP_NTZ AS last_review_date,
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE.RAW_MATERIAL_MASTER;
