-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."raw_material_master_surrogate_key_view" AS
            SELECT "raw_material_master_key" AS surrogate_key, *
            FROM silver."conformed_raw_material_master";
