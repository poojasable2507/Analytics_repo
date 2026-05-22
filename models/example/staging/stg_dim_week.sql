WITH source AS (

    SELECT *
    FROM {{ source('raw','dim_week') }}

),

renamed AS (

    SELECT

        week_end_date                                  AS week_end_date,

        week_number                                    AS week_number,

        UPPER(month_name)                              AS month_name,

        quarter_name                                   AS quarter_name,

        year_number                                    AS year_number,

        CASE
            WHEN week_end_date <= CURRENT_DATE
                THEN 1
            ELSE 0
        END                                            AS completed_week_flag,

        CURRENT_TIMESTAMP                              AS record_loaded_at

    FROM source

)

SELECT *
FROM renamed