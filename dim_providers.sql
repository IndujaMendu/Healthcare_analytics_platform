{{
  config(
    materialized='table'
  )
}}

WITH source AS (
    SELECT * FROM {{ source('raw_healthcare', 'raw_providers') }}
)

SELECT
    provider_id,
    TRIM(provider_name) AS provider_name,
    TRIM(specialty) AS specialty,
    TRIM(facility_name) AS facility_name,
    TRIM(city) AS city,
    UPPER(TRIM(state)) AS state,
    CURRENT_TIMESTAMP AS loaded_at
FROM source
WHERE provider_id IS NOT NULL