-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.GOLD.kpi_scope AS
SELECT column1::VARCHAR kpi_name,column2::BOOLEAN included,column3::VARCHAR skip_reason,
       PARSE_JSON(BASE64_DECODE_STRING(column4))::VARIANT site_policy,column5::VARCHAR policy_summary
FROM VALUES ('Cross-Lab Data Standardization Rate',TRUE,NULL,'W10=',''),
('Cross-Lab Reproducibility Index',TRUE,NULL,'W10=',''),
('Cross-Site Result Correlation',TRUE,NULL,'W10=',''),
('Duplicate Test Rate Across Labs',TRUE,NULL,'W10=',''),
('Inter-Site Result Deviation',TRUE,NULL,'W10=',''),
('Site-Pair Agreement by Method',TRUE,NULL,'W10=',''),
('Test Method Standardization Rate',TRUE,NULL,'W10=',''),
('Unmatched Sample Rate',TRUE,NULL,'W10=',''),
('Backlog Aging Index',TRUE,NULL,'W10=',''),
('First-Time-Right Rate',TRUE,NULL,'W3sic2l0ZUlkIjoiY3VyaXRpYmEiLCJzaXRlTmFtZSI6IkN1cml0aWJhIiwiZmllbGRzIjpbInNwZWNfbG93ZXJfbGltaXQiLCJzcGVjX3VwcGVyX2xpbWl0Il0sInJlYXNvbiI6IkV4Y2x1ZGVkIGJlY2F1c2Ugc3BlY19sb3dlcl9saW1pdCBhbmQgc3BlY191cHBlcl9saW1pdCBhcmUgbm90IGNhcHR1cmVkIGF0IHNvdXJjZS4ifV0=','Excludes Curitiba from this KPI calculation.'),
('Instrument Throughput',TRUE,NULL,'W10=',''),
('LIMS Data Completeness',TRUE,NULL,'W3sic2l0ZUlkIjoiY3VyaXRpYmEiLCJzaXRlTmFtZSI6IkN1cml0aWJhIiwiZmllbGRzIjpbInByb2plY3RfcmVmZXJlbmNlIiwic3BlY19sb3dlcl9saW1pdCIsInNwZWNfdXBwZXJfbGltaXQiLCJhcHByb3ZhbF9kYXRlIiwic3RvcmFnZV9sb2NhdGlvbiJdLCJyZWFzb24iOiJOb3QgY2FwdHVyZWQgYXQgc291cmNlOyBjb3VudGVkIGFzIDUgY29tcGxldGVuZXNzIGdhcHMuIn0seyJzaXRlSWQiOiJidWVub3NfYWlyZXMiLCJzaXRlTmFtZSI6IkJ1ZW5vcyBBaXJlcyIsImZpZWxkcyI6WyJjb21tZW50cyJdLCJyZWFzb24iOiJOb3QgY2FwdHVyZWQgYXQgc291cmNlOyBjb3VudGVkIGFzIDEgY29tcGxldGVuZXNzIGdhcC4ifV0=','Curitiba, Buenos Aires source gaps are included in the completeness denominator.'),
('Lab Capacity Utilization',TRUE,NULL,'W10=',''),
('Retest Rate',TRUE,NULL,'W10=',''),
('Sample Turnaround Time',TRUE,NULL,'W10=',''),
('Sample Volume Trend',TRUE,NULL,'W10=','');
