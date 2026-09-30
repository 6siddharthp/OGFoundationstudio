-- Foundation Studio · generated orchestration
-- Single schedule mode has no independent downstream dispatcher.

CREATE OR REPLACE PROCEDURE OGFS_DEMO.SILVER.run_silver_pipeline()
RETURNS VARCHAR LANGUAGE SQL EXECUTE AS OWNER AS $$
BEGIN
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quarantine_records (
  quarantine_id NUMBER AUTOINCREMENT, source_table VARCHAR, source_row_number NUMBER,
  rule_name VARCHAR, reason VARCHAR, site_code VARCHAR, review_status VARCHAR,
  source_data VARIANT, quarantined_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.not_captured_at_source AS
SELECT column1::VARCHAR source_table,column2::VARCHAR site_code,column3::VARCHAR site_name,
       column4::VARCHAR canonical_field,column5::VARCHAR reason
FROM VALUES (''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''project_reference'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''spec_lower_limit'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''spec_upper_limit'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''approval_date'',''Not captured at source''),
(''LIMS_CURITIBA_AMOSTRAS'',''curitiba'',''Curitiba'',''storage_location'',''Not captured at source''),
(''LAB_MUESTRAS_BA'',''buenos_aires'',''Buenos Aires'',''comments'',''Not captured at source'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.rule_skips (
  source_table VARCHAR,site_code VARCHAR,canonical_field VARCHAR,rule_type VARCHAR,
  unavailable_inputs ARRAY,reason VARCHAR,recorded_at TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS
SELECT column1::VARCHAR source_method_name, column2::VARCHAR governed_standard_reference, column3::VARCHAR standard_body, column4::VARCHAR method_title, column5::VARCHAR applies_to_business_line, column6::VARCHAR quantity_type
FROM VALUES (''Viscosity'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants'',''viscosity''),
(''Kinematic Viscosity'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants'',''viscosity''),
(''Kinematic Viscosity @ 100C'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants'',''viscosity''),
(''KV100'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants'',''viscosity''),
(''Visc @ 40C'',''ASTM D445'',''ASTM'',''Kinematic Viscosity of Transparent and Opaque Liquids'',''Lubricants'',''viscosity''),
(''Flash Point'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels'',''temperature''),
(''Flash Pt'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels'',''temperature''),
(''Flash Point PMCC'',''ASTM D93'',''ASTM'',''Flash Point by Pensky-Martens Closed Cup'',''Fuels'',''temperature''),
(''Flash Point COC'',''ASTM D92'',''ASTM'',''Flash Point by Cleveland Open Cup'',''Lubricants'',''temperature''),
(''Flash Point Open Cup'',''ASTM D92'',''ASTM'',''Flash Point by Cleveland Open Cup'',''Lubricants'',''temperature''),
(''Pour Point'',''ASTM D97'',''ASTM'',''Pour Point of Petroleum Products'',''Lubricants'',''temperature''),
(''Acid Number'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants'',''concentration''),
(''Total Acid Number'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants'',''concentration''),
(''TAN'',''ASTM D664'',''ASTM'',''Acid Number by Potentiometric Titration'',''Lubricants'',''concentration''),
(''Base Number'',''ASTM D4739'',''ASTM'',''Base Number by Potentiometric Hydrochloric Acid Titration'',''Lubricants'',''concentration''),
(''TBN'',''ASTM D4739'',''ASTM'',''Base Number by Potentiometric Hydrochloric Acid Titration'',''Lubricants'',''concentration''),
(''Sulfur'',''ASTM D2622'',''ASTM'',''Sulfur by Wavelength Dispersive XRF'',''Fuels'',''sulfur_trace''),
(''Sulphur Content'',''ASTM D2622'',''ASTM'',''Sulfur by Wavelength Dispersive XRF'',''Fuels'',''sulfur_trace''),
(''Sulfur XRF'',''ASTM D4294'',''ASTM'',''Sulfur by Energy Dispersive XRF'',''Fuels'',''sulfur_trace''),
(''Sulfur EDXRF'',''ASTM D4294'',''ASTM'',''Sulfur by Energy Dispersive XRF'',''Fuels'',''sulfur_trace''),
(''Density'',''ASTM D4052'',''ASTM'',''Density, Relative Density, and API Gravity by Digital Density Meter'',''Fuels'',''density''),
(''API Gravity'',''ASTM D4052'',''ASTM'',''Density, Relative Density, and API Gravity by Digital Density Meter'',''Fuels'',''specific_gravity''),
(''Water Content'',''ASTM D6304'',''ASTM'',''Water by Coulometric Karl Fischer Titration'',''Cross-business'',''concentration''),
(''Karl Fischer Water'',''ASTM D6304'',''ASTM'',''Water by Coulometric Karl Fischer Titration'',''Cross-business'',''concentration''),
(''Ash'',''ASTM D482'',''ASTM'',''Ash from Petroleum Products'',''Cross-business'',''concentration''),
(''Viscosity Index'',''ASTM D2270'',''ASTM'',''Calculating Viscosity Index from Kinematic Viscosity'',''Lubricants'',''viscosity''),
(''VI'',''ASTM D2270'',''ASTM'',''Calculating Viscosity Index from Kinematic Viscosity'',''Lubricants'',''viscosity''),
(''Cold Crank'',''ASTM D5293'',''ASTM'',''Apparent Viscosity by Cold-Cranking Simulator'',''Lubricants'',''viscosity''),
(''CCS'',''ASTM D5293'',''ASTM'',''Apparent Viscosity by Cold-Cranking Simulator'',''Lubricants'',''viscosity''),
(''Wear Metals'',''ASTM D5185'',''ASTM'',''Multielement Determination by ICP-AES'',''Lubricants'',''sulfur_trace''),
(''ICP Metals'',''ASTM D5185'',''ASTM'',''Multielement Determination by ICP-AES'',''Lubricants'',''sulfur_trace''),
(''Cloud Point'',''ASTM D2500'',''ASTM'',''Cloud Point of Petroleum Products'',''Fuels'',''temperature''),
(''Color'',''ASTM D1500'',''ASTM'',''ASTM Color of Petroleum Products'',''Cross-business'',NULL),
(''Oxidation Stability'',''ASTM D2274'',''ASTM'',''Oxidation Stability of Distillate Fuel Oil'',''Fuels'',NULL),
(''Aniline Point'',''ASTM D611'',''ASTM'',''Aniline Point and Mixed Aniline Point'',''Fuels'',''temperature''),
(''Bromine Number'',''ASTM D1159'',''ASTM'',''Bromine Numbers by Electrometric Titration'',''Chemicals'',NULL),
(''Boiling Range Distribution'',''ASTM D2887'',''ASTM'',''Boiling Range Distribution by Gas Chromatography'',''Fuels'',NULL),
(''SimDis'',''ASTM D2887'',''ASTM'',''Boiling Range Distribution by Gas Chromatography'',''Fuels'',NULL),
(''Cetane Index'',''ASTM D976'',''ASTM'',''Calculated Cetane Index of Distillate Fuels'',''Fuels'',NULL),
(''Sequence VIII'',''ASTM D6709'',''ASTM'',''Sequence VIII Engine Test'',''Lubricants'',NULL),
(''Sequence IVA'',''ASTM D6891'',''ASTM'',''Sequence IVA Engine Test'',''Lubricants'',NULL),
(''Sequence IIIF'',''ASTM D6984'',''ASTM'',''Sequence IIIF Engine Test'',''Lubricants'',NULL),
(''Deposit Sequence'',''ASTM D6593'',''ASTM'',''Sequence VG Engine Test for Deposit Formation'',''Lubricants'',NULL),
(''ROBO Oxidation'',''ASTM D7528'',''ASTM'',''ROBO Apparatus Oxidation Test'',''Lubricants'',NULL),
(''PDSC Oxidation'',''ASTM D6186'',''ASTM'',''Oxidation Induction Time by PDSC'',''Lubricants'',NULL),
(''Injector Fouling'',''ASTM D6421'',''ASTM'',''Electronic Port Fuel Injector Fouling'',''Fuels'',NULL),
(''Water Reaction Aviation Fuel'',''ASTM D1094'',''ASTM'',''Water Reaction of Aviation Fuels'',''Fuels'',NULL),
(''ILSAC GF-6'',''ILSAC GF-6'',''ILSAC'',''Passenger Car Engine Oil Performance Specification'',''Lubricants'',NULL),
(''API SP'',''API SP'',''API'',''API Service Category SP'',''Lubricants'',NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.lab_languages AS
SELECT column1::VARCHAR site_code, column2::VARCHAR source_language
FROM VALUES (''annandale'',''English''),
(''houston'',''English''),
(''curitiba'',''Portuguese''),
(''buenos_aires'',''Spanish'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.governed_sample_status_reference AS
SELECT column1::VARCHAR source_value, column2::VARCHAR source_system, column3::VARCHAR governed_status
FROM VALUES (''Complete'',''Annandale'',''Completed''),
(''Closed'',''Houston'',''Completed''),
(''In Progress'',''Annandale'',''In Progress''),
(''Open'',''Houston'',''In Progress''),
(''Pending Review'',''Annandale'',''Pending Review''),
(''Awaiting QA'',''Houston'',''Pending Review''),
(''Concluido'',''Curitiba'',''Completed''),
(''Em Andamento'',''Curitiba'',''In Progress''),
(''Aguardando Revisao'',''Curitiba'',''Pending Review''),
(''Completado'',''Buenos Aires'',''Completed''),
(''En Progreso'',''Buenos Aires'',''In Progress''),
(''Pendiente Revision'',''Buenos Aires'',''Pending Review'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.business_line_mapping AS
SELECT column1::VARCHAR business_line_key,column2::VARCHAR business_line_name,
  NULLIF(column3::VARCHAR,'''') source_product_line
FROM VALUES (''BIZ_LUBRICANTS'',''Lubricants'',''Lubricants''),
(''BIZ_FUELS'',''Fuels'',''Fuels''),
(''BIZ_CHEMICALS'',''Chemicals'',''Chemicals''),
(''BIZ_UNASSIGNED'',''Unassigned'','''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.unit_registry AS
SELECT column1::VARCHAR canonical_code,column2::VARCHAR display_name,column3::VARCHAR quantity_type,column4::VARCHAR accepted_alias
FROM VALUES (''CST'',''Centistokes'',''viscosity'',''CST''),
(''CST'',''Centistokes'',''viscosity'',''centistokes''),
(''CST'',''Centistokes'',''viscosity'',''mm2/s''),
(''CST'',''Centistokes'',''viscosity'',''mm²/s''),
(''SUS'',''Saybolt Universal Seconds'',''viscosity'',''SUS''),
(''SUS'',''Saybolt Universal Seconds'',''viscosity'',''SSU''),
(''SUS'',''Saybolt Universal Seconds'',''viscosity'',''Saybolt Universal Seconds''),
(''DEGC'',''Degrees Celsius'',''temperature'',''DEGC''),
(''DEGC'',''Degrees Celsius'',''temperature'',''C''),
(''DEGC'',''Degrees Celsius'',''temperature'',''Celsius''),
(''DEGC'',''Degrees Celsius'',''temperature'',''deg C''),
(''DEGC'',''Degrees Celsius'',''temperature'',''°C''),
(''DEGF'',''Degrees Fahrenheit'',''temperature'',''DEGF''),
(''DEGF'',''Degrees Fahrenheit'',''temperature'',''F''),
(''DEGF'',''Degrees Fahrenheit'',''temperature'',''Fahrenheit''),
(''DEGF'',''Degrees Fahrenheit'',''temperature'',''deg F''),
(''DEGF'',''Degrees Fahrenheit'',''temperature'',''°F''),
(''K'',''Kelvin'',''temperature'',''K''),
(''K'',''Kelvin'',''temperature'',''Kelvin''),
(''KG_M3'',''Kilograms per cubic metre'',''density'',''KG_M3''),
(''KG_M3'',''Kilograms per cubic metre'',''density'',''kg/m3''),
(''KG_M3'',''Kilograms per cubic metre'',''density'',''kg/m³''),
(''KG_M3'',''Kilograms per cubic metre'',''density'',''kg m-3''),
(''G_CM3'',''Grams per cubic centimetre'',''density'',''G_CM3''),
(''G_CM3'',''Grams per cubic centimetre'',''density'',''g/cm3''),
(''G_CM3'',''Grams per cubic centimetre'',''density'',''g/cm³''),
(''SG'',''Specific gravity'',''specific_gravity'',''SG''),
(''SG'',''Specific gravity'',''specific_gravity'',''specific gravity''),
(''SG'',''Specific gravity'',''specific_gravity'',''relative density''),
(''API'',''API gravity'',''specific_gravity'',''API''),
(''API'',''API gravity'',''specific_gravity'',''API gravity''),
(''API'',''API gravity'',''specific_gravity'',''deg API''),
(''API'',''API gravity'',''specific_gravity'',''°API''),
(''KG'',''Kilogram'',''mass'',''KG''),
(''KG'',''Kilogram'',''mass'',''kilogram''),
(''KG'',''Kilogram'',''mass'',''kilograms''),
(''G'',''Gram'',''mass'',''G''),
(''G'',''Gram'',''mass'',''gram''),
(''G'',''Gram'',''mass'',''grams''),
(''MG'',''Milligram'',''mass'',''MG''),
(''MG'',''Milligram'',''mass'',''milligram''),
(''MG'',''Milligram'',''mass'',''milligrams''),
(''LB'',''Pound'',''mass'',''LB''),
(''LB'',''Pound'',''mass'',''lbs''),
(''LB'',''Pound'',''mass'',''pound''),
(''LB'',''Pound'',''mass'',''pounds''),
(''L'',''Litre'',''volume'',''L''),
(''L'',''Litre'',''volume'',''litre''),
(''L'',''Litre'',''volume'',''liter''),
(''L'',''Litre'',''volume'',''litres''),
(''L'',''Litre'',''volume'',''liters''),
(''ML'',''Millilitre'',''volume'',''ML''),
(''ML'',''Millilitre'',''volume'',''millilitre''),
(''ML'',''Millilitre'',''volume'',''milliliter''),
(''M3'',''Cubic metre'',''volume'',''M3''),
(''M3'',''Cubic metre'',''volume'',''m³''),
(''M3'',''Cubic metre'',''volume'',''cubic metre''),
(''M3'',''Cubic metre'',''volume'',''cubic meter''),
(''US_GAL'',''US gallon'',''volume'',''US_GAL''),
(''US_GAL'',''US gallon'',''volume'',''US gal''),
(''US_GAL'',''US gallon'',''volume'',''gal US''),
(''US_GAL'',''US gallon'',''volume'',''US gallon''),
(''BAR'',''Bar'',''pressure'',''BAR''),
(''BAR'',''Bar'',''pressure'',''bars''),
(''KPA'',''Kilopascal'',''pressure'',''KPA''),
(''KPA'',''Kilopascal'',''pressure'',''kilopascal''),
(''KPA'',''Kilopascal'',''pressure'',''kilopascals''),
(''PSI'',''Pounds per square inch'',''pressure'',''PSI''),
(''PSI'',''Pounds per square inch'',''pressure'',''lb/in2''),
(''MG_KG'',''Milligrams per kilogram'',''concentration'',''MG_KG''),
(''MG_KG'',''Milligrams per kilogram'',''concentration'',''mg/kg''),
(''MG_KG'',''Milligrams per kilogram'',''concentration'',''ppm''),
(''PERCENT'',''Percent by mass'',''concentration'',''PERCENT''),
(''PERCENT'',''Percent by mass'',''concentration'',''%''),
(''PERCENT'',''Percent by mass'',''concentration'',''wt%''),
(''PERCENT'',''Percent by mass'',''concentration'',''mass %''),
(''PPM'',''Parts per million'',''sulfur_trace'',''PPM''),
(''PPM'',''Parts per million'',''sulfur_trace'',''mg/kg''),
(''PPM'',''Parts per million'',''sulfur_trace'',''mg kg-1''),
(''SULFUR_PERCENT'',''Sulphur percent by mass'',''sulfur_trace'',''SULFUR_PERCENT''),
(''SULFUR_PERCENT'',''Sulphur percent by mass'',''sulfur_trace'',''% sulfur''),
(''SULFUR_PERCENT'',''Sulphur percent by mass'',''sulfur_trace'',''% sulphur''),
(''SULFUR_PERCENT'',''Sulphur percent by mass'',''sulfur_trace'',''wt% sulfur''),
(''SULFUR_PERCENT'',''Sulphur percent by mass'',''sulfur_trace'',''wt% sulphur'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.quantity_types AS
SELECT column1::VARCHAR quantity_type,column2::VARCHAR display_name,column3::VARCHAR standard_unit
FROM VALUES (''viscosity'',''Kinematic viscosity'',''CST''),
(''temperature'',''Temperature'',''DEGC''),
(''density'',''Density'',''KG_M3''),
(''specific_gravity'',''Specific gravity / API gravity'',''SG''),
(''mass'',''Mass'',''KG''),
(''volume'',''Volume'',''L''),
(''pressure'',''Pressure'',''BAR''),
(''concentration'',''Concentration'',''MG_KG''),
(''sulfur_trace'',''Sulphur or trace content'',''PPM'')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.unit_conversion_rules AS
SELECT column1::VARCHAR rule_id,column2::VARCHAR quantity_type,column3::VARCHAR from_unit,column4::VARCHAR to_unit,
       column5::VARCHAR conversion_kind,column6::NUMBER factor,column7::NUMBER offset,column8::VARCHAR expression,column9::VARCHAR inverse_rule_id
FROM VALUES (''sus_to_cst'',''viscosity'',''SUS'',''CST'',''formula'',NULL,NULL,''if(x < 100, 0.226*x - 195/x, 0.220*x - 135/x)'',''cst_to_sus''),
(''cst_to_sus'',''viscosity'',''CST'',''SUS'',''formula'',NULL,NULL,''if(x < 20.6, (x + sqrt(x*x + 176.28))/0.452, (x + sqrt(x*x + 118.8))/0.44)'',''sus_to_cst''),
(''f_to_c'',''temperature'',''DEGF'',''DEGC'',''linear_offset'',0.5555555555555556,-17.77777777777778,NULL,''c_to_f''),
(''c_to_f'',''temperature'',''DEGC'',''DEGF'',''linear_offset'',1.8,32,NULL,''f_to_c''),
(''k_to_c'',''temperature'',''K'',''DEGC'',''linear_offset'',1,-273.15,NULL,''c_to_k''),
(''c_to_k'',''temperature'',''DEGC'',''K'',''linear_offset'',1,273.15,NULL,''k_to_c''),
(''gcm3_to_kgm3'',''density'',''G_CM3'',''KG_M3'',''linear_factor'',1000,NULL,NULL,''kgm3_to_gcm3''),
(''kgm3_to_gcm3'',''density'',''KG_M3'',''G_CM3'',''linear_factor'',0.001,NULL,NULL,''gcm3_to_kgm3''),
(''api_to_sg'',''specific_gravity'',''API'',''SG'',''formula'',NULL,NULL,''141.5/(x+131.5)'',''sg_to_api''),
(''sg_to_api'',''specific_gravity'',''SG'',''API'',''formula'',NULL,NULL,''141.5/x-131.5'',''api_to_sg''),
(''g_to_kg'',''mass'',''G'',''KG'',''linear_factor'',0.001,NULL,NULL,''kg_to_g''),
(''kg_to_g'',''mass'',''KG'',''G'',''linear_factor'',1000,NULL,NULL,''g_to_kg''),
(''mg_to_kg'',''mass'',''MG'',''KG'',''linear_factor'',0.000001,NULL,NULL,NULL),
(''lb_to_kg'',''mass'',''LB'',''KG'',''linear_factor'',0.45359237,NULL,NULL,NULL),
(''ml_to_l'',''volume'',''ML'',''L'',''linear_factor'',0.001,NULL,NULL,''l_to_ml''),
(''l_to_ml'',''volume'',''L'',''ML'',''linear_factor'',1000,NULL,NULL,''ml_to_l''),
(''m3_to_l'',''volume'',''M3'',''L'',''linear_factor'',1000,NULL,NULL,NULL),
(''usgal_to_l'',''volume'',''US_GAL'',''L'',''linear_factor'',3.785411784,NULL,NULL,NULL),
(''kpa_to_bar'',''pressure'',''KPA'',''BAR'',''linear_factor'',0.01,NULL,NULL,''bar_to_kpa''),
(''bar_to_kpa'',''pressure'',''BAR'',''KPA'',''linear_factor'',100,NULL,NULL,''kpa_to_bar''),
(''psi_to_bar'',''pressure'',''PSI'',''BAR'',''linear_factor'',0.0689475729,NULL,NULL,NULL),
(''percent_to_mgkg'',''concentration'',''PERCENT'',''MG_KG'',''linear_factor'',10000,NULL,NULL,NULL),
(''sulfur_percent_to_ppm'',''sulfur_trace'',''SULFUR_PERCENT'',''PPM'',''linear_factor'',10000,NULL,NULL,NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_annandale AS
 SELECT row_data.source_row_number,
  LOWER(row_data.sample_id) AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.reviewer_id AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_annandale_samples'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
        ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
 WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
        ''uom_vocabulary'' rule_name, ''Unit cannot be resolved in unit_registry: ''||COALESCE(TO_VARCHAR(row_data.result_unit),''(missing)'')||'' (test method: ''||COALESCE(TO_VARCHAR(row_data.test_type),''(missing)'')||'')'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
 WHERE (SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table, row_data.source_row_number,
        ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''annandale'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_annandale_samples AS row_data
 WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_houston AS
 SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.reviewer_id AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_houston_samples'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
        ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
 WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
        ''uom_vocabulary'' rule_name, ''Unit cannot be resolved in unit_registry: ''||COALESCE(TO_VARCHAR(row_data.result_unit),''(missing)'')||'' (test method: ''||COALESCE(TO_VARCHAR(row_data.test_type),''(missing)'')||'')'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
 WHERE (SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_HOUSTON_SAMPLES'' source_table, row_data.source_row_number,
        ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''houston'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_houston_samples AS row_data
 WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_curitiba AS
 SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.reviewer_id AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  NULL AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  NULL AS spec_lower_limit,
  NULL AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  NULL AS approval_date,
  NULL AS storage_location,
  row_data.retest_flag AS retest_flag,
  row_data.comments AS comments,
  row_data.site_code AS site_code,
  ''lims_curitiba_amostras'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
        ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
 WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
        ''uom_vocabulary'' rule_name, ''Unit cannot be resolved in unit_registry: ''||COALESCE(TO_VARCHAR(row_data.result_unit),''(missing)'')||'' (test method: ''||COALESCE(TO_VARCHAR(row_data.test_type),''(missing)'')||'')'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
 WHERE (SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table, row_data.source_row_number,
        ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''curitiba'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras AS row_data
 WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_lims_buenos_aires AS
 SELECT row_data.source_row_number,
  row_data.sample_id AS sample_id,
  row_data.product_line AS product_line,
  row_data.material_code AS material_code,
  row_data.batch_lot_number AS batch_lot_number,
  row_data.container_id AS container_id,
  COALESCE((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))), NULL) AS test_type,
  row_data.test_method_version AS test_method_version,
  row_data.instrument_id AS instrument_id,
  row_data.analyst_id AS analyst_id,
  row_data.reviewer_id AS reviewer_id,
  row_data.date_requested AS date_requested,
  row_data.date_received AS date_received,
  row_data.date_started AS date_started,
  row_data.date_completed AS date_completed,
  row_data.priority AS priority,
  row_data.submitter AS submitter,
  row_data.project_reference AS project_reference,
  row_data.result_value AS result_value,
  COALESCE((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))), NULL) AS result_unit,
  row_data.spec_lower_limit AS spec_lower_limit,
  row_data.spec_upper_limit AS spec_upper_limit,
  COALESCE((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))), NULL) AS sample_status,
  row_data.approval_status AS approval_status,
  row_data.approval_date AS approval_date,
  row_data.storage_location AS storage_location,
  row_data.retest_flag AS retest_flag,
  NULL AS comments,
  row_data.site_code AS site_code,
  ''lab_muestras_ba'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data WHERE NOT (COALESCE(((SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL), FALSE) OR COALESCE(((SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL), FALSE))) AS row_data';
  EXECUTE IMMEDIATE '-- foundation:stage 3
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (
SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
        ''test_method_vocabulary'' rule_name, ''test_type: Code lookup failed'' reason,
       ''buenos_aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
 WHERE (SELECT MAX(ref.governed_standard_reference) FROM OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_method_name AS VARCHAR))) = LOWER(TRIM(CAST(row_data.test_type AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
        ''uom_vocabulary'' rule_name, ''Unit cannot be resolved in unit_registry: ''||COALESCE(TO_VARCHAR(row_data.result_unit),''(missing)'')||'' (test method: ''||COALESCE(TO_VARCHAR(row_data.test_type),''(missing)'')||'')'' reason,
       ''buenos_aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
 WHERE (SELECT MAX(ref.canonical_code) FROM OGFS_DEMO.SILVER.unit_registry AS ref JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference method_ref ON method_ref.quantity_type=ref.quantity_type WHERE REGEXP_REPLACE(UPPER(TRIM(method_ref.source_method_name)),''[^A-Z0-9]'','''')=REGEXP_REPLACE(UPPER(TRIM(row_data.test_type)),''[^A-Z0-9]'','''') AND LOWER(TRIM(CAST(ref.accepted_alias AS VARCHAR))) = LOWER(TRIM(CAST(row_data.result_unit AS VARCHAR)))) IS NULL
UNION ALL

SELECT ''LAB_MUESTRAS_BA'' source_table, row_data.source_row_number,
        ''status_vocabulary'' rule_name, ''sample_status: Code lookup failed'' reason,
       ''buenos_aires'' site_code,
       ''quarantined'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(row_data.*) source_data
FROM OGFS_DEMO.BRONZE.lab_muestras_ba AS row_data
 WHERE (SELECT MAX(ref.governed_status) FROM OGFS_DEMO.SILVER.governed_sample_status_reference AS ref WHERE LOWER(TRIM(CAST(ref.source_value AS VARCHAR))) = LOWER(TRIM(CAST(row_data.sample_status AS VARCHAR)))) IS NULL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_row_number,rule_name ORDER BY reason)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.silver_raw_material_master AS
 SELECT row_data.source_row_number,
  row_data.canonical_material_name AS canonical_material_name,
  row_data.business_line AS business_line,
  row_data.source_material_code AS source_material_code,
  row_data.legacy_material_id AS legacy_material_id,
  row_data.cas_number AS cas_number,
  row_data.supplier AS supplier,
  row_data.supplier_grade AS supplier_grade,
  row_data.unit_of_measure AS unit_of_measure,
  row_data.density AS density,
  row_data.viscosity_grade AS viscosity_grade,
  row_data.hazard_classification AS hazard_classification,
  row_data.safety_data_sheet_ref AS safety_data_sheet_ref,
  row_data.shelf_life_months AS shelf_life_months,
  row_data.storage_conditions AS storage_conditions,
  row_data.approved_for_use AS approved_for_use,
  row_data.last_review_date AS last_review_date,
  ''raw_material_master'' AS source_table
FROM (SELECT row_data.* FROM OGFS_DEMO.BRONZE.raw_material_master AS row_data WHERE NOT (FALSE)) AS row_data';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_similarity_rules AS
SELECT column1::NUMBER(8,2) name_similarity_threshold,column2::NUMBER(8,2) review_band_floor,column3::NUMBER rule_version
FROM VALUES (85,63.75,1)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_survivorship_rules AS
SELECT column1::VARCHAR attribute,column2::VARCHAR strategy,column3::NUMBER rule_version
FROM VALUES (''canonical_material_name'',''most_complete'',1),(''business_line'',''most_recently_reviewed'',1),(''cas_number'',''most_recently_reviewed'',1),(''supplier'',''most_recently_reviewed'',1),(''unit_of_measure'',''most_recently_reviewed'',1),(''hazard_classification'',''most_recently_reviewed'',1),(''safety_data_sheet_ref'',''most_recently_reviewed'',1)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.decided_material_pairs AS SELECT NULL::VARCHAR pair_key WHERE FALSE';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE TABLE IF NOT EXISTS OGFS_DEMO.SILVER.golden_record_overrides (
  action_id VARCHAR,item_key VARCHAR,action VARCHAR,golden_key VARCHAR,
  source_table VARCHAR,source_row_number NUMBER,source_material_code VARCHAR,golden_values VARIANT,
  actor VARCHAR,decided_at TIMESTAMP_TZ,rationale VARCHAR
)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_identity_map AS
WITH base AS (
  SELECT DISTINCT source_material_code, legacy_material_id master_role_value,
    legacy_material_id legacy_role_value,canonical_material_name,cas_number,
    NULLIF(UPPER(TRIM(TO_VARCHAR(viscosity_grade))),'''') grade_0,
    NULLIF(UPPER(TRIM(TO_VARCHAR(supplier_grade))),'''') grade_1,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), ''[^A-Z0-9]'', '''') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), ''[^A-Z0-9]'', ''''), '''') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master
  WHERE source_material_code IS NOT NULL AND canonical_material_name IS NOT NULL
),
canonical_targets AS (
  SELECT * FROM base WHERE master_role_value LIKE ''MAT-%''
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY master_role_value
    ORDER BY LENGTH(canonical_material_name) DESC,normalized_name,source_material_code
  )=1
),
ranked_targets AS (
  SELECT b.source_material_code,t.normalized_name target_name,
    JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) similarity_score,
    CASE WHEN b.legacy_role_value=t.master_role_value THEN ''raw_material_master_xref''
         WHEN b.normalized_cas=t.normalized_cas THEN ''cas_number''
         ELSE ''canonical_name_similarity'' END match_rule,
    ROW_NUMBER() OVER (PARTITION BY b.source_material_code ORDER BY
      IFF(b.legacy_role_value=t.master_role_value,1,0) DESC,
      IFF(b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas,1,0) DESC,
      JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) DESC,
      t.normalized_name) target_rank
  FROM base b CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules JOIN canonical_targets t ON
    b.legacy_role_value=t.master_role_value
    OR (b.legacy_role_value LIKE ''LGC-%'' AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas
      AND (b.grade_0 IS NULL OR t.grade_0 IS NULL OR b.grade_0=t.grade_0)
      AND (b.grade_1 IS NULL OR t.grade_1 IS NULL OR b.grade_1=t.grade_1))
    OR ((b.normalized_cas IS NULL OR t.normalized_cas IS NULL)
      AND JAROWINKLER_SIMILARITY(b.normalized_name,t.normalized_name) >= rules.name_similarity_threshold)
),
cas_grade_conflicts AS (
  SELECT DISTINCT b.source_material_code
  FROM base b JOIN canonical_targets t ON b.legacy_role_value LIKE ''LGC-%''
    AND b.normalized_cas IS NOT NULL AND b.normalized_cas=t.normalized_cas
  WHERE (b.grade_0 IS NOT NULL AND t.grade_0 IS NOT NULL AND b.grade_0<>t.grade_0)
    OR (b.grade_1 IS NOT NULL AND t.grade_1 IS NOT NULL AND b.grade_1<>t.grade_1)
),
current_overrides AS (
  SELECT *
  FROM OGFS_DEMO.SILVER.golden_record_overrides
  QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1
),
resolved AS (
  SELECT b.*,r.target_name,r.match_rule,o.action override_action,o.golden_key override_golden_key,
    c.source_material_code IS NOT NULL has_cas_grade_conflict
  FROM base b LEFT JOIN ranked_targets r ON r.source_material_code=b.source_material_code AND r.target_rank=1
  LEFT JOIN current_overrides o ON LOWER(o.source_material_code)=LOWER(b.source_material_code)
  LEFT JOIN cas_grade_conflicts c ON c.source_material_code=b.source_material_code
)
SELECT source_material_code,canonical_material_name,cas_number,
  COALESCE(
    IFF(override_action IN (''attach'',''create''),override_golden_key,NULL),
     IFF(override_action=''reject'',''MAT_''||MD5(normalized_name||'':''||source_material_code),NULL),
    ''MAT_''||MD5(IFF(target_name IS NULL AND has_cas_grade_conflict,
      normalized_name||'':''||source_material_code,COALESCE(target_name,normalized_name)))
  ) material_key,
  CASE WHEN override_action IN (''attach'',''create'') THEN ''golden_record_override''
        WHEN override_action=''reject'' THEN ''steward_separate''
       ELSE COALESCE(match_rule,''unmatched_source_record'') END match_rule,
  rules.name_similarity_threshold similarity_threshold
FROM resolved CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_candidates AS
WITH base AS (
  SELECT DISTINCT i.material_key,m.source_material_code,m.legacy_material_id master_role_value,
    m.legacy_material_id legacy_role_value,m.canonical_material_name,m.business_line,
    NULLIF(UPPER(TRIM(TO_VARCHAR(m.viscosity_grade))),'''') grade_0,
    NULLIF(UPPER(TRIM(TO_VARCHAR(m.supplier_grade))),'''') grade_1,
    REGEXP_REPLACE(UPPER(TRIM(canonical_material_name)), ''[^A-Z0-9]'', '''') normalized_name,
    NULLIF(REGEXP_REPLACE(UPPER(TRIM(cas_number)), ''[^A-Z0-9]'', ''''), '''') normalized_cas
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m JOIN OGFS_DEMO.SILVER.material_identity_map i USING (source_material_code)
  WHERE m.source_material_code IS NOT NULL AND m.canonical_material_name IS NOT NULL
),
pairs AS (
  SELECT l.material_key left_material_key,r.material_key right_material_key,l.business_line,
    l.source_material_code left_code,r.source_material_code right_code,
    l.canonical_material_name left_name,r.canonical_material_name right_name,
    JAROWINKLER_SIMILARITY(l.normalized_name,r.normalized_name) similarity_score,
    l.normalized_cas IS NOT NULL AND l.normalized_cas=r.normalized_cas same_cas,
    ((l.legacy_role_value LIKE ''LGC-%'' AND r.master_role_value LIKE ''MAT-%'')
      OR (r.legacy_role_value LIKE ''LGC-%'' AND l.master_role_value LIKE ''MAT-%'')) cas_attachment_pair,
    LOWER(TRIM(COALESCE(l.business_line,'''')))=LOWER(TRIM(COALESCE(r.business_line,''''))) same_business_line,
    (l.grade_0 IS NOT NULL AND r.grade_0 IS NOT NULL AND l.grade_0<>r.grade_0) grade_conflict_0,
    (l.grade_1 IS NOT NULL AND r.grade_1 IS NOT NULL AND l.grade_1<>r.grade_1) grade_conflict_1
  FROM base l JOIN base r ON l.source_material_code < r.source_material_code
    AND l.material_key <> r.material_key
    AND NOT (l.normalized_cas IS NOT NULL AND r.normalized_cas IS NOT NULL
      AND l.normalized_cas<>r.normalized_cas)
    AND NOT EXISTS (SELECT 1 FROM OGFS_DEMO.SILVER.decided_material_pairs d
      WHERE d.pair_key=l.source_material_code||''|''||r.source_material_code)
     AND NOT EXISTS (SELECT 1 FROM (SELECT source_material_code,action
       FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1) o
      WHERE LOWER(o.source_material_code) IN (LOWER(l.source_material_code),LOWER(r.source_material_code))
        AND o.action IN (''attach'',''reject'',''create''))
)
SELECT pairs.left_material_key,pairs.right_material_key,pairs.business_line,
  pairs.left_code,pairs.right_code,pairs.left_name,pairs.right_name,pairs.similarity_score,
  CASE WHEN same_cas THEN
    ''Same CAS number, different grade (''||
      RTRIM(IFF(grade_conflict_0,''viscosity grade, '','''')||IFF(grade_conflict_1,''supplier grade, '',''''),'', '')||'')''
    ELSE ''Similar names'' END review_reason,
  rules.name_similarity_threshold similarity_threshold,rules.review_band_floor,
  ''candidate_review'' review_status
FROM pairs CROSS JOIN OGFS_DEMO.SILVER.material_similarity_rules rules
 WHERE (same_cas AND cas_attachment_pair AND (grade_conflict_0 OR grade_conflict_1))
  OR (NOT same_cas AND same_business_line
    AND similarity_score < rules.name_similarity_threshold
    AND similarity_score >= rules.review_band_floor)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.material_match_groups AS
WITH direct_pairs AS (
  SELECT left_code source_code,right_code neighbor_code,MAX(similarity_score) similarity_score
  FROM OGFS_DEMO.SILVER.material_match_candidates GROUP BY left_code,right_code
  UNION ALL
  SELECT right_code,left_code,MAX(similarity_score)
  FROM OGFS_DEMO.SILVER.material_match_candidates GROUP BY right_code,left_code
), neighbor_stats AS (
  SELECT source_code,COUNT(*) neighbor_count,MAX(similarity_score) top_score
  FROM direct_pairs GROUP BY source_code
), anchor_options AS (
  SELECT source_code,source_code anchor_source_code,neighbor_count,top_score FROM neighbor_stats
  UNION ALL
  SELECT p.source_code,p.neighbor_code,s.neighbor_count,s.top_score
  FROM direct_pairs p JOIN neighbor_stats s ON s.source_code=p.neighbor_code
), chosen_anchors AS (
  SELECT source_code,anchor_source_code
  FROM anchor_options
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY source_code
    ORDER BY neighbor_count DESC,top_score DESC,anchor_source_code ASC
  )=1
), assigned AS (
  SELECT c.anchor_source_code,c.source_code,
    IFF(c.source_code=c.anchor_source_code,100,p.similarity_score) anchor_score
  FROM chosen_anchors c
  LEFT JOIN direct_pairs p ON p.source_code=c.source_code AND p.neighbor_code=c.anchor_source_code
), active_anchors AS (
  SELECT DISTINCT anchor_source_code FROM assigned WHERE source_code<>anchor_source_code
), members AS (
  SELECT a.anchor_source_code,a.source_code,a.anchor_score
  FROM assigned a JOIN active_anchors g ON g.anchor_source_code=a.anchor_source_code
  UNION ALL
  SELECT g.anchor_source_code,g.anchor_source_code,100
  FROM active_anchors g
  WHERE NOT EXISTS (
    SELECT 1 FROM assigned a
    WHERE a.anchor_source_code=g.anchor_source_code AND a.source_code=g.anchor_source_code
  )
), member_arrays AS (
  SELECT anchor_source_code,
    ARRAY_AGG(source_code) WITHIN GROUP (ORDER BY source_code) member_source_records,
    ARRAY_AGG(OBJECT_CONSTRUCT(''source_code'',source_code,''score'',anchor_score))
      WITHIN GROUP (ORDER BY source_code) member_anchor_scores
  FROM members GROUP BY anchor_source_code HAVING COUNT(*)>=2
), group_pairs AS (
  SELECT m.anchor_source_code,
    ARRAY_AGG(OBJECT_CONSTRUCT(''left'',p.left_code,''right'',p.right_code,''score'',p.similarity_score,
      ''reason'',p.review_reason))
      WITHIN GROUP (ORDER BY p.left_code,p.right_code) pairwise_scores,
    MIN(p.business_line) business_line,
    LISTAGG(DISTINCT p.review_reason,''; '') WITHIN GROUP (ORDER BY p.review_reason) review_reason
  FROM member_arrays m
  JOIN members l ON l.anchor_source_code=m.anchor_source_code
  JOIN OGFS_DEMO.SILVER.material_match_candidates p ON p.left_code=l.source_code
  JOIN members r ON r.anchor_source_code=m.anchor_source_code AND r.source_code=p.right_code
  GROUP BY m.anchor_source_code
)
SELECT ''GRP_''||MD5(m.anchor_source_code) group_id,m.member_source_records,
  p.pairwise_scores,p.business_line,m.anchor_source_code,m.member_anchor_scores,p.review_reason
FROM member_arrays m JOIN group_pairs p ON p.anchor_source_code=m.anchor_source_code';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.golden_attribute_lineage AS
WITH source_values AS (
  SELECT i.material_key,m.source_material_code,
    m.legacy_material_id master_role_value,
    TRY_TO_DATE(TO_VARCHAR(m.last_review_date)) last_review_date,
    f.key::VARCHAR attribute,NULLIF(TRIM(f.value::VARCHAR),'''') candidate_value
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m
  JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code,
  LATERAL FLATTEN(INPUT=>OBJECT_CONSTRUCT_KEEP_NULL(
    ''canonical_material_name'',m.canonical_material_name,''business_line'',m.business_line,
    ''cas_number'',m.cas_number,''supplier'',m.supplier,''unit_of_measure'',m.unit_of_measure,
    ''hazard_classification'',m.hazard_classification,''safety_data_sheet_ref'',m.safety_data_sheet_ref
  )) f
  WHERE NULLIF(TRIM(f.value::VARCHAR),'''') IS NOT NULL
), ranked AS (
  SELECT v.*,r.strategy,
    ROW_NUMBER() OVER (PARTITION BY v.material_key,v.attribute ORDER BY
      CASE WHEN r.strategy=''most_recently_reviewed'' THEN v.last_review_date END DESC NULLS LAST,
      CASE WHEN r.strategy=''most_complete'' THEN LENGTH(v.candidate_value) END DESC NULLS LAST,
      CASE WHEN r.strategy=''source_priority'' THEN IFF(v.master_role_value LIKE ''MAT-%'',0,1) END ASC NULLS LAST,
      v.source_material_code,v.candidate_value) winner_rank
  FROM source_values v JOIN OGFS_DEMO.SILVER.material_survivorship_rules r ON r.attribute=v.attribute
), winners AS (
  SELECT * FROM ranked WHERE winner_rank=1
), override_values AS (
  SELECT o.golden_key material_key,
    CASE f.key::VARCHAR
      WHEN ''canonicalMaterialName'' THEN ''canonical_material_name''
      WHEN ''businessLine'' THEN ''business_line''
      WHEN ''casNumber'' THEN ''cas_number''
      WHEN ''unitOfMeasure'' THEN ''unit_of_measure''
      WHEN ''hazardClassification'' THEN ''hazard_classification''
      WHEN ''safetyDataSheetRef'' THEN ''safety_data_sheet_ref''
      ELSE f.key::VARCHAR END attribute,
    NULLIF(TRIM(f.value::VARCHAR),'''') winning_value,o.source_material_code
  FROM OGFS_DEMO.SILVER.golden_record_overrides o,
    LATERAL FLATTEN(INPUT=>o.golden_values) f
  WHERE o.action IN (''attach'',''create'') AND NULLIF(TRIM(f.value::VARCHAR),'''') IS NOT NULL
  QUALIFY ROW_NUMBER() OVER (PARTITION BY o.golden_key,attribute ORDER BY o.decided_at DESC,o.action_id DESC)=1
), keys AS (
  SELECT DISTINCT i.material_key,r.attribute FROM OGFS_DEMO.SILVER.material_identity_map i
  CROSS JOIN OGFS_DEMO.SILVER.material_survivorship_rules r
)
SELECT k.material_key,k.attribute,
  COALESCE(o.winning_value,w.candidate_value) winning_value,
  IFF(o.winning_value IS NOT NULL,o.source_material_code,w.source_material_code) source_material_code,
  IFF(o.winning_value IS NOT NULL,''steward_override'',r.strategy) winning_rule,
  ARRAY_AGG(DISTINCT IFF(v.candidate_value<>COALESCE(o.winning_value,w.candidate_value),v.candidate_value,NULL)) other_distinct_values
FROM keys k
JOIN OGFS_DEMO.SILVER.material_survivorship_rules r ON r.attribute=k.attribute
LEFT JOIN winners w ON w.material_key=k.material_key AND w.attribute=k.attribute
LEFT JOIN override_values o ON o.material_key=k.material_key AND o.attribute=k.attribute
LEFT JOIN source_values v ON v.material_key=k.material_key AND v.attribute=k.attribute
GROUP BY k.material_key,k.attribute,o.winning_value,o.source_material_code,
  w.candidate_value,w.source_material_code,r.strategy';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_material AS
WITH base AS (
  SELECT i.material_key,
   MIN(m.source_material_code) source_material_code,
   COUNT(*) source_record_count, COUNT(DISTINCT m.canonical_material_name) source_name_count
  FROM OGFS_DEMO.SILVER.silver_raw_material_master m
  JOIN OGFS_DEMO.SILVER.material_identity_map i ON i.source_material_code=m.source_material_code
  GROUP BY i.material_key
)
SELECT b.material_key,
 MAX(IFF(l.attribute=''canonical_material_name'',l.winning_value,NULL)) canonical_material_name,
 MAX(IFF(l.attribute=''business_line'',l.winning_value,NULL)) business_line,
 MAX(IFF(l.attribute=''cas_number'',l.winning_value,NULL)) cas_number,
 MAX(IFF(l.attribute=''supplier'',l.winning_value,NULL)) supplier,
 MAX(IFF(l.attribute=''unit_of_measure'',l.winning_value,NULL)) unit_of_measure,
 MAX(IFF(l.attribute=''hazard_classification'',l.winning_value,NULL)) hazard_classification,
 MAX(IFF(l.attribute=''safety_data_sheet_ref'',l.winning_value,NULL)) safety_data_sheet_ref,
 b.source_material_code,b.source_record_count,b.source_name_count
 FROM base b LEFT JOIN OGFS_DEMO.SILVER.golden_attribute_lineage l ON l.material_key=b.material_key
 GROUP BY b.material_key,b.source_material_code,b.source_record_count,b.source_name_count
 UNION ALL
 SELECT o.golden_key material_key,
   o.golden_values:canonical_material_name::VARCHAR canonical_material_name,
   o.golden_values:business_line::VARCHAR business_line,
   o.golden_values:cas_number::VARCHAR cas_number,
   o.golden_values:supplier::VARCHAR supplier,
   o.golden_values:unit_of_measure::VARCHAR unit_of_measure,
   o.golden_values:hazard_classification::VARCHAR hazard_classification,
   o.golden_values:safety_data_sheet_ref::VARCHAR safety_data_sheet_ref,
   o.source_material_code,1 source_record_count,1 source_name_count
  FROM (SELECT * FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY decided_at DESC,action_id DESC)=1) o
  WHERE o.action=''create''
   AND NOT EXISTS (SELECT 1 FROM OGFS_DEMO.SILVER.silver_raw_material_master m
     WHERE LOWER(m.source_material_code)=LOWER(o.source_material_code))
 QUALIFY ROW_NUMBER() OVER (PARTITION BY o.golden_key ORDER BY o.decided_at DESC,o.action_id DESC)=1';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT ''LIMS_ANNANDALE_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''annandale'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_annandale_samples b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER(''LIMS_ANNANDALE_SAMPLES'')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN (''attach'',''create''))
UNION ALL
SELECT ''LIMS_HOUSTON_SAMPLES'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''houston'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_houston_samples b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER(''LIMS_HOUSTON_SAMPLES'')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN (''attach'',''create''))
UNION ALL
SELECT ''LIMS_CURITIBA_AMOSTRAS'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''curitiba'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lims_curitiba_amostras b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER(''LIMS_CURITIBA_AMOSTRAS'')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN (''attach'',''create''))
UNION ALL
SELECT ''LAB_MUESTRAS_BA'' source_table,
      b.source_row_number source_row_number, ''material_master_reference'' rule_name,
      ''Material code is missing from RAW_MATERIAL_MASTER and requires review'' reason,
      ''buenos_aires'' site_code,
      ''flagged_for_review'' review_status, OBJECT_CONSTRUCT_KEEP_NULL(b.*) source_data
    FROM OGFS_DEMO.BRONZE.lab_muestras_ba b
     LEFT JOIN OGFS_DEMO.SILVER.silver_raw_material_master m
      ON LOWER(TRIM(m.source_material_code)) = LOWER(TRIM(b.material_code))
      LEFT JOIN (SELECT source_table,source_material_code,action FROM OGFS_DEMO.SILVER.golden_record_overrides
       QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
         ORDER BY decided_at DESC,action_id DESC)=1) o
       ON LOWER(o.source_material_code)=LOWER(b.material_code)
         AND LOWER(o.source_table)=LOWER(''LAB_MUESTRAS_BA'')
     WHERE b.material_code IS NOT NULL AND m.source_material_code IS NULL
        AND (o.source_material_code IS NULL OR o.action NOT IN (''attach'',''create'')))';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_method AS
WITH methods AS (SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_annandale
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_houston
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_curitiba
UNION ALL
SELECT test_type test_type FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires)
SELECT ''MTH_'' || MD5(COALESCE(r.governed_standard_reference, m.test_type)) test_method_key,
 COALESCE(r.governed_standard_reference, m.test_type) governed_standard_reference,
 MIN(r.standard_body) standard_body, MIN(r.method_title) method_title,
 MIN(r.applies_to_business_line) applies_to_business_line, COUNT(*) source_record_count
FROM methods m LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference r
 ON REGEXP_REPLACE(UPPER(TRIM(m.test_type)), ''[^A-Z0-9]'', '''') =
    REGEXP_REPLACE(UPPER(TRIM(r.source_method_name)), ''[^A-Z0-9]'', '''')
GROUP BY COALESCE(r.governed_standard_reference, m.test_type)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_lab_sample AS SELECT ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''annandale'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_annandale s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_annandale_samples'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''houston'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_houston s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_houston_samples'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''curitiba'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_curitiba_amostras'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')
UNION ALL
SELECT ''SMP_'' || MD5(''buenos_aires:'' || s.source_row_number) lab_sample_key,
  m.material_key, tm.test_method_key, ''buenos_aires'' site_code, s.product_line business_line,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) completion_date,
 TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_requested)) requested_date,
 s.sample_status sample_status, 1 source_system_count
 FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lab_muestras_ba'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
 LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
   ON REGEXP_REPLACE(UPPER(TRIM(tm.governed_standard_reference)), ''[^A-Z0-9]'', '''') =
       REGEXP_REPLACE(UPPER(TRIM(s.test_type)), ''[^A-Z0-9]'', '''')';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.conformed_test_result AS SELECT ''RES_'' || MD5(''silver_lims_annandale:'' || s.source_row_number) test_result_key,
  ''SMP_'' || MD5(''annandale:'' || s.source_row_number) lab_sample_key,
  tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
  s.result_value original_result_value, s.result_unit original_result_unit,
  IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) result_value, qt.standard_unit result_unit,
  IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) spec_lower_limit, IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) spec_upper_limit,
  CASE WHEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) IS NULL OR IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) IS NULL THEN NULL
    ELSE IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) BETWEEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) AND IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) END within_spec,
  mr.quantity_type quantity_type, u.canonical_code recorded_unit_code,
  u.canonical_code<>qt.standard_unit conversion_applied,
  IFF(u.canonical_code=qt.standard_unit,''identity'',cr.rule_id) conversion_rule_id,
  ''silver_lims_annandale'' source_system
  FROM OGFS_DEMO.SILVER.silver_lims_annandale s
   LEFT JOIN OGFS_DEMO.BRONZE.lims_annandale_samples b ON b.source_row_number=s.source_row_number
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_annandale_samples'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
  LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
    ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
  LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
    ON tm.governed_standard_reference=COALESCE(mr.governed_standard_reference,s.test_type)
  LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
    ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
  LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
  LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
    ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
  WHERE s.result_value IS NOT NULL AND u.canonical_code IS NOT NULL AND qt.standard_unit IS NOT NULL
    AND (u.canonical_code=qt.standard_unit OR cr.rule_id IS NOT NULL)
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_houston:'' || s.source_row_number) test_result_key,
  ''SMP_'' || MD5(''houston:'' || s.source_row_number) lab_sample_key,
  tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
  s.result_value original_result_value, s.result_unit original_result_unit,
  IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) result_value, qt.standard_unit result_unit,
  IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) spec_lower_limit, IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) spec_upper_limit,
  CASE WHEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) IS NULL OR IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) IS NULL THEN NULL
    ELSE IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) BETWEEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) AND IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) END within_spec,
  mr.quantity_type quantity_type, u.canonical_code recorded_unit_code,
  u.canonical_code<>qt.standard_unit conversion_applied,
  IFF(u.canonical_code=qt.standard_unit,''identity'',cr.rule_id) conversion_rule_id,
  ''silver_lims_houston'' source_system
  FROM OGFS_DEMO.SILVER.silver_lims_houston s
   LEFT JOIN OGFS_DEMO.BRONZE.lims_houston_samples b ON b.source_row_number=s.source_row_number
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_houston_samples'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
  LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
    ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
  LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
    ON tm.governed_standard_reference=COALESCE(mr.governed_standard_reference,s.test_type)
  LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
    ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
  LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
  LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
    ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
  WHERE s.result_value IS NOT NULL AND u.canonical_code IS NOT NULL AND qt.standard_unit IS NOT NULL
    AND (u.canonical_code=qt.standard_unit OR cr.rule_id IS NOT NULL)
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_curitiba:'' || s.source_row_number) test_result_key,
  ''SMP_'' || MD5(''curitiba:'' || s.source_row_number) lab_sample_key,
  tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
  s.result_value original_result_value, s.result_unit original_result_unit,
  IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) result_value, qt.standard_unit result_unit,
  IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) spec_lower_limit, IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) spec_upper_limit,
  CASE WHEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) IS NULL OR IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) IS NULL THEN NULL
    ELSE IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) BETWEEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) AND IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) END within_spec,
  mr.quantity_type quantity_type, u.canonical_code recorded_unit_code,
  u.canonical_code<>qt.standard_unit conversion_applied,
  IFF(u.canonical_code=qt.standard_unit,''identity'',cr.rule_id) conversion_rule_id,
  ''silver_lims_curitiba'' source_system
  FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
   LEFT JOIN OGFS_DEMO.BRONZE.lims_curitiba_amostras b ON b.source_row_number=s.source_row_number
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lims_curitiba_amostras'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
  LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
    ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
  LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
    ON tm.governed_standard_reference=COALESCE(mr.governed_standard_reference,s.test_type)
  LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
    ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
  LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
  LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
    ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
  WHERE s.result_value IS NOT NULL AND u.canonical_code IS NOT NULL AND qt.standard_unit IS NOT NULL
    AND (u.canonical_code=qt.standard_unit OR cr.rule_id IS NOT NULL)
UNION ALL
SELECT ''RES_'' || MD5(''silver_lims_buenos_aires:'' || s.source_row_number) test_result_key,
  ''SMP_'' || MD5(''buenos_aires:'' || s.source_row_number) lab_sample_key,
  tm.test_method_key, m.material_key, TRY_TO_TIMESTAMP_NTZ(TO_VARCHAR(s.date_completed)) result_date,
  s.result_value original_result_value, s.result_unit original_result_unit,
  IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) result_value, qt.standard_unit result_unit,
  IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) spec_lower_limit, IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) spec_upper_limit,
  CASE WHEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) IS NULL OR IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) IS NULL THEN NULL
    ELSE IFF(u.canonical_code=qt.standard_unit,s.result_value,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.result_value) < 100, 0.226*(s.result_value) - 195/(s.result_value), 0.220*(s.result_value) - 135/(s.result_value)) WHEN ''cst_to_sus'' THEN IFF((s.result_value) < 20.6, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 176.28))/0.452, ((s.result_value) + SQRT((s.result_value)*(s.result_value) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.result_value) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.result_value) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.result_value) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.result_value) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.result_value) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.result_value) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.result_value)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.result_value)-131.5 WHEN ''g_to_kg'' THEN ((s.result_value) * 0.001) WHEN ''kg_to_g'' THEN ((s.result_value) * 1000) WHEN ''mg_to_kg'' THEN ((s.result_value) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.result_value) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.result_value) * 0.001) WHEN ''l_to_ml'' THEN ((s.result_value) * 1000) WHEN ''m3_to_l'' THEN ((s.result_value) * 1000) WHEN ''usgal_to_l'' THEN ((s.result_value) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.result_value) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.result_value) * 100) WHEN ''psi_to_bar'' THEN ((s.result_value) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.result_value) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.result_value) * 10000) END) BETWEEN IFF(s.spec_lower_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_lower_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_lower_limit) < 100, 0.226*(s.spec_lower_limit) - 195/(s.spec_lower_limit), 0.220*(s.spec_lower_limit) - 135/(s.spec_lower_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_lower_limit) < 20.6, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 176.28))/0.452, ((s.spec_lower_limit) + SQRT((s.spec_lower_limit)*(s.spec_lower_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_lower_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_lower_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_lower_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_lower_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_lower_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_lower_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_lower_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_lower_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_lower_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_lower_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_lower_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_lower_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_lower_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_lower_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_lower_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_lower_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_lower_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_lower_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_lower_limit) * 10000) END)) AND IFF(s.spec_upper_limit IS NULL,NULL,IFF(u.canonical_code=qt.standard_unit,s.spec_upper_limit,CASE cr.rule_id WHEN ''sus_to_cst'' THEN IFF((s.spec_upper_limit) < 100, 0.226*(s.spec_upper_limit) - 195/(s.spec_upper_limit), 0.220*(s.spec_upper_limit) - 135/(s.spec_upper_limit)) WHEN ''cst_to_sus'' THEN IFF((s.spec_upper_limit) < 20.6, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 176.28))/0.452, ((s.spec_upper_limit) + SQRT((s.spec_upper_limit)*(s.spec_upper_limit) + 118.8))/0.44) WHEN ''f_to_c'' THEN ((s.spec_upper_limit) * 0.5555555555555556 + -17.77777777777778) WHEN ''c_to_f'' THEN ((s.spec_upper_limit) * 1.8 + 32) WHEN ''k_to_c'' THEN ((s.spec_upper_limit) * 1 + -273.15) WHEN ''c_to_k'' THEN ((s.spec_upper_limit) * 1 + 273.15) WHEN ''gcm3_to_kgm3'' THEN ((s.spec_upper_limit) * 1000) WHEN ''kgm3_to_gcm3'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''api_to_sg'' THEN 141.5/((s.spec_upper_limit)+131.5) WHEN ''sg_to_api'' THEN 141.5/(s.spec_upper_limit)-131.5 WHEN ''g_to_kg'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''kg_to_g'' THEN ((s.spec_upper_limit) * 1000) WHEN ''mg_to_kg'' THEN ((s.spec_upper_limit) * 0.000001) WHEN ''lb_to_kg'' THEN ((s.spec_upper_limit) * 0.45359237) WHEN ''ml_to_l'' THEN ((s.spec_upper_limit) * 0.001) WHEN ''l_to_ml'' THEN ((s.spec_upper_limit) * 1000) WHEN ''m3_to_l'' THEN ((s.spec_upper_limit) * 1000) WHEN ''usgal_to_l'' THEN ((s.spec_upper_limit) * 3.785411784) WHEN ''kpa_to_bar'' THEN ((s.spec_upper_limit) * 0.01) WHEN ''bar_to_kpa'' THEN ((s.spec_upper_limit) * 100) WHEN ''psi_to_bar'' THEN ((s.spec_upper_limit) * 0.0689475729) WHEN ''percent_to_mgkg'' THEN ((s.spec_upper_limit) * 10000) WHEN ''sulfur_percent_to_ppm'' THEN ((s.spec_upper_limit) * 10000) END)) END within_spec,
  mr.quantity_type quantity_type, u.canonical_code recorded_unit_code,
  u.canonical_code<>qt.standard_unit conversion_applied,
  IFF(u.canonical_code=qt.standard_unit,''identity'',cr.rule_id) conversion_rule_id,
  ''silver_lims_buenos_aires'' source_system
  FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
   LEFT JOIN OGFS_DEMO.BRONZE.lab_muestras_ba b ON b.source_row_number=s.source_row_number
  LEFT JOIN OGFS_DEMO.SILVER.material_identity_map mi ON LOWER(mi.source_material_code)=LOWER(s.material_code)
   LEFT JOIN (
     SELECT source_material_code,golden_key,source_table,action
     FROM OGFS_DEMO.SILVER.golden_record_overrides
    QUALIFY ROW_NUMBER() OVER (PARTITION BY source_table,source_material_code
      ORDER BY decided_at DESC,action_id DESC)=1
  ) mo ON mo.action IN (''attach'',''create'')
     AND LOWER(mo.source_material_code)=LOWER(s.material_code)
    AND LOWER(mo.source_table)=LOWER(''lab_muestras_ba'')
   LEFT JOIN OGFS_DEMO.SILVER.conformed_material m ON m.material_key=COALESCE(mi.material_key,mo.golden_key)
  LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
    ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
  LEFT JOIN OGFS_DEMO.SILVER.conformed_test_method tm
    ON tm.governed_standard_reference=COALESCE(mr.governed_standard_reference,s.test_type)
  LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
    ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
  LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
  LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
    ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
  WHERE s.result_value IS NOT NULL AND u.canonical_code IS NOT NULL AND qt.standard_unit IS NOT NULL
    AND (u.canonical_code=qt.standard_unit OR cr.rule_id IS NOT NULL)';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
INSERT INTO OGFS_DEMO.SILVER.quarantine_records
  (source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,quarantined_at)
SELECT source_table,source_row_number,rule_name,reason,site_code,review_status,source_data,CURRENT_TIMESTAMP()
FROM (SELECT ''silver_lims_annandale'' source_table,s.source_row_number source_row_number,''uom_conversion'' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN ''Quantity type not set for this test method''
           WHEN u.canonical_code IS NULL THEN ''Unit is unrecognised: ''||COALESCE(TO_VARCHAR(s.result_unit),''(missing)'')
           ELSE ''Unit is recognised but no conversion path exists from ''||u.canonical_code||'' to ''||qt.standard_unit END reason,
      ''annandale'' site_code,''quarantined'' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_annandale s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_annandale_samples b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT ''silver_lims_houston'' source_table,s.source_row_number source_row_number,''uom_conversion'' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN ''Quantity type not set for this test method''
           WHEN u.canonical_code IS NULL THEN ''Unit is unrecognised: ''||COALESCE(TO_VARCHAR(s.result_unit),''(missing)'')
           ELSE ''Unit is recognised but no conversion path exists from ''||u.canonical_code||'' to ''||qt.standard_unit END reason,
      ''houston'' site_code,''quarantined'' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_houston s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_houston_samples b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT ''silver_lims_curitiba'' source_table,s.source_row_number source_row_number,''uom_conversion'' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN ''Quantity type not set for this test method''
           WHEN u.canonical_code IS NULL THEN ''Unit is unrecognised: ''||COALESCE(TO_VARCHAR(s.result_unit),''(missing)'')
           ELSE ''Unit is recognised but no conversion path exists from ''||u.canonical_code||'' to ''||qt.standard_unit END reason,
      ''curitiba'' site_code,''quarantined'' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_curitiba s
    LEFT JOIN OGFS_DEMO.BRONZE.lims_curitiba_amostras b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL))
UNION ALL
SELECT ''silver_lims_buenos_aires'' source_table,s.source_row_number source_row_number,''uom_conversion'' rule_name,
      CASE WHEN mr.quantity_type IS NULL THEN ''Quantity type not set for this test method''
           WHEN u.canonical_code IS NULL THEN ''Unit is unrecognised: ''||COALESCE(TO_VARCHAR(s.result_unit),''(missing)'')
           ELSE ''Unit is recognised but no conversion path exists from ''||u.canonical_code||'' to ''||qt.standard_unit END reason,
      ''buenos_aires'' site_code,''quarantined'' review_status,OBJECT_CONSTRUCT_KEEP_NULL(s.*) source_data
    FROM OGFS_DEMO.SILVER.silver_lims_buenos_aires s
    LEFT JOIN OGFS_DEMO.BRONZE.lab_muestras_ba b ON b.source_row_number=s.source_row_number
    LEFT JOIN OGFS_DEMO.SILVER.governed_astm_ilsac_test_method_reference mr
      ON REGEXP_REPLACE(UPPER(TRIM(mr.source_method_name)), ''[^A-Z0-9]'', '''')=REGEXP_REPLACE(UPPER(TRIM(b.test_type)), ''[^A-Z0-9]'', '''')
    LEFT JOIN OGFS_DEMO.SILVER.unit_registry u
      ON u.quantity_type=mr.quantity_type AND LOWER(TRIM(u.accepted_alias))=LOWER(TRIM(s.result_unit))
    LEFT JOIN OGFS_DEMO.SILVER.quantity_types qt ON qt.quantity_type=mr.quantity_type
    LEFT JOIN OGFS_DEMO.SILVER.unit_conversion_rules cr
      ON cr.quantity_type=mr.quantity_type AND cr.from_unit=u.canonical_code AND cr.to_unit=qt.standard_unit
    WHERE s.result_value IS NOT NULL AND (mr.quantity_type IS NULL OR u.canonical_code IS NULL OR qt.standard_unit IS NULL OR (u.canonical_code<>qt.standard_unit AND cr.rule_id IS NULL)))';
  EXECUTE IMMEDIATE '-- Foundation Studio · Snowflake execution SQL
-- foundation:stage 2
CREATE OR REPLACE TABLE OGFS_DEMO.SILVER.unrecognized_units AS
SELECT source_data:result_unit::VARCHAR recorded_unit,reason,site_code,COUNT(*) occurrence_count
FROM OGFS_DEMO.SILVER.quarantine_records
 WHERE (rule_name=''uom_conversion'' AND reason LIKE ''Unit is unrecognised:%'')
    OR (rule_name=''uom_vocabulary'' AND reason LIKE ''Unit cannot be resolved in unit_registry:%'')
GROUP BY recorded_unit,reason,site_code';
  RETURN 'ok';
END;
$$;
CREATE OR REPLACE TASK OGFS_DEMO.ORCHESTRATION.silver_pipeline_task
  WAREHOUSE = OGFS_DEMO_WH
  USER_TASK_TIMEOUT_MS = 3600000
  AFTER OGFS_DEMO.ORCHESTRATION.bronze_pipeline_task
AS CALL OGFS_DEMO.SILVER.run_silver_pipeline();
