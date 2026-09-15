-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver."silver_raw_material_master" (
              source_row_number integer PRIMARY KEY,
              "canonical_material_name" text,
"business_line" text,
"clinton_material_code" text,
"houston_material_id" text,
"cas_number" text,
"supplier" text,
"supplier_grade" text,
"unit_of_measure" text,
"density" numeric,
"viscosity_grade" numeric,
"hazard_classification" text,
"safety_data_sheet_ref" text,
"shelf_life_months" numeric,
"storage_conditions" text,
"approved_for_use" boolean,
"last_review_date" timestamp,
              source_table text NOT NULL,
              cleansed_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 5
INSERT INTO silver."silver_raw_material_master" (
              source_row_number, "canonical_material_name", "business_line", "clinton_material_code", "houston_material_id", "cas_number", "supplier", "supplier_grade", "unit_of_measure", "density", "viscosity_grade", "hazard_classification", "safety_data_sheet_ref", "shelf_life_months", "storage_conditions", "approved_for_use", "last_review_date", source_table
            )
            SELECT "row_data"."source_row_number",
  "row_data"."canonicalmaterialname" AS "canonical_material_name",
  "row_data"."businessline" AS "business_line",
  "row_data"."clintonmaterialcode" AS "clinton_material_code",
  "row_data"."houstonmaterialid" AS "houston_material_id",
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
FROM (SELECT "row_data".* FROM "bronze"."raw_material_master" AS "row_data" WHERE NOT (FALSE)) AS "row_data";
