WITH source AS (

    SELECT *
    FROM {{ source('raw','territory_alignment') }}

),

renamed AS (

    SELECT

        territory_id                                   AS territory_id,

        UPPER(TRIM(territory_name))                    AS territory_name,

        UPPER(TRIM(region_name))                       AS region_name,

        UPPER(TRIM(sales_rep_name))                    AS sales_rep_name,

        UPPER(TRIM(manager_name))                      AS manager_name,

        CONCAT(
            territory_id,
            '_',
            region_name
        )                                              AS territory_region_key,

        CURRENT_TIMESTAMP                              AS record_loaded_at

    FROM source

)

SELECT *
FROM renamed