/*
B2B products visible on the public site (anonymized)
Goal: find B2B/wholesale products that should not be publicly available.
*/

SELECT
  p.product_id,
  p.sku,
  p.product_name,
  p.is_active,
  p.is_wholesale,
  p.is_blocklisted_public,
  CONCAT('https://<store_url>/products/', p.slug) AS public_link,
  p.created_at
FROM catalog_products p
WHERE p.is_active = TRUE
  AND p.is_wholesale = TRUE
  AND (p.is_blocklisted_public = FALSE OR p.is_blocklisted_public IS NULL)
ORDER BY p.created_at DESC;
