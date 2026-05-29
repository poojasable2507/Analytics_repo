{{ config(
    materialized='table',
    schema='DEV'
) }}

WITH trx AS (

    SELECT *
    FROM {{ ref('stg_ptnt_trans') }}

),

final AS (

    SELECT

        transaction_id,
        patient_id,
        hcp_id,
        product_name,
        rx_date,
        trx_count,
        nbrx_count,
        payer_name,
        payer_type,
        patient_age,
        patient_gender,

        DATE_TRUNC('MONTH', trx_date) AS trx_month,

        CURRENT_TIMESTAMP() AS record_loaded_at

    FROM trx

)

SELECT *
FROM final