-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE VIEW silver."raw_material_master_match_view" AS
            SELECT *, false AS identity_match
            FROM silver."conformed_raw_material_master";
