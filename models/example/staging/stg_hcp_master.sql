WITH source AS (

    SELECT *
    FROM {{ source('raw','hcp_master') }}

),

renamed AS (
    SELECT
        swtx_hcp_id                                    AS hcp_id,
                hcp_npi                                        AS hcp_npi,
        UPPER(TRIM(hcp_first_name))                    AS hcp_first_name,
        UPPER(TRIM(hcp_last_name))                     AS hcp_last_name,
        UPPER(TRIM(specialty))                         AS specialty,
        UPPER(TRIM(specialty_group))                   AS specialty_group,
        territory_id                                   AS territory_id,
        CASE 
            WHEN target_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS is_target_hcp,
        CASE
            WHEN reach_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS is_reachable,
        CASE
            WHEN email_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS email_opt_in,
        CASE
            WHEN phone_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS phone_opt_in,
        CURRENT_TIMESTAMP                              AS record_loaded_at
    FROM source
)

SELECT *
FROM renamed