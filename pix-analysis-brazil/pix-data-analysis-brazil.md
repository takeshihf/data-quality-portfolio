# Pix Data Analysis — Brazil Open Data Project

This project explores transaction patterns and regional distribution of Pix, Brazil’s instant payment system, using official public datasets from the Central Bank of Brazil.

It was developed as an end-to-end data analysis case study covering data extraction, transformation, modeling, and visualization using modern data tools.

---

## Objectives

- Analyze Pix adoption across Brazilian regions
- Compare individual (PF) vs business (PJ) transaction behavior
- Build a reproducible pipeline from raw public data to analytical insights
- Demonstrate end-to-end data analytics skills using real-world datasets

---

## Tech Stack

- Python (requests, pandas) — data extraction and transformation  
- PostgreSQL — data modeling and storage  
- SQL — aggregations and analytical queries  
- Looker Studio / Power BI — dashboard and visualization  

---

## Data Source

Data was collected from the Central Bank of Brazil open data portal using the SGS public API.

Sources include:
- Pix keys by region
- Pix transactions by municipality
- Individual vs business usage metrics

All data used in this project is publicly available and reproducible.

---

## Pipeline Overview

1. Extracted Pix datasets via API requests using Python  
2. Converted JSON responses into structured CSV datasets  
3. Modeled relational tables in PostgreSQL  
4. Wrote analytical SQL queries for aggregations  
5. Built dashboards to visualize trends and regional patterns  

---

## Key Insights

- The Southeast region concentrates the majority of Pix transaction volume  
- Business Pix usage is more regionally concentrated than individual usage  
- There are clear regional disparities in digital payment adoption across Brazil  

---

## Repository Structure

pix-analysis/
│
├── data/
│ ├── raw/
│ └── processed/
│
├── notebooks/
│ └── pix_analysis.ipynb
│
├── sql/
│ ├── schema.sql
│ └── queries.sql
│
├── dashboard/
│ └── screenshots/
│
└── README.md

---

## Dashboard

Interactive dashboard:  
https://lookerstudio.google.com/reporting/0765529d-4c7e-40c2-b538-a15f8460e19b

---

## What This Project Demonstrates

- Working with real-world public datasets  
- Building reproducible data pipelines  
- SQL data modeling and analytics  
- Translating raw data into business insights  
- Communicating findings through dashboards  

---

## Why This Project

This project was built to showcase practical data analytics skills using real data, focusing on clarity, reproducibility, and real-world applicability.

It reflects how I approach data problems end-to-end: from extraction to insights.

---

## Author

Aelson Takeshi (Tk) Hamaguchi França  
Data Quality Analyst | SQL | BI | Data Reliability  

GitHub: https://github.com/takeshihf  
LinkedIn: https://www.linkedin.com/in/aelson-takeshi-hamaguchi-franca
