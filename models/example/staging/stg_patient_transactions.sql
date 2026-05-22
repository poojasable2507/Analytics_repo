WITH source AS (

    SELECT *
    FROM {{ source('raw','patient_transactions') }}

),
renamed AS (
    SELECT
        transaction_id                                 AS transaction_id,
        patient_id                                     AS patient_id,
        hcp_npi                                        AS hcp_npi,
        transaction_date                               AS transaction_date,
        UPPER(TRIM(transaction_type))                  AS transaction_type,
        UPPER(TRIM(product_name))                      AS product_name,
        CASE
            WHEN nbrx_flag = 'Y' THEN 1
            ELSE 0
        END                                            AS is_nbrx,
        trx_count                                      AS trx_count,
        UPPER(TRIM(payer_type))                        AS payer_type,
        patient_age                                    AS patient_age,
        UPPER(TRIM(patient_gender))                    AS patient_gender,
        diagnosis_code                                 AS diagnosis_code,
        CASE
            WHEN transaction_type IN ('PAP','BRIDGE','QUICKSTART')
                THEN 'HUB'
            WHEN transaction_type = 'COM'
                THEN 'SP'
            ELSE 'OTHER'
        END                                            AS channel_type,
        CASE
            WHEN patient_age < 18 THEN 'PEDIATRIC'
            WHEN patient_age BETWEEN 18 AND 64 THEN 'ADULT'
            ELSE 'SENIOR'
        END                                            AS age_group,
        CURRENT_TIMESTAMP                              AS record_loaded_at
    FROM source
)
SELECT *
FROM renamed