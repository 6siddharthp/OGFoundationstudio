-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."material_surrogate_key_view" AS
            SELECT "material_key" AS surrogate_key, *
            FROM silver."conformed_material";
