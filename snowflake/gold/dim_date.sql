-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_date AS SELECT TO_NUMBER(TO_CHAR(day,'YYYYMMDD')) date_key,day full_date,YEAR(day) year,QUARTER(day) quarter,MONTH(day) month,MONTHNAME(day) month_name,WEEKOFYEAR(day) week_of_year,DAYNAME(day) day_of_week FROM (SELECT DATEADD(day,SEQ4(),'2026-01-01'::DATE) day FROM TABLE(GENERATOR(ROWCOUNT=>365)));
