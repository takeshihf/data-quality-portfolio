/*
Duplicate SKU check (anonymized)
Goal: detect duplicated SKUs, which commonly causes listing/caching/fulfillment problems.
*/

SELECT
  sku,
  COUNT(*) AS sku_count
FROM catalog_products
WHERE sku IS NOT NULL AND sku <> ''
GROUP BY sku
HAVING COUNT(*) > 1
ORDER BY sku_count DESC, sku;
