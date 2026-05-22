//--------hcp with geo
WITH hcp AS (

    SELECT *
    FROM {{ ref('stg_hcp_master') }}

),

territory AS (

    SELECT *
    FROM {{ ref('stg_territory_alignment') }}

),

final AS (

    SELECT

        hcp.hcp_id,
        hcp.hcp_npi,

        hcp.hcp_first_name,
        hcp.hcp_last_name,

        CONCAT(
            hcp.hcp_first_name,
            ' ',
            hcp.hcp_last_name
        )                                               AS hcp_full_name,

        hcp.specialty,
        hcp.specialty_group,

        hcp.is_target_hcp,
        hcp.is_reachable,

        hcp.email_opt_in,
        hcp.phone_opt_in,

        territory.territory_id,
        territory.territory_name,
        territory.region_name,

        territory.sales_rep_name,
        territory.manager_name,

        territory.territory_region_key,

        CASE
            WHEN hcp.is_target_hcp = 1
                 AND hcp.is_reachable = 1
                THEN 'HIGH PRIORITY'

            WHEN hcp.is_target_hcp = 1
                THEN 'TARGET ONLY'

            ELSE 'NON TARGET'
        END                                             AS hcp_priority_segment,

        CURRENT_TIMESTAMP                               AS record_loaded_at

    FROM hcp

    LEFT JOIN territory
        ON hcp.territory_id = territory.territory_id

)

SELECT *
FROM final