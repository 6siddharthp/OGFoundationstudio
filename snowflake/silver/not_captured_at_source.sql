-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.not_captured_at_source AS
SELECT column1::VARCHAR source_table,column2::VARCHAR site_code,column3::VARCHAR site_name,
       column4::VARCHAR canonical_field,column5::VARCHAR reason
FROM VALUES ('LAB_MUESTRAS_BA','buenos-aires','Buenos Aires','comments','Not captured at source'),
('LIMS_CURITIBA_AMOSTRAS','curitiba','Curitiba','project_reference','Not captured at source'),
('LIMS_CURITIBA_AMOSTRAS','curitiba','Curitiba','spec_lower_limit','Not captured at source'),
('LIMS_CURITIBA_AMOSTRAS','curitiba','Curitiba','spec_upper_limit','Not captured at source'),
('LIMS_CURITIBA_AMOSTRAS','curitiba','Curitiba','approval_date','Not captured at source'),
('LIMS_CURITIBA_AMOSTRAS','curitiba','Curitiba','storage_location','Not captured at source');
