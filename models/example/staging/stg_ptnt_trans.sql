{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH source AS (
    SELECT *
    FROM raw.ptnt_trans

),

final AS (
    SELECT
        TRIM(transaction_id)                AS transaction_id,
        TRIM(patient_id)                    AS patient_id,
        TRIM(hcp_id)                        AS hcp_id,
        INITCAP(TRIM(product_name))         AS product_name,
        trx_date,
        trx_count,
        nbrx_count,
        INITCAP(TRIM(payer_name))           AS payer_name,
        INITCAP(TRIM(payer_type))           AS payer_type,
        patient_age,
        UPPER(TRIM(patient_gender))         AS patient_gender,
        CURRENT_TIMESTAMP()                 AS record_loaded_at
    FROM source
)
SELECT *
FROM final


