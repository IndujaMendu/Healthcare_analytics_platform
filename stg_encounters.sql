WITH source AS (
    SELECT * FROM {{ source('raw_healthcare', 'raw_encounters') }}
),

cleaned AS (
    SELECT
        encounter_id,
        patient_id,
        provider_id,
        facility_id,
        admission_date,
        discharge_date,
        (discharge_date - admission_date) AS length_of_stay,
        TRIM(encounter_type) AS encounter_type,
        TRIM(primary_diagnosis_code) AS primary_diagnosis_code,
        TRIM(drg_code) AS drg_code,
        total_charges,
        CURRENT_TIMESTAMP AS loaded_at
    FROM source
    WHERE encounter_id IS NOT NULL
      AND patient_id IS NOT NULL
      AND admission_date IS NOT NULL
)

SELECT * FROM cleaned