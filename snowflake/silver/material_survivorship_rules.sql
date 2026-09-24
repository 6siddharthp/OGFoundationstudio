-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_survivorship_rules AS
SELECT column1::VARCHAR attribute,column2::VARCHAR strategy,column3::NUMBER rule_version
FROM VALUES ('canonical_material_name','most_complete',1),('business_line','most_recently_reviewed',1),('cas_number','most_recently_reviewed',1),('supplier','most_recently_reviewed',1),('unit_of_measure','most_recently_reviewed',1),('hazard_classification','most_recently_reviewed',1),('safety_data_sheet_ref','most_recently_reviewed',1);
