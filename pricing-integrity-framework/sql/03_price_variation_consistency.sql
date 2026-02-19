/*
Price consistency across variations (anonymized)

Goal:
Detect products where price varies inconsistently across variations
(e.g., color-based variants with unexpected price spreads).
*/

SELECT
  v.parent_product_id,
  COUNT(*) AS variation_count,
  MIN(v.price_amount) AS min_price,
  MAX(v.price_amount) AS max_price,
  (MAX(v.price_amount) - MIN(v.price_amount)) AS price_spread
FROM product_variants v
JOIN catalog_products_snapshot p
  ON p.product_id = v.parent_product_id
WHERE p.is_active = TRUE
GROUP BY v.parent_product_id
HAVING (MAX(v.price_amount) - MIN(v.price_amount)) >= 10
ORDER BY price_spread DESC;
