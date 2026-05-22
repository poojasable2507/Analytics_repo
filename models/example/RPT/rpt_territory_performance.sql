//Territory-level healthcare KPI reporting
WITH trx AS (

    SELECT *
    FROM {{ ref('fct_patient_transactions') }}

),

final AS (

    SELECT

        territory_id,

        region_name,

        sales_rep_name,

        COUNT(DISTINCT hcp_id)                        AS total_hcps,

        COUNT(DISTINCT patient_id)                    AS total_patients,

        SUM(trx_count)                                AS total_trx,

        SUM(nbrx_trx_count)                           AS total_nbrx

    FROM trx

    GROUP BY

        territory_id,
        region_name,
        sales_rep_name

)

SELECT *
FROM final