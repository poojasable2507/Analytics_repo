{{ config(
    materialized='table',
    schema='DEV'
) }}

SELECT *
    FROM {{ source('raw','hcp_addr')}}