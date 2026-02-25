-- Pix Open Data Project - Analytical queries (PostgreSQL)

SET search_path TO pix;

-- 1) Regional totals (payer + receiver) by month
SELECT
  yyyymm,
  region_code,
  region_name,
  SUM(payer_pf_value + payer_pj_value)     AS total_sent_value,
  SUM(receiver_pf_value + receiver_pj_value) AS total_received_value,
  SUM(payer_pf_count + payer_pj_count)     AS total_sent_txn,
  SUM(receiver_pf_count + receiver_pj_count) AS total_received_txn
FROM pix_txn_municipality
GROUP BY yyyymm, region_code, region_name
ORDER BY yyyymm DESC, total_sent_value DESC;


-- 2) PF vs PJ share by region (sent value) for a given month
-- Replace 202412 with your target month
SELECT
  region_code,
  region_name,
  SUM(payer_pf_value) AS pf_sent_value,
  SUM(payer_pj_value) AS pj_sent_value,
  ROUND(
    (SUM(payer_pf_value) / NULLIF(SUM(payer_pf_value + payer_pj_value), 0)) * 100, 2
  ) AS pf_sent_share_pct,
  ROUND(
    (SUM(payer_pj_value) / NULLIF(SUM(payer_pf_value + payer_pj_value), 0)) * 100, 2
  ) AS pj_sent_share_pct
FROM pix_txn_municipality
WHERE yyyymm = 202412
GROUP BY region_code, region_name
ORDER BY (pf_sent_value + pj_sent_value) DESC;


-- 3) Top municipalities by total Pix value (sent) in a month
SELECT
  yyyymm,
  state_name,
  municipality_name,
  (payer_pf_value + payer_pj_value) AS total_sent_value,
  (payer_pf_count + payer_pj_count) AS total_sent_txn
FROM pix_txn_municipality
WHERE yyyymm = 202412
ORDER BY total_sent_value DESC
LIMIT 20;


-- 4) "Per user" intensity: value per distinct payer (PF)
-- Useful to compare adoption intensity, not just raw volume
SELECT
  yyyymm,
  region_name,
  ROUND(
    SUM(payer_pf_value) / NULLIF(SUM(payer_pf_people), 0),
    2
  ) AS pf_value_per_distinct_payer
FROM pix_txn_municipality
WHERE yyyymm = 202412
GROUP BY yyyymm, region_name
ORDER BY pf_value_per_distinct_payer DESC;


-- 5) Net flow proxy by municipality (received - sent)
-- Note: not perfect net flow (system-level), but useful as directional signal
SELECT
  yyyymm,
  state_name,
  municipality_name,
  (receiver_pf_value + receiver_pj_value) - (payer_pf_value + payer_pj_value) AS net_value_proxy
FROM pix_txn_municipality
WHERE yyyymm = 202412
ORDER BY net_value_proxy DESC
LIMIT 20;


-- 6) Institutions: keys distribution by type and user nature (PF/PJ)
-- Replace ref_date if you have multiple snapshots
SELECT
  ref_date,
  user_nature,
  key_type,
  SUM(key_count) AS total_keys
FROM pix_keys
GROUP BY ref_date, user_nature, key_type
ORDER BY ref_date DESC, user_nature, total_keys DESC;


-- 7) Top institutions by number of keys (PF) on a date
SELECT
  ref_date,
  ispb,
  institution_name,
  SUM(key_count) AS total_pf_keys
FROM pix_keys
WHERE user_nature = 'PF'
  AND ref_date = (SELECT MAX(ref_date) FROM pix_keys)
GROUP BY ref_date, ispb, institution_name
ORDER BY total_pf_keys DESC
LIMIT 20;


-- 8) Key type mix by institution (PF) for latest date
SELECT
  ref_date,
  institution_name,
  key_type,
  SUM(key_count) AS pf_keys
FROM pix_keys
WHERE user_nature = 'PF'
  AND ref_date = (SELECT MAX(ref_date) FROM pix_keys)
GROUP BY ref_date, institution_name, key_type
ORDER BY pf_keys DESC;


-- 9) Quality checks (good for "data quality mindset")
-- 9.1) Any negative values? (should return 0 rows)
SELECT *
FROM pix_txn_municipality
WHERE payer_pf_value < 0 OR payer_pj_value < 0
   OR receiver_pf_value < 0 OR receiver_pj_value < 0
   OR payer_pf_count < 0 OR payer_pj_count < 0
   OR receiver_pf_count < 0 OR receiver_pj_count < 0
LIMIT 10;

-- 9.2) Check region code consistency (should match expected set)
SELECT DISTINCT region_code, region_name
FROM pix_txn_municipality
ORDER BY region_code;
