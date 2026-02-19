/*
Price divergence detection (anonymized)

Goal:
Detect products where the current storefront price diverges
from the expected pricing logic (e.g., material-based pricing rules).

Context:
Originally used to detect pricing issues across product materials
(e.g., textile vs thermal categories).
*/

WITH base AS (
  SELECT
    p.product_id,
    p.sku,
    p.name,
    p.material_type,
    pr.current_price,
    pr.expected_price
  FROM catalog_products_snapshot p
  JOIN pricing_reference pr
    ON pr.product_id = p.product_id
  WHERE p.is_active = TRUE
)
SELECT
  product_id,
  sku,
  name,
  material_type,
  current_price,
  expected_price,
  (current_price - expected_price) AS price_diff
FROM base
WHERE ABS(current_price - expected_price) >= 5 -- tolerance threshold
ORDER BY ABS(price_diff) DESC;
