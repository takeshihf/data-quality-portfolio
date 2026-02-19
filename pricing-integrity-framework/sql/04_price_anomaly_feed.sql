/*
Price anomaly monitoring feed (anonymized)

Goal:
Generate a lightweight anomaly feed that can be used
by alerting systems (e.g., bots, Slack, n8n workflows).
*/

SELECT
  p.product_id,
  p.sku,
  p.name,
  pr.current_price,
  pr.expected_price,
  NOW() AS detected_at
FROM catalog_products_snapshot p
JOIN pricing_reference pr
  ON pr.product_id = p.product_id
WHERE p.is_active = TRUE
  AND ABS(pr.current_price - pr.expected_price) >= 5
ORDER BY detected_at DESC;
