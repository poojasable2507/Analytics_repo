//Stores:territory hierarchy, region structure, sales hierarchy
WITH source AS (

    SELECT *
    FROM {{ ref('stg_territory_alignment') }}

),

final AS (

    SELECT DISTINCT

        territory_id,

        territory_name,

        region_name,

        sales_rep_name,

        manager_name,

        territory_region_key,

        record_loaded_at

    FROM source

)

SELECT *
FROM final