-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT column1::VARCHAR kpi_name,column2::BOOLEAN included,column3::VARCHAR skip_reason,
       column4::VARIANT site_policy,column5::VARCHAR policy_summary
FROM VALUES ('Cross-Lab Data Standardization Rate',TRUE,NULL,PARSE_JSON('[]'),''),
('Cross-Lab Reproducibility Index',TRUE,NULL,PARSE_JSON('[]'),''),
('Cross-Site Result Correlation',TRUE,NULL,PARSE_JSON('[]'),''),
('Duplicate Test Rate Across Labs',TRUE,NULL,PARSE_JSON('[]'),''),
('Inter-Site Result Deviation',TRUE,NULL,PARSE_JSON('[]'),''),
('Site-Pair Agreement by Method',TRUE,NULL,PARSE_JSON('[]'),''),
('Test Method Standardization Rate',TRUE,NULL,PARSE_JSON('[]'),''),
('Unmatched Sample Rate',TRUE,NULL,PARSE_JSON('[]'),''),
('Backlog Aging Index',TRUE,NULL,PARSE_JSON('[]'),''),
('First-Time-Right Rate',TRUE,NULL,PARSE_JSON('[{siteId:curitiba,siteName:Curitiba,fields:[spec_lower_limit,spec_upper_limit],reason:"Excluded because spec_lower_limit and spec_upper_limit are not captured at source."}]'),'Excludes Curitiba from this KPI calculation.'),
('Instrument Throughput',TRUE,NULL,PARSE_JSON('[]'),''),
('LIMS Data Completeness',TRUE,NULL,PARSE_JSON('[{siteId:"buenos-aires",siteName:"Buenos Aires",fields:[comments],reason:"Not captured at source; counted as 1 completeness gap."},{siteId:curitiba,siteName:Curitiba,fields:[project_reference,spec_lower_limit,spec_upper_limit,approval_date,storage_location],reason:"Not captured at source; counted as 5 completeness gaps."}]'),'Buenos Aires, Curitiba source gaps are included in the completeness denominator.'),
('Lab Capacity Utilization',TRUE,NULL,PARSE_JSON('[]'),''),
('Retest Rate',TRUE,NULL,PARSE_JSON('[]'),''),
('Sample Turnaround Time',TRUE,NULL,PARSE_JSON('[]'),''),
('Sample Volume Trend',TRUE,NULL,PARSE_JSON('[]'),'');
