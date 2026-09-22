-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.unit_conversion_rules AS
SELECT column1::VARCHAR rule_id,column2::VARCHAR quantity_type,column3::VARCHAR from_unit,column4::VARCHAR to_unit,
       column5::VARCHAR conversion_kind,column6::NUMBER factor,column7::NUMBER offset,column8::VARCHAR expression,column9::VARCHAR inverse_rule_id
FROM VALUES ('sus_to_cst','viscosity','SUS','CST','formula',NULL,NULL,'if(x < 100, 0.226*x - 195/x, 0.220*x - 135/x)','cst_to_sus'),
('cst_to_sus','viscosity','CST','SUS','formula',NULL,NULL,'if(x < 20.6, (x + sqrt(x*x + 176.28))/0.452, (x + sqrt(x*x + 118.8))/0.44)','sus_to_cst'),
('f_to_c','temperature','DEGF','DEGC','linear_offset',0.5555555555555556,-17.77777777777778,NULL,'c_to_f'),
('c_to_f','temperature','DEGC','DEGF','linear_offset',1.8,32,NULL,'f_to_c'),
('k_to_c','temperature','K','DEGC','linear_offset',1,-273.15,NULL,'c_to_k'),
('c_to_k','temperature','DEGC','K','linear_offset',1,273.15,NULL,'k_to_c'),
('gcm3_to_kgm3','density','G_CM3','KG_M3','linear_factor',1000,NULL,NULL,'kgm3_to_gcm3'),
('kgm3_to_gcm3','density','KG_M3','G_CM3','linear_factor',0.001,NULL,NULL,'gcm3_to_kgm3'),
('api_to_sg','specific_gravity','API','SG','formula',NULL,NULL,'141.5/(x+131.5)','sg_to_api'),
('sg_to_api','specific_gravity','SG','API','formula',NULL,NULL,'141.5/x-131.5','api_to_sg'),
('g_to_kg','mass','G','KG','linear_factor',0.001,NULL,NULL,'kg_to_g'),
('kg_to_g','mass','KG','G','linear_factor',1000,NULL,NULL,'g_to_kg'),
('mg_to_kg','mass','MG','KG','linear_factor',0.000001,NULL,NULL,NULL),
('lb_to_kg','mass','LB','KG','linear_factor',0.45359237,NULL,NULL,NULL),
('ml_to_l','volume','ML','L','linear_factor',0.001,NULL,NULL,'l_to_ml'),
('l_to_ml','volume','L','ML','linear_factor',1000,NULL,NULL,'ml_to_l'),
('m3_to_l','volume','M3','L','linear_factor',1000,NULL,NULL,NULL),
('usgal_to_l','volume','US_GAL','L','linear_factor',3.785411784,NULL,NULL,NULL),
('kpa_to_bar','pressure','KPA','BAR','linear_factor',0.01,NULL,NULL,'bar_to_kpa'),
('bar_to_kpa','pressure','BAR','KPA','linear_factor',100,NULL,NULL,'kpa_to_bar'),
('psi_to_bar','pressure','PSI','BAR','linear_factor',0.0689475729,NULL,NULL,NULL),
('percent_to_mgkg','concentration','PERCENT','MG_KG','linear_factor',10000,NULL,NULL,NULL),
('sulfur_percent_to_ppm','sulfur_trace','SULFUR_PERCENT','PPM','linear_factor',10000,NULL,NULL,NULL);
