-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_raw_material_master AS
SELECT "row_data"."source_row_number",
  "row_data"."canonicalmaterialname" AS "canonical_material_name",
  "row_data"."businessline" AS "business_line",
  "row_data"."sourcematerialcode" AS "source_material_code",
  "row_data"."legacymaterialid" AS "legacy_material_id",
  "row_data"."casnumber" AS "cas_number",
  "row_data"."supplier" AS "supplier",
  "row_data"."suppliergrade" AS "supplier_grade",
  "row_data"."unitofmeasure" AS "unit_of_measure",
  "row_data"."density" AS "density",
  "row_data"."viscositygrade" AS "viscosity_grade",
  "row_data"."hazardclassification" AS "hazard_classification",
  "row_data"."safetydatasheetref" AS "safety_data_sheet_ref",
  "row_data"."shelflifemonths" AS "shelf_life_months",
  "row_data"."storageconditions" AS "storage_conditions",
  "row_data"."approvedforuse" AS "approved_for_use",
  "row_data"."lastreviewdate" AS "last_review_date",
  'raw_material_master' AS "source_table"
FROM (SELECT "row_data".* FROM OGFS_DEMO.BRONZE."raw_material_master" AS "row_data" WHERE NOT (FALSE)) AS "row_data";
