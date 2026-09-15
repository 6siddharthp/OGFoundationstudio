-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_business_line" (business_line_key text PRIMARY KEY, business_line_name text);

-- foundation:stage 8
INSERT INTO gold.dim_business_line VALUES ('BIZ_LUBRICANTS','Lubricants'),('BIZ_FUELS','Fuels'),('BIZ_CHEMICALS','Chemicals');
