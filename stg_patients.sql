WITH source AS (
    SELECT * FROM {{ source('raw_healthcare', 'raw_patients') }}
),

cleaned AS (
    SELECT
        patient_id,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        TRIM(first_name) || ' ' || TRIM(last_name) AS full_name,
        date_of_birth,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) < 18 THEN 'Pediatric'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 18 AND 64 THEN 'Adult'
            ELSE 'Senior'
        END AS age_group,
        LOWER(gender) AS gender,
        TRIM(city) AS city,
        UPPER(TRIM(state)) AS state,
        TRIM(zip_code) AS zip_code,
        TRIM(insurance_type) AS insurance_type,
        CURRENT_TIMESTAMP AS loaded_at
    FROM source
    WHERE patient_id IS NOT NULL
)

SELECT * FROM cleaned