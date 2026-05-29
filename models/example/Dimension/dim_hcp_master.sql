{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH hcp AS (

    SELECT *
    FROM {{ ref('stg_hcp_master') }}

),

final AS (

    SELECT

        hcp_id,
        hcp_npi,
        hcp_name,
        specialty,
        target_flag,
        hcp_segment,
        address_id,

        CASE
            WHEN specialty IN ('Cardiology', 'Neurology')
                THEN 'Specialty'
            ELSE 'Primary'
        END AS specialty_group,

        CURRENT_TIMESTAMP() AS record_loaded_at

    FROM hcp

)

SELECT *
FROM final