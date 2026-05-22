//HCP engagement and targeting analysis
//Business use - target HCP engagement, sales effectiveness, CRM performance
WITH calls AS (

    SELECT *
    FROM {{ ref('fct_call_activity') }}

),

hcp AS (

    SELECT *
    FROM {{ ref('dim_hcp') }}

),

final AS (

    SELECT

        hcp.hcp_id,

        hcp.hcp_full_name,

        hcp.specialty,

        hcp.hcp_priority_segment,

        hcp.region_name,

        COUNT(DISTINCT calls.call_id)                 AS total_calls,

        SUM(calls.is_completed_call)                  AS completed_calls,

        SUM(calls.is_sample_given)                    AS samples_given

    FROM hcp

    LEFT JOIN calls
        ON hcp.hcp_id = calls.hcp_id

    GROUP BY

        hcp.hcp_id,
        hcp.hcp_full_name,
        hcp.specialty,
        hcp.hcp_priority_segment,
        hcp.region_name

)

SELECT *
FROM final