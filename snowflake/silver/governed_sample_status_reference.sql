-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_sample_status_reference AS
SELECT column1::VARCHAR source_value, column2::VARCHAR source_system, column3::VARCHAR governed_status
FROM VALUES ('Complete','Annandale','Completed'),
('Closed','Houston','Completed'),
('In Progress','Annandale','In Progress'),
('Open','Houston','In Progress'),
('Pending Review','Annandale','Pending Review'),
('Awaiting QA','Houston','Pending Review'),
('Concluido','Curitiba','Completed'),
('Em Andamento','Curitiba','In Progress'),
('Aguardando Revisao','Curitiba','Pending Review'),
('Completado','Buenos Aires','Completed'),
('En Progreso','Buenos Aires','In Progress'),
('Pendiente Revision','Buenos Aires','Pending Review');
