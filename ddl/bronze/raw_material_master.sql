-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."raw_material_master" (
              source_row_number integer PRIMARY KEY,
              "casnumber" text,
"supplier" text,
"density" numeric,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."raw_material_master" IS 'raw_material_master: 3 fields defined, 3 source columns, 3 auto-mapped, 0 manually mapped, 0 newly added.';
