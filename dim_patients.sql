{{
  config(
    materialized='table'
  )
}}

SELECT
    patient_id,
    first_name,
    last_name,
    full_name,
    date_of_birth,
    age,
    age_group,
    gender,
    city,
    state,
    zip_code,
    insurance_type,
    loaded_at
FROM {{ ref('stg_patients') }}