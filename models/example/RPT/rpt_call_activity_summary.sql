//CRM activity reporting

WITH calls AS (

    SELECT *
    FROM {{ ref('fct_call_activity') }}

),

final AS (

    SELECT

        call_year,

        call_month,

        region_name,

        engagement_channel_group,

        COUNT(DISTINCT call_id)                       AS total_calls,

        SUM(is_completed_call)                        AS completed_calls,

        SUM(is_sample_given)                          AS samples_given

    FROM calls

    GROUP BY

        call_year,
        call_month,
        region_name,
        engagement_channel_group

)

SELECT *
FROM final