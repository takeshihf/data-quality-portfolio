/*
Licensed products missing license assignment (anonymized)
Goal: detect products that look like licensed items (based on naming/tags/rules)
but do not have a license_id filled, which can impact revenue share / compliance.
*/

WITH candidate_licensed AS (
  SELECT
    p.product_id,
    p.sku,
    p.product_name,
    p.created_at,
    p.license_id
  FROM catalog_products p
  WHERE p.is_active = TRUE
    AND (
      p.product_name ILIKE '%disney%' OR
      p.product_name ILIKE '%minecraft%' OR
      p.product_name ILIKE '%naruto%' OR
      p.product_name ILIKE '%pokemon%'
      -- add other brand keywords as generic examples
    )
)
SELECT
  product_id,
  sku,
  product_name,
  created_at,
  license_id
FROM candidate_licensed
WHERE license_id IS NULL
ORDER BY created_at DESC;
