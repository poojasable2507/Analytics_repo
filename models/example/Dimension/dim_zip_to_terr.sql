{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH terr AS (

    SELECT *
    FROM {{ ref('stg_zip_to_terr') }}

),

final AS (

    SELECT

        zip_code,
        territory_id,
        territory_name,
        region_name,

        CURRENT_TIMESTAMP() AS record_loaded_at

    FROM terr

)

SELECT *
FROM final