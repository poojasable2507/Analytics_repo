//Payer analysis
//Dashboard: Commercial vs Government mix, payer trends, reimbursement analysis

WITH trx AS (

    SELECT *
    FROM {{ ref('fct_patient_transactions') }}

),

final AS (

    SELECT

        payer_group,

        payer_type,

        COUNT(DISTINCT patient_id)                    AS total_patients,

        SUM(trx_count)                                AS total_trx,

        SUM(nbrx_trx_count)                           AS total_nbrx

    FROM trx

    GROUP BY

        payer_group,
        payer_type

)

SELECT *
FROM final