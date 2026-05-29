{{ config(
    materialized='table',
    schema='DEV'
) }}

SELECT *
FROM {{ source('raw','ptnt_trans') }}