//CRM activity with HCP details, engagement metrics
WITH calls AS (

    SELECT *
    FROM {{ ref('stg_call_activity') }}

),

hcp AS (

    SELECT *
    FROM {{ ref('int_hcp_master') }}

),

final AS (

    SELECT

        calls.call_id,

        calls.call_date,

        YEAR(calls.call_date)                           AS call_year,

        MONTH(calls.call_date)                          AS call_month,

        calls.call_channel,

        calls.call_status,

        calls.is_completed_call,

        calls.is_sample_given,

        calls.call_day_name,

        hcp.hcp_id,
        hcp.hcp_full_name,

        hcp.specialty,

        hcp.is_target_hcp,

        hcp.territory_id,
        hcp.territory_name,
        hcp.region_name,

        hcp.sales_rep_name,

        CASE
            WHEN calls.call_channel = 'FACETOFACE'
                THEN 'IN PERSON'

            WHEN calls.call_channel = 'EMAIL'
                THEN 'DIGITAL'

            WHEN calls.call_channel = 'PHONE'
                THEN 'REMOTE'

            ELSE 'OTHER'
        END                                             AS engagement_channel_group,

        CURRENT_TIMESTAMP                               AS record_loaded_at

    FROM calls

    LEFT JOIN hcp
        ON calls.hcp_npi = hcp.hcp_npi

)

SELECT *
FROM final