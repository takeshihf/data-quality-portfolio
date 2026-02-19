## Example SQL (Anonymized)

> The SQL below was adapted and anonymized from real production work.  
> No proprietary data, identifiers, or internal table names are included.

### 1) Catalog completeness checks
```sql
WITH catalog AS (
  SELECT
    p.product_id,
    p.sku,
    p.product_name,
    p.license_id,
    pr.price_amount,
    p.is_active
  FROM catalog_products p
  LEFT JOIN catalog_prices pr
    ON pr.product_id = p.product_id
)
SELECT
  COUNT(*) AS total_products,
  SUM(CASE WHEN sku IS NULL OR sku = '' THEN 1 ELSE 0 END) AS missing_sku,
  SUM(CASE WHEN license_id IS NULL THEN 1 ELSE 0 END) AS missing_license,
  SUM(CASE WHEN price_amount IS NULL THEN 1 ELSE 0 END) AS missing_price
FROM catalog
WHERE is_active = TRUE;
