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
