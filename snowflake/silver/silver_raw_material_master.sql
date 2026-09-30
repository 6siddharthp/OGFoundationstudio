-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_raw_material_master AS
 SELECT row_data.source_row_number,
  row_data.canonical_material_name AS canonical_material_name,
  row_data.business_line AS business_line,
  row_data.source_material_code AS source_material_code,
  row_data.legacy_material_id AS legacy_material_id,
  row_data.cas_number AS cas_number,
  row_data.supplier AS supplier,
  row_data.supplier_grade AS supplier_grade,
  row_data.unit_of_measure AS unit_of_measure,
  row_data.density AS density,
  row_data.viscosity_grade AS viscosity_grade,
  row_data.hazard_classification AS hazard_classification,
  row_data.safety_data_sheet_ref AS safety_data_sheet_ref,
  row_data.shelf_life_months AS shelf_life_months,
  row_data.storage_conditions AS storage_conditions,
  row_data.approved_for_use AS approved_for_use,
  row_data.last_review_date AS last_review_date,
  'raw_material_master' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.raw_material_master AS row_data WHERE NOT (FALSE)) AS row_data;
