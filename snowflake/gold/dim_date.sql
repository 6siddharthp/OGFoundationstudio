-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.dim_date AS SELECT s.date_key,s.full_date,s.year,s.quarter,s.month,s.month_name,s.week_of_year,s.day_of_week FROM (SELECT source_raw.date_key,source_raw.full_date,source_raw.year,source_raw.quarter,source_raw.month,source_raw.month_name,source_raw.week_of_year,source_raw.day_of_week FROM (WITH event_dates AS (
    SELECT TO_DATE(completion_date) event_date FROM OGFS_DEMO.SILVER.conformed_lab_sample
    UNION ALL
    SELECT TO_DATE(result_date) event_date FROM OGFS_DEMO.SILVER.conformed_test_result
  ), bounds AS (
    SELECT DATEADD(day,-31,COALESCE(MIN(event_date),CURRENT_DATE())) start_date,
           DATEADD(day,31,COALESCE(MAX(event_date),CURRENT_DATE())) end_date
    FROM event_dates WHERE event_date IS NOT NULL
  ), days AS (
    SELECT DATEADD(day,f.value::INTEGER,b.start_date) day
    FROM bounds b,LATERAL FLATTEN(INPUT=>ARRAY_GENERATE_RANGE(0,DATEDIFF(day,b.start_date,b.end_date)+1)) f
  )
  SELECT TO_NUMBER(TO_CHAR(day,'YYYYMMDD')) date_key,day full_date,YEAR(day) year,QUARTER(day) quarter,
         MONTH(day) month,MONTHNAME(day) month_name,WEEKOFYEAR(day) week_of_year,DAYNAME(day) day_of_week
  FROM days) source_raw) s;
