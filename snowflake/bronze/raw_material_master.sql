-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.BRONZE."raw_material_master" AS
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS source_row_number,
       "CANONICAL_MATERIAL_NAME"::VARCHAR AS "canonicalmaterialname",
       "BUSINESS_LINE"::VARCHAR AS "businessline",
       "SOURCE_MATERIAL_CODE"::VARCHAR AS "sourcematerialcode",
       "LEGACY_MATERIAL_ID"::VARCHAR AS "legacymaterialid",
       "CASNUMBER"::VARCHAR AS "casnumber",
       "SUPPLIER"::VARCHAR AS "supplier",
       "SUPPLIER_GRADE"::VARCHAR AS "suppliergrade",
       "UNIT_OF_MEASURE"::VARCHAR AS "unitofmeasure",
       TRY_TO_DECIMAL(TO_VARCHAR("DENSITY"), 38, 10)::NUMBER AS "density",
       "VISCOSITY_GRADE"::VARCHAR AS "viscositygrade",
       "HAZARD_CLASSIFICATION"::VARCHAR AS "hazardclassification",
       "SAFETY_DATA_SHEET_REF"::VARCHAR AS "safetydatasheetref",
       TRY_TO_DECIMAL(TO_VARCHAR("SHELF_LIFE_MONTHS"), 38, 10)::NUMBER AS "shelflifemonths",
       "STORAGE_CONDITIONS"::VARCHAR AS "storageconditions",
       TRY_TO_BOOLEAN("APPROVED_FOR_USE")::BOOLEAN AS "approvedforuse",
       TRY_TO_DATE("LAST_REVIEW_DATE", 'YYYY-MM-DD')::DATE AS "lastreviewdate",
       CURRENT_TIMESTAMP() AS loaded_at
FROM OGFS_DEMO.SOURCE."RAW_MATERIAL_MASTER";
