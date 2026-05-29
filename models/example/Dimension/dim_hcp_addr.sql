{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH addr AS (

    SELECT *
    FROM {{ ref('stg_hcp_addr') }}

),

final AS (

    SELECT

        address_id,
        address_line_1,
        city,
        state,
        zip_code,

        CURRENT_TIMESTAMP() AS record_loaded_at

    FROM addr

)

SELECT *
FROM final 