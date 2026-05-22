WITH source AS (

    SELECT *
    FROM {{ source('raw','call_activity') }}

),

renamed AS (

    SELECT

        call_id                                        AS call_id,

        hcp_npi                                        AS hcp_npi,

        call_date                                      AS call_date,

        UPPER(TRIM(call_channel))                      AS call_channel,

        UPPER(TRIM(call_status))                       AS call_status,

        CASE
            WHEN sample_given_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS is_sample_given,

        CASE
            WHEN UPPER(call_status) = 'COMPLETED'
                THEN 1
            ELSE 0
        END                                            AS is_completed_call,

        DAYNAME(call_date)                             AS call_day_name,

        CURRENT_TIMESTAMP                              AS record_loaded_at

    FROM source

)

SELECT *
FROM renamed