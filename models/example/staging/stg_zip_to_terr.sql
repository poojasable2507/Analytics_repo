{{ config(
    materialized='table',
    schema='DEV'
) }}

SELECT *
FROM {{ source('raw','zip_to_terr') }}