/* 
Top Camera thumbnails check (anonymized)
Goal: detect products where a specific thumbnail/asset tag was incorrectly set as the main image.
*/

SELECT
  p.sku,
  p.product_id,
  CONCAT('https://<admin_or_catalog_url>/products/', p.product_id) AS product_link,
  a.asset_tag AS suspected_thumb_tag,
  p.created_at,
  p.updated_at
FROM catalog_products p
JOIN product_assets a
  ON a.product_id = p.product_id
WHERE p.is_active = TRUE
  AND (
    a.asset_tag ILIKE '%redminote13%' OR
    a.asset_tag ILIKE '%v3%' OR
    a.asset_tag ILIKE '%top_camera%'
  )
ORDER BY p.updated_at DESC;
