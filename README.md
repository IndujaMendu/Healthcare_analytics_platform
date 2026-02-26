# Healthcare Analytics Platform

A healthcare data lakehouse built with dbt and PostgreSQL, featuring star schema design.

## 🎯 Project Overview

Built a complete healthcare analytics platform that transforms raw hospital data into business-ready insights.

**What it does:**
- Processes patient, encounter, and claims data
- Transforms raw data into clean analytics tables
- Implements star schema (facts & dimensions)
- Enables self-service BI and reporting

## 🏗️ Architecture
```
Raw Data (Bronze) → Staging (Silver) → Analytics (Gold)
     ↓                    ↓                   ↓
  4 tables           3 views             3 tables
```
## 📊 Data Models
### Staging Layer
- **stg_patients** - Cleaned patient demographics
- **stg_encounters** - Standardized hospital visits  
- **stg_claims** - Normalized billing data

### Analytics Layer
- **dim_patients** - Patient dimension (10 rows)
- **dim_providers** - Provider dimension (5 rows)
- **fact_patient_encounters** - Encounter metrics (8 rows)

## 🚀 Tech Stack

- PostgreSQL 18 (database)
- dbt Core 1.7+ (transformations)
- SQL (data modeling)
- Star schema design
 
 ## 💡 Skills 
✅ dbt for data transformation
✅ Star schema data modeling
✅ SQL (CTEs, joins, aggregations)
✅ Data quality testing
✅ Analytics engineering

## 📈 Business Questions Answered

- Patient volume trends
- Revenue by encounter type
- Provider performance metrics
- Demographics analysis
- Length of stay patterns

## 🛠️ Project Structure
```
healthcare-analytics-platform/
├── models/
│   ├── staging/
│   │   ├── stg_patients.sql
│   │   ├── stg_encounters.sql
│   │   ├── stg_claims.sql
│   │   └── sources.yml
│   └── marts/
│       ├── dim_patients.sql
│       ├── dim_providers.sql
│       └── fact_patient_encounters.sql
└── dbt_project.yml
```
## 🔒 Data Privacy

Uses synthetic healthcare data for demonstration purposes only

## 👤 Author
- [Induja Mendu]
- Email: [indujamendu99@gmail.com]

---

*Built as a data engineering portfolio project*



