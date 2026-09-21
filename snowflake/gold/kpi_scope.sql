-- Foundation Studio · Snowflake execution SQL
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT column1::VARCHAR kpi_name,column2::BOOLEAN included,column3::VARCHAR skip_reason,
       PARSE_JSON(column4)::VARIANT site_policy,column5::VARCHAR policy_summary
FROM VALUES ('Cross-Lab Data Standardization Rate',TRUE,NULL,'[]',''),
('Cross-Lab Reproducibility Index',TRUE,NULL,'[]',''),
('Cross-Site Result Correlation',TRUE,NULL,'[]',''),
('Duplicate Test Rate Across Labs',TRUE,NULL,'[]',''),
('Inter-Site Result Deviation',TRUE,NULL,'[]',''),
('Site-Pair Agreement by Method',TRUE,NULL,'[]',''),
('Test Method Standardization Rate',TRUE,NULL,'[]',''),
('Unmatched Sample Rate',TRUE,NULL,'[]',''),
('Backlog Aging Index',TRUE,NULL,'[]',''),
('First-Time-Right Rate',TRUE,NULL,'[{siteId:curitiba,siteName:Curitiba,fields:[spec_lower_limit,spec_upper_limit],reason:"Excluded because spec_lower_limit and spec_upper_limit are not captured at source."}]','Excludes Curitiba from this KPI calculation.'),
('Instrument Throughput',TRUE,NULL,'[]',''),
('LIMS Data Completeness',TRUE,NULL,'[{siteId:"buenos-aires",siteName:"Buenos Aires",fields:[comments],reason:"Not captured at source; counted as 1 completeness gap."},{siteId:curitiba,siteName:Curitiba,fields:[project_reference,spec_lower_limit,spec_upper_limit,approval_date,storage_location],reason:"Not captured at source; counted as 5 completeness gaps."}]','Buenos Aires, Curitiba source gaps are included in the completeness denominator.'),
('Lab Capacity Utilization',TRUE,NULL,'[]',''),
('Retest Rate',TRUE,NULL,'[]',''),
('Sample Turnaround Time',TRUE,NULL,'[]',''),
('Sample Volume Trend',TRUE,NULL,'[]','');
