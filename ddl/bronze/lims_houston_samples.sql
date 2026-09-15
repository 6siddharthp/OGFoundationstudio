-- Foundation Studio · PostgreSQL execution SQL

-- foundation:stage 2
CREATE TABLE bronze."lims_houston_samples" (
              source_row_number integer PRIMARY KEY,
              "samplenumber" text,
"businessline" text,
"materialid" text,
"lotnumber" text,
"containerref" text,
"analysistype" text,
"methodversion" text,
"instrumentcode" text,
"testedby" text,
"reviewedby" text,
"reqdate" timestamp,
"receiveddate" timestamp,
"startdate" timestamp,
"compdate" timestamp,
"prioritylevel" numeric,
"requestedby" text,
"projectcode" text,
"value" numeric,
"uom" text,
"lowerspeclimit" numeric,
"upperspeclimit" numeric,
"status" text,
"approvalstate" text,
"approvaldate" timestamp,
"storageloc" text,
"retestindicator" boolean,
"notes" text,
"location" text,
              loaded_at timestamptz NOT NULL DEFAULT now()
            );

-- foundation:stage 2
COMMENT ON TABLE bronze."lims_houston_samples" IS 'lims_houston: 28 fields defined, 28 source columns, 28 auto-mapped, 0 manually mapped, 0 newly added.';

-- foundation:stage 3
INSERT INTO bronze."lims_houston_samples" (source_row_number, "samplenumber", "businessline", "materialid", "lotnumber", "containerref", "analysistype", "methodversion", "instrumentcode", "testedby", "reviewedby", "reqdate", "receiveddate", "startdate", "compdate", "prioritylevel", "requestedby", "projectcode", "value", "uom", "lowerspeclimit", "upperspeclimit", "status", "approvalstate", "approvaldate", "storageloc", "retestindicator", "notes", "location")
            SELECT row_number, raw_data ->> 'SAMPLE_NUMBER', raw_data ->> 'BUSINESS_LINE', raw_data ->> 'MATERIAL_ID', raw_data ->> 'LOT_NUMBER', raw_data ->> 'CONTAINER_REF', raw_data ->> 'ANALYSIS_TYPE', raw_data ->> 'METHOD_VERSION', raw_data ->> 'INSTRUMENT_CODE', raw_data ->> 'TESTED_BY', raw_data ->> 'QA_SIGNOFF_USER', NULLIF(raw_data ->> 'REQ_DATE', '')::timestamp, NULLIF(raw_data ->> 'RECEIVED_DATE', '')::timestamp, NULLIF(raw_data ->> 'START_DATE', '')::timestamp, NULLIF(raw_data ->> 'COMP_DATE', '')::timestamp, NULLIF(raw_data ->> 'PRIORITY_LEVEL', '')::numeric, raw_data ->> 'REQUESTED_BY', raw_data ->> 'PROJECT_CODE', NULLIF(raw_data ->> 'VALUE', '')::numeric, raw_data ->> 'UOM', NULLIF(raw_data ->> 'LOWER_SPEC_LIMIT', '')::numeric, NULLIF(raw_data ->> 'UPPER_SPEC_LIMIT', '')::numeric, raw_data ->> 'STATUS', raw_data ->> 'APPROVAL_STATE', NULLIF(raw_data ->> 'APPROVAL_DATE', '')::timestamp, raw_data ->> 'STORAGE_LOC', CASE lower(raw_data ->> 'RERUN_FLAG') WHEN 'true' THEN true WHEN 'false' THEN false ELSE NULL END, raw_data ->> 'NOTES', raw_data ->> 'LOCATION'
            FROM foundation_staging_rows WHERE staging_table_id = 2 ORDER BY row_number;
