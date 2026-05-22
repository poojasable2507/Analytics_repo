//Weekly NBRx trend by region and product, 
//business use - Dashboard:monthly NBRx trend, regional performance, product performance
WITH trx AS (

    SELECT *
    FROM {{ ref('fct_patient_transactions') }}

),

final AS (

    SELECT

        transaction_year,

        transaction_month,

        region_name,

        product_name,

        COUNT(DISTINCT patient_id)                     AS total_patients,

        SUM(trx_count)                                AS total_trx,

        SUM(nbrx_trx_count)                           AS total_nbrx,

        COUNT(DISTINCT CASE
            WHEN is_nbrx = 1
                THEN patient_id
        END)                                          AS nbrx_patients

    FROM trx

    GROUP BY

        transaction_year,
        transaction_month,
        region_name,
        product_name

)

SELECT *
FROM final