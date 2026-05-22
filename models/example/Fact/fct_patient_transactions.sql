//NBRx , payer analysis, sales performance, territory reporting
WITH source AS (

    SELECT *
    FROM {{ ref('int_patient_transactions') }}

),

final AS (

    SELECT

        transaction_id,

        patient_id,

        transaction_date,

        transaction_year,

        transaction_month,

        transaction_type,

        channel_type,

        product_name,

        is_nbrx,

        trx_count,

        nbrx_trx_count,

        payer_type,

        payer_group,

        patient_age,

        age_group,

        patient_gender,

        diagnosis_code,

        hcp_id,

        territory_id,

        region_name,

        sales_rep_name,

        record_loaded_at

    FROM source

)

SELECT *
FROM final