-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quantity_types AS
SELECT column1::VARCHAR quantity_type,column2::VARCHAR display_name,column3::VARCHAR standard_unit
FROM VALUES ('viscosity','Kinematic viscosity','CST'),
('temperature','Temperature','DEGC'),
('density','Density','KG_M3'),
('specific_gravity','Specific gravity / API gravity','SG'),
('mass','Mass','KG'),
('volume','Volume','L'),
('pressure','Pressure','BAR'),
('concentration','Concentration','MG_KG'),
('sulfur_trace','Sulphur or trace content','PPM');
