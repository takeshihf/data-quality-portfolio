/*
Recent "case" products missing expected tags/taxonomy (anonymized)
Goal: list recent products in a category (e.g., phone cases) that are missing expected tags, 
or contain disallowed tags, causing them to not appear in the correct storefront pages.
*/

SELECT
  p.product_id,
  p.sku,
  p.product_name,
  p.created_at,
  ARRAY_AGG(t.tag_name) AS tags
FROM catalog_products p
LEFT JOIN product_tags pt
  ON pt.product_id = p.product_id
LEFT JOIN tags t
  ON t.tag_id = pt.tag_id
WHERE p.is_active = TRUE
  AND p.category = 'case'
  AND p.created_at >= CURRENT_DATE - INTERVAL '365 days'
GROUP BY 1,2,3,4
HAVING
  -- missing expected tags
  SUM(CASE WHEN t.tag_name ILIKE '%case%' THEN 1 ELSE 0 END) = 0
  OR
  -- contains disallowed/legacy tags that break placement
  SUM(CASE WHEN t.tag_name ILIKE '%legacy%' OR t.tag_name ILIKE '%deprecated%' THEN 1 ELSE 0 END) > 0
ORDER BY p.created_at DESC;
