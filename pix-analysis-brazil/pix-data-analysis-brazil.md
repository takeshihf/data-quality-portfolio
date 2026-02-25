# Pix Analysis Brazil — End-to-End Data Project

🔗 Live Dashboard: https://lookerstudio.google.com/reporting/0765529d-4c7e-40c2-b538-a15f8460e19b  
📊 Official Data Source: https://dadosabertos.bcb.gov.br/dataset/pix  

An end-to-end data analysis project exploring adoption patterns of Pix, Brazil’s instant payment system, using official Central Bank open datasets.

This project demonstrates the full analytics lifecycle: data extraction, transformation, modeling, and insight generation from real-world public data.

---

## Why This Project Exists

Pix is one of the fastest-growing real-time payment systems globally.  
Understanding its adoption patterns provides insights into:

- Financial inclusion  
- Regional digitalization  
- Behavioral differences between individuals and businesses  

This project was built to transform raw public data into actionable insights through a reproducible analytics pipeline.

---

## Impact

- Built a complete data pipeline from public API to dashboards  
- Processed large-scale regional payment datasets  
- Generated regional adoption insights with business interpretation  
- Delivered a reproducible open-data analytics case study  

This mirrors real-world analytics workflows used in production environments.

---

## Architecture Overview

Data Pipeline:

Public API → Python ETL → PostgreSQL → SQL Analytics → BI Dashboard

### Stack

- Python (requests, pandas) — ingestion & transformation  
- PostgreSQL — relational modeling  
- SQL — analytical queries  
- Looker Studio / Power BI — visualization  

---

## Data Sources

All datasets used in this project come from the official Central Bank of Brazil (BCB) Open Data Portal.

Primary source:  
https://dadosabertos.bcb.gov.br/dataset/pix

Datasets include:
- Pix keys distribution  
- Transactions per municipality  
- Individual vs business usage patterns  

The data is publicly available and maintained by Brazil’s monetary authority, ensuring reliability and reproducibility.

---

## Data Pipeline

### 1. Data Extraction
- Consumed BCB open data endpoints via Python
- Converted raw responses into structured tabular datasets

### 2. Transformation
- Cleaned and standardized regional identifiers  
- Normalized PF (individual) vs PJ (business) dimensions  
- Generated analysis-ready datasets  

### 3. Storage
- Modeled relational schema for analytical querying  
- Structured tables for scalable aggregation  

### 4. Analysis
- Aggregated regional transaction trends  
- Compared adoption patterns across segments  
- Identified concentration clusters  

### 5. Visualization
Built dashboards highlighting:
- Regional disparities  
- Business vs individual adoption  
- Volume distribution patterns  

---

## Key Findings

- Pix adoption is heavily concentrated in Southeast Brazil  
- Business usage shows stronger regional clustering than individual usage  
- Significant disparities exist in digital payment penetration across regions  

These findings highlight uneven digital financial inclusion.

---

## SQL
- `sql/schema.sql` — PostgreSQL schema for Pix datasets  
- `sql/analytics.sql` — analytical queries used for insights and dashboard validation  

---

## Live Dashboard

Explore the interactive dashboard:

https://lookerstudio.google.com/reporting/0765529d-4c7e-40c2-b538-a15f8460e19b

The dashboard provides:
- Regional adoption comparisons  
- Behavioral segmentation insights  
- Interactive exploration of Pix trends  

---

## Reproducibility

This project was intentionally designed to be reproducible.

To replicate:
1. Pull public datasets from the BCB Open Data Portal  
2. Load into a relational database  
3. Execute analytical queries  
4. Connect a BI tool for visualization  


To load the dataset into PostgreSQL:

1. Download the public CSV files
2. Update file paths in `scripts/load_postgres.sql`
3. Execute the script in pgAdmin or psql

---

## What This Demonstrates

- Working with real-world public datasets  
- End-to-end data pipeline design  
- SQL-first analytical thinking  
- Translating raw data into insights  
- Communicating findings through dashboards  

---

## Transparency & Reproducibility

This project is fully reproducible using public data.

Official dataset:  
https://dadosabertos.bcb.gov.br/dataset/pix

Public dashboard:  
https://lookerstudio.google.com/reporting/0765529d-4c7e-40c2-b538-a15f8460e19b

No proprietary or private data was used.

---

## About Me

I build data projects focused on reliability, clarity, and real-world applicability.

My work sits at the intersection of:
- Data Quality  
- Analytics  
- Business Intelligence  

If you're hiring for data roles involving analytics, quality, or data reliability — let's connect.

---

## Author

Aelson Takeshi (Tk) Hamaguchi França  
Data Quality Analyst | SQL | BI | Data Reliability  

GitHub: https://github.com/takeshihf  
LinkedIn: https://www.linkedin.com/in/aelson-takeshi-hamaguchi-franca
