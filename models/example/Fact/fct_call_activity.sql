WITH source AS (

    SELECT *
    FROM {{ ref('int_call_activity') }}

),

final AS (

    SELECT

        call_id,

        call_date,

        call_year,

        call_month,

        call_channel,

        engagement_channel_group,

        call_status,

        is_completed_call,

        is_sample_given,

        call_day_name,

        hcp_id,

        territory_id,

        region_name,

        sales_rep_name,

        record_loaded_at

    FROM source

)

SELECT *
FROM final