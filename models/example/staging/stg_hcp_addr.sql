{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH source AS (
    SELECT *
    FROM raw.hcp_addr
),

final AS (
    SELECT
        TRIM(address_id)                    AS address_id,
        INITCAP(TRIM(address_line_1))       AS address_line_1,
        INITCAP(TRIM(city))                 AS city,
        UPPER(TRIM(state))                  AS state,
        TRIM(zip_code)                      AS zip_code,
        CURRENT_TIMESTAMP()                 AS record_loaded_at
    FROM source
)

SELECT *
FROM final