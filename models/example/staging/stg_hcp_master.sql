{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH source AS (
    SELECT *
    FROM raw.hcp_master
),

final AS (
    SELECT
        TRIM(hcp_id)                        AS hcp_id,
        TRIM(hcp_npi)                       AS hcp_npi,
        UPPER(TRIM(hcp_name))               AS hcp_name,
        INITCAP(TRIM(specialty))            AS specialty,
        UPPER(TRIM(target_flag))            AS target_flag,
        INITCAP(TRIM(hcp_segment))          AS hcp_segment,
        TRIM(address_id)                    AS address_id,
        CURRENT_TIMESTAMP()                 AS record_loaded_at
    FROM source
)

SELECT *
FROM final