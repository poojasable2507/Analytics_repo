//reusable HCP dimension, connected to fact tables, used in Power BI slicers/filters

WITH source AS (

    SELECT *
    FROM {{ ref('int_hcp_master') }}

),

final AS (

    SELECT

        hcp_id,

        hcp_npi,

        hcp_full_name,

        specialty,

        specialty_group,

        is_target_hcp,

        is_reachable,

        email_opt_in,

        phone_opt_in,

        territory_id,

        territory_name,

        region_name,

        sales_rep_name,

        manager_name,

        hcp_priority_segment,

        record_loaded_at

    FROM source

)

SELECT *
FROM final