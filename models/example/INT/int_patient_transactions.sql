//patient transaction with hcp details
WITH trx AS (

    SELECT *
    FROM {{ ref('stg_ptnt_trans') }}

),

hcp AS (

    SELECT *
    FROM {{ ref('int_hcp_master') }}

),

final AS (

    SELECT

        trx.transaction_id,
        trx.patient_id,

        trx.transaction_date,

        YEAR(trx.transaction_date)                      AS transaction_year,

        MONTH(trx.transaction_date)                     AS transaction_month,

        trx.transaction_type,
        trx.channel_type,

        trx.product_name,

        trx.is_nbrx,

        trx.trx_count,

        trx.payer_type,

        trx.patient_age,
        trx.age_group,

        trx.patient_gender,

        trx.diagnosis_code,

        hcp.hcp_id,
        hcp.hcp_full_name,

        hcp.specialty,
        hcp.specialty_group,

        hcp.is_target_hcp,

        hcp.territory_id,
        hcp.territory_name,
        hcp.region_name,

        hcp.sales_rep_name,
        hcp.manager_name,

        CASE
            WHEN trx.is_nbrx = 1
                THEN trx.trx_count
            ELSE 0
        END                                             AS nbrx_trx_count,

        CASE
            WHEN trx.payer_type = 'COMMERCIAL'
                THEN 'COMMERCIAL'

            WHEN trx.payer_type = 'MEDICARE'
                THEN 'GOVERNMENT'

            WHEN trx.payer_type = 'MEDICAID'
                THEN 'GOVERNMENT'

            ELSE 'OTHER'
        END                                             AS payer_group,

        CURRENT_TIMESTAMP                               AS record_loaded_at

    FROM trx

    LEFT JOIN hcp
        ON trx.hcp_npi = hcp.hcp_npi

)

SELECT *
FROM final