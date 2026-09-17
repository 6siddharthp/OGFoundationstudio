-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 4
CREATE TABLE silver.conformed_test_result (
            test_result_key text PRIMARY KEY, lab_sample_key text, test_method_key text, material_key text,
            result_date timestamp, result_value numeric, result_unit text, spec_lower_limit numeric,
            spec_upper_limit numeric, within_spec boolean, source_system text
          );

-- foundation:stage 6
INSERT INTO silver.conformed_test_result 
          SELECT 'RES_' || md5('silver_engine_test_cell_lubricants' || ':' || source_row_number) test_result_key,
            NULL::text lab_sample_key,
            NULL::text test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_engine_test_cell_lubricants' source_system
          FROM silver."silver_engine_test_cell_lubricants" r UNION ALL 
          SELECT 'RES_' || md5('silver_fuel_trial_fuels' || ':' || source_row_number) test_result_key,
            NULL::text lab_sample_key,
            NULL::text test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_fuel_trial_fuels' source_system
          FROM silver."silver_fuel_trial_fuels" r UNION ALL 
          SELECT 'RES_' || md5('silver_lims_buenos_aires' || ':' || source_row_number) test_result_key,
            'SMP_' || md5('buenos_aires:' || source_row_number) lab_sample_key,
            'MTH_' || md5(to_jsonb(r)->>'test_type') test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_lims_buenos_aires' source_system
          FROM silver."silver_lims_buenos_aires" r UNION ALL 
          SELECT 'RES_' || md5('silver_lims_annandale' || ':' || source_row_number) test_result_key,
            'SMP_' || md5('annandale:' || source_row_number) lab_sample_key,
            'MTH_' || md5(to_jsonb(r)->>'test_type') test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_lims_annandale' source_system
          FROM silver."silver_lims_annandale" r UNION ALL 
          SELECT 'RES_' || md5('silver_lims_curitiba' || ':' || source_row_number) test_result_key,
            'SMP_' || md5('curitiba:' || source_row_number) lab_sample_key,
            'MTH_' || md5(to_jsonb(r)->>'test_type') test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_lims_curitiba' source_system
          FROM silver."silver_lims_curitiba" r UNION ALL 
          SELECT 'RES_' || md5('silver_lims_houston' || ':' || source_row_number) test_result_key,
            'SMP_' || md5('houston:' || source_row_number) lab_sample_key,
            'MTH_' || md5(to_jsonb(r)->>'test_type') test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_lims_houston' source_system
          FROM silver."silver_lims_houston" r UNION ALL 
          SELECT 'RES_' || md5('silver_toxicology_trial_chemicals' || ':' || source_row_number) test_result_key,
            NULL::text lab_sample_key,
            NULL::text test_method_key,
            NULL::text material_key,
            coalesce((to_jsonb(r)->>'test_date')::timestamp, (to_jsonb(r)->>'trial_date')::timestamp, (to_jsonb(r)->>'date_completed')::timestamp) result_date,
            coalesce((to_jsonb(r)->>'result_value')::numeric, (to_jsonb(r)->>'value')::numeric) result_value,
            coalesce(to_jsonb(r)->>'result_unit', to_jsonb(r)->>'uom') result_unit,
            (to_jsonb(r)->>'spec_lower_limit')::numeric spec_lower_limit,
            (to_jsonb(r)->>'spec_upper_limit')::numeric spec_upper_limit,
            NULL::boolean within_spec, 'silver_toxicology_trial_chemicals' source_system
          FROM silver."silver_toxicology_trial_chemicals" r;
