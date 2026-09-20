-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."raw_material_master" (
              source_row_number integer PRIMARY KEY,
              "canonicalmaterialname" text,
"businessline" text,
"sourcematerialcode" text,
"legacymaterialid" text,
"casnumber" text,
"supplier" text,
"suppliergrade" text,
"unitofmeasure" text,
"density" numeric,
"viscositygrade" numeric,
"hazardclassification" text,
"safetydatasheetref" text,
"shelflifemonths" numeric,
"storageconditions" text,
"approvedforuse" boolean,
"lastreviewdate" timestamp,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."raw_material_master" IS 'raw_material_master: 16 fields defined, 16 source columns, 16 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."raw_material_master" (source_row_number, "canonicalmaterialname", "businessline", "sourcematerialcode", "legacymaterialid", "casnumber", "supplier", "suppliergrade", "unitofmeasure", "density", "viscositygrade", "hazardclassification", "safetydatasheetref", "shelflifemonths", "storageconditions", "approvedforuse", "lastreviewdate")
            SELECT row_number, raw_data ->> 'CANONICAL_MATERIAL_NAME', raw_data ->> 'BUSINESS_LINE', raw_data ->> 'SOURCE_MATERIAL_CODE', raw_data ->> 'LEGACY_MATERIAL_ID', raw_data ->> 'CASNUMBER', raw_data ->> 'SUPPLIER', raw_data ->> 'SUPPLIER_GRADE', raw_data ->> 'UNIT_OF_MEASURE', NULLIF(raw_data ->> 'DENSITY', '')::numeric, NULLIF(raw_data ->> 'VISCOSITY_GRADE', '')::numeric, raw_data ->> 'HAZARD_CLASSIFICATION', raw_data ->> 'SAFETY_DATA_SHEET_REF', NULLIF(raw_data ->> 'SHELF_LIFE_MONTHS', '')::numeric, raw_data ->> 'STORAGE_CONDITIONS', CASE lower(raw_data ->> 'APPROVED_FOR_USE') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, CASE
    WHEN NULLIF(raw_data ->> 'LAST_REVIEW_DATE', '') IS NULL THEN NULL
    WHEN raw_data ->> 'LAST_REVIEW_DATE' ~ '^\d{2}/\d{2}/\d{4}([ T]\d{2}:\d{2}(:\d{2})?)?$'
      THEN to_timestamp(raw_data ->> 'LAST_REVIEW_DATE', (CASE
    WHEN split_part(raw_data ->> 'LAST_REVIEW_DATE', '/', 1)::integer > 12 THEN 'DD/MM/YYYY'
    WHEN split_part(raw_data ->> 'LAST_REVIEW_DATE', '/', 2)::integer > 12 THEN 'MM/DD/YYYY'
    ELSE 'DD/MM/YYYY' END) || CASE WHEN length(raw_data ->> 'LAST_REVIEW_DATE') = 10 THEN '' WHEN length(raw_data ->> 'LAST_REVIEW_DATE') = 16 THEN ' HH24:MI' ELSE ' HH24:MI:SS' END)
    ELSE (raw_data ->> 'LAST_REVIEW_DATE')::timestamp END
            FROM foundation_staging_rows WHERE staging_table_id = 25 ORDER BY row_number;
