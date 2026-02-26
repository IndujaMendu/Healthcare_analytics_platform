{{
  config(
    materialized='table'
  )
}}

WITH encounters AS (
    SELECT * FROM {{ ref('stg_encounters') }}
),

patients AS (
    SELECT * FROM {{ ref('dim_patients') }}
),

claims_agg AS (
    SELECT
        encounter_id,
        COUNT(*) AS claim_count,
        SUM(billed_amount) AS total_billed,
        SUM(paid_amount) AS total_paid,
        SUM(adjustment_amount) AS total_adjustments
    FROM {{ ref('stg_claims') }}
    GROUP BY encounter_id
)

SELECT
    e.encounter_id,
    e.patient_id,
    e.provider_id,
    e.facility_id,
    e.admission_date,
    e.discharge_date,
    e.length_of_stay,
    EXTRACT(YEAR FROM e.admission_date) AS admission_year,
    EXTRACT(MONTH FROM e.admission_date) AS admission_month,
    TO_CHAR(e.admission_date, 'Day') AS admission_day_of_week,
    p.age AS patient_age,
    p.age_group AS patient_age_group,
    p.gender AS patient_gender,
    p.state AS patient_state,
    p.insurance_type AS patient_insurance,
    e.encounter_type,
    e.primary_diagnosis_code,
    e.drg_code,
    e.total_charges,
    COALESCE(c.total_billed, 0) AS total_billed,
    COALESCE(c.total_paid, 0) AS total_paid,
    COALESCE(c.total_adjustments, 0) AS total_adjustments,
    COALESCE(c.claim_count, 0) AS claim_count,
    CASE 
        WHEN e.length_of_stay > 0 
        THEN ROUND(e.total_charges / e.length_of_stay, 2)
        ELSE e.total_charges
    END AS avg_daily_charge,
    CASE 
        WHEN c.total_billed > 0
        THEN ROUND((c.total_paid / c.total_billed) * 100, 2)
        ELSE 0
    END AS collection_rate_pct,
    CASE WHEN e.length_of_stay > 7 THEN TRUE ELSE FALSE END AS is_long_stay,
    CASE WHEN e.encounter_type = 'Emergency' THEN TRUE ELSE FALSE END AS is_emergency,
    CURRENT_TIMESTAMP AS created_at

FROM encounters e
LEFT JOIN patients p ON e.patient_id = p.patient_id
LEFT JOIN claims_agg c ON e.encounter_id = c.encounter_id