/*
Material pricing audit (anonymized)

Goal:
Validate consistency of pricing across product material categories.

Originally used in dashboards:
- Textile pricing checks
- Thermal pricing checks
*/

SELECT
  material_type,
  COUNT(*) AS product_count,
  MIN(current_price) AS min_price,
  MAX(current_price) AS max_price,
  AVG(current_price) AS avg_price
FROM catalog_products_snapshot
WHERE is_active = TRUE
GROUP BY material_type
ORDER BY material_type;
