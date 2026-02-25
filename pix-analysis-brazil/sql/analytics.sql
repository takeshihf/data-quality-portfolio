SELECT region, SUM(transactions) AS total_volume
FROM pix_transactions
GROUP BY region
ORDER BY total_volume DESC;
