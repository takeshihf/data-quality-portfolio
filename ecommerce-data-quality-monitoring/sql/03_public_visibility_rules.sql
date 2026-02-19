/*
Public visibility rules check (anonymized)

Goal:
Find products that are active but should not be publicly visible due to business rules,
e.g., B2B-only items, missing required attributes, or flagged items.

Replace fields with equivalents from your environment.
*/

SELECT
  product_id,
  sku,
  slug,
  name,
  is_active,
  is_b2b_only,
  is_publicly_visible,
  updated_at
FROM catalog_products_snapshot
WHERE is_active = TRUE
  AND (
    (is_b2b_only = TRUE AND is_publicly_visible = TRUE)
    OR (is_publicly_visible IS NULL)
  )
ORDER BY updated_at DESC;
