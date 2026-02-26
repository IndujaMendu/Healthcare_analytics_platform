WITH source AS (
    SELECT * FROM {{ source('raw_healthcare', 'raw_claims') }}
),

cleaned AS (
    SELECT
        claim_id,
        encounter_id,
        patient_id,
        provider_id,
        service_date,
        TRIM(claim_type) AS claim_type,
        TRIM(diagnosis_code) AS diagnosis_code,
        TRIM(procedure_code) AS procedure_code,
        TRIM(claim_status) AS claim_status,
        billed_amount,
        paid_amount,
        billed_amount - paid_amount AS adjustment_amount,
        CASE 
            WHEN billed_amount > 0 
            THEN ROUND((paid_amount / billed_amount) * 100, 2)
            ELSE 0 
        END AS payment_rate_pct,
        CURRENT_TIMESTAMP AS loaded_at
    FROM source
    WHERE claim_id IS NOT NULL
      AND patient_id IS NOT NULL
)

SELECT * FROM cleaned