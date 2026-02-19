/*
Catalog mismatch between core table and enriched/snapshot layer (anonymized)

Goal:
Detect products that exist in the core products table but are missing in the monitoring layer,
or products with mismatched key fields (e.g., slug/name/status).

Why it matters:
These mismatches typically break dashboards, monitoring checks, and storefront consistency.
*/

WITH core AS (
  SELECT
    product_id,
    sku,
    slug,
    name,
    is_active,
    updated_at
  FROM catalog_products
),
snap AS (
  SELECT
    product_id,
    sku,
    slug,
    name,
    is_active,
    updated_at
  FROM catalog_products_snapshot
)
SELECT
  c.product_id,
  c.sku,
  c.slug,
  c.name,
  c.is_active,
  c.updated_at,
  CASE
    WHEN s.product_id IS NULL THEN 'MISSING_IN_SNAPSHOT_LAYER'
    WHEN c.slug <> s.slug THEN 'SLUG_MISMATCH'
    WHEN c.is_active <> s.is_active THEN 'STATUS_MISMATCH'
    ELSE 'OTHER_MISMATCH'
  END AS issue_type
FROM core c
LEFT JOIN snap s
  ON s.product_id = c.product_id
WHERE s.product_id IS NULL
   OR c.slug <> s.slug
   OR c.is_active <> s.is_active
ORDER BY c.updated_at DESC;
