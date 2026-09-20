-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT value::VARCHAR AS kpi_name, TRUE AS included, NULL::VARCHAR AS skip_reason
FROM TABLE(FLATTEN(INPUT => PARSE_JSON('["Cross-Lab Data Standardization Rate","Cross-Lab Reproducibility Index","Cross-Site Result Correlation","Duplicate Test Rate Across Labs","Inter-Site Result Deviation","Site-Pair Agreement by Method","Test Method Standardization Rate","Unmatched Sample Rate","Backlog Aging Index","First-Time-Right Rate","Instrument Throughput","LIMS Data Completeness","Lab Capacity Utilization","Retest Rate","Sample Turnaround Time","Sample Volume Trend"]')))
UNION ALL
SELECT value::VARCHAR, FALSE, 'Inputs are outside the chosen process tables'
FROM TABLE(FLATTEN(INPUT => PARSE_JSON('["Business Line Activity Growth","Cycle Time by Gate"]')));
