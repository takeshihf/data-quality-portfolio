/*
Completeness checks (anonymized)
Goal: quantify missing critical fields for catalog reliability.
*/

SELECT
  COUNT(*) AS total_active_products,
  SUM(CASE WHEN sku IS NULL OR sku = '' THEN 1 ELSE 0 END) AS missing_sku,
  SUM(CASE WHEN slug IS NULL OR slug = '' THEN 1 ELSE 0 END) AS missing_slug,
  SUM(CASE WHEN name IS NULL OR name = '' THEN 1 ELSE 0 END) AS missing_name
FROM catalog_products
WHERE is_active = TRUE;
