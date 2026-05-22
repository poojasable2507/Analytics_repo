WITH source AS (

    SELECT *
    FROM {{ ref('stg_dim_week') }}

),

final AS (

    SELECT

        week_end_date,

        week_number,

        month_name,

        quarter_name,

        year_number,

        completed_week_flag,

        record_loaded_at

    FROM source

)

SELECT *
FROM final