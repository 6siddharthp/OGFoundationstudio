-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 7
CREATE TABLE gold."dim_date" (date_key integer PRIMARY KEY, full_date date, year integer, quarter integer, month integer, month_name text, week_of_year integer, day_of_week text);

-- foundation:stage 8
INSERT INTO gold.dim_date SELECT to_char(day,'YYYYMMDD')::integer, day::date, extract(year from day)::integer, extract(quarter from day)::integer, extract(month from day)::integer, to_char(day,'Month'), extract(week from day)::integer, to_char(day,'Day') FROM generate_series(date '2026-01-01',date '2026-12-31',interval '1 day') day;
