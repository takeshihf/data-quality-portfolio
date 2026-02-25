-- Pix Open Data Project - PostgreSQL Loader Script
-- Author: Aelson Takeshi

-- STEP 1 — CREATE SCHEMA

CREATE SCHEMA IF NOT EXISTS pix;
SET search_path TO pix;

-- STEP 2 — CREATE TABLES

DROP TABLE IF EXISTS pix_keys CASCADE;
DROP TABLE IF EXISTS pix_txn_municipality CASCADE;

CREATE TABLE pix_keys (
  ref_date          DATE        NOT NULL,
  ispb              BIGINT      NOT NULL,
  institution_name  TEXT        NOT NULL,
  user_nature       VARCHAR(2)  NOT NULL,
  key_type          TEXT        NOT NULL,
  key_count         BIGINT      NOT NULL
);

CREATE TABLE pix_txn_municipality (
  yyyymm               INTEGER NOT NULL,
  municipality_ibge     INTEGER,
  municipality_name     TEXT,
  state_ibge            INTEGER,
  state_name            TEXT,
  region_code           TEXT,
  region_name           TEXT,

  payer_pf_value        NUMERIC(20,2),
  payer_pf_count        BIGINT,
  payer_pj_value        NUMERIC(20,2),
  payer_pj_count        BIGINT,

  receiver_pf_value     NUMERIC(20,2),
  receiver_pf_count     BIGINT,
  receiver_pj_value     NUMERIC(20,2),
  receiver_pj_count     BIGINT,

  payer_pf_people       BIGINT,
  payer_pj_people       BIGINT,
  receiver_pf_people    BIGINT,
  receiver_pj_people    BIGINT
);

-- STEP 3 — LOAD DATA (EDIT PATHS HERE)

-- ⚠️ UPDATE THESE PATHS BEFORE RUNNING
-- Example Windows:
-- 'C:\\Users\\YourName\\Downloads\\ChavesPix.csv'
-- Example Mac/Linux:
-- '/Users/yourname/Downloads/ChavesPix.csv'

-- -------- LOAD PIX KEYS --------
COPY pix_keys (
  ref_date,
  ispb,
  institution_name,
  user_nature,
  key_type,
  key_count
)
FROM '/ABSOLUTE/PATH/ChavesPix.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ',',
  ENCODING 'UTF8'
);

-- -------- LOAD TRANSACTIONS --------
COPY pix_txn_municipality (
  yyyymm,
  municipality_ibge,
  municipality_name,
  state_ibge,
  state_name,
  region_code,
  region_name,

  payer_pf_value,
  payer_pf_count,
  payer_pj_value,
  payer_pj_count,

  receiver_pf_value,
  receiver_pf_count,
  receiver_pj_value,
  receiver_pj_count,

  payer_pf_people,
  payer_pj_people,
  receiver_pf_people,
  receiver_pj_people
)
FROM '/ABSOLUTE/PATH/TransacoesPixPorMunicipio.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ',',
  ENCODING 'UTF8'
);

-- STEP 4 — QUICK VALIDATION QUERIES

-- Row counts
SELECT 'pix_keys' AS table, COUNT(*) FROM pix_keys
UNION ALL
SELECT 'pix_txn_municipality', COUNT(*) FROM pix_txn_municipality;

-- Sample preview
SELECT * FROM pix_txn_municipality LIMIT 10;

-- Regional totals
SELECT
  region_name,
  SUM(payer_pf_value + payer_pj_value) AS total_sent_value
FROM pix_txn_municipality
GROUP BY region_name
ORDER BY total_sent_value DESC;

-- Done
SELECT 'Pix data successfully loaded!' AS status;
