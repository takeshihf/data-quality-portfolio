-- Pix Open Data Project - Relational schema (PostgreSQL)

BEGIN;

CREATE SCHEMA IF NOT EXISTS pix;
SET search_path TO pix;

CREATE TABLE IF NOT EXISTS pix_keys (
  ref_date          DATE        NOT NULL,
  ispb              BIGINT      NOT NULL,
  institution_name  TEXT        NOT NULL,
  user_nature       VARCHAR(2)  NOT NULL CHECK (user_nature IN ('PF','PJ')),
  key_type          TEXT        NOT NULL,
  key_count         BIGINT      NOT NULL CHECK (key_count >= 0),

  CONSTRAINT pk_pix_keys PRIMARY KEY (ref_date, ispb, user_nature, key_type)
);

CREATE INDEX IF NOT EXISTS idx_pix_keys_institution ON pix_keys (ispb);
CREATE INDEX IF NOT EXISTS idx_pix_keys_ref_date ON pix_keys (ref_date);
CREATE INDEX IF NOT EXISTS idx_pix_keys_user_nature ON pix_keys (user_nature);


CREATE TABLE IF NOT EXISTS pix_txn_municipality (
  date              INTEGER     NOT NULL CHECK (yyyymm BETWEEN 200001 AND 210012),
  municipality_ibge    INTEGER     NOT NULL,
  municipality_name    TEXT        NOT NULL,
  state_ibge           INTEGER     NOT NULL,
  state_name           TEXT        NOT NULL,
  region_code          VARCHAR(2)  NOT NULL,
  region_name          TEXT        NOT NULL,

  payer_pf_value       NUMERIC(20,2) NOT NULL CHECK (payer_pf_value >= 0),
  payer_pf_count       BIGINT        NOT NULL CHECK (payer_pf_count >= 0),
  payer_pj_value       NUMERIC(20,2) NOT NULL CHECK (payer_pj_value >= 0),
  payer_pj_count       BIGINT        NOT NULL CHECK (payer_pj_count >= 0),

  receiver_pf_value    NUMERIC(20,2) NOT NULL CHECK (receiver_pf_value >= 0),
  receiver_pf_count    BIGINT        NOT NULL CHECK (receiver_pf_count >= 0),
  receiver_pj_value    NUMERIC(20,2) NOT NULL CHECK (receiver_pj_value >= 0),
  receiver_pj_count    BIGINT        NOT NULL CHECK (receiver_pj_count >= 0),

  payer_pf_people      BIGINT        NOT NULL CHECK (payer_pf_people >= 0),
  payer_pj_people      BIGINT        NOT NULL CHECK (payer_pj_people >= 0),
  receiver_pf_people   BIGINT        NOT NULL CHECK (receiver_pf_people >= 0),
  receiver_pj_people   BIGINT        NOT NULL CHECK (receiver_pj_people >= 0),

  CONSTRAINT pk_pix_txn_municipality PRIMARY KEY (yyyymm, municipality_ibge)
);

CREATE INDEX IF NOT EXISTS idx_pix_txn_region_month ON pix_txn_municipality (region_code, yyyymm);
CREATE INDEX IF NOT EXISTS idx_pix_txn_state_month  ON pix_txn_municipality (state_ibge, yyyymm);
CREATE INDEX IF NOT EXISTS idx_pix_txn_month        ON pix_txn_municipality (yyyymm);
CREATE INDEX IF NOT EXISTS idx_pix_txn_municipality ON pix_txn_municipality (municipality_ibge);

CREATE OR REPLACE VIEW v_pix_txn_municipality AS
SELECT
  t.*,
  to_date(t.date::text || '01', 'YYYYMMDD') AS month_start
FROM pix_txn_municipality t;

COMMIT
