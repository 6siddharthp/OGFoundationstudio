-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_uom_reference AS
SELECT column1::VARCHAR source_unit, column2::VARCHAR governed_unit, column3::VARCHAR measure_type
FROM VALUES ('cSt','mm2/s','Kinematic viscosity'),
('centistokes','mm2/s','Kinematic viscosity'),
('mgKOH/g','mg KOH/g','Acid or base number'),
('mg KOH per g','mg KOH/g','Acid or base number'),
('ppm','mg/kg','Concentration'),
('degC','degC','Temperature'),
('C','degC','Temperature'),
('Celsius','degC','Temperature'),
('kPa','bar','Pressure'),
('kg/m3','kg/m3','Density');
