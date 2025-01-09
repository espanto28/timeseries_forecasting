SELECT
  date,
  deliveryType,
  item_id,
  store_id,
  item_discount,
  quantity
FROM
  `aster-uat.sales_forecast_project.sales_2`
WHERE date > "2024-01-01" and date <= "2024-12-10" and store_id is not null and item_id in (
SELECT
item_id
FROM (
  SELECT
  item_id,
  SUM(quantity) as quantity
FROM
  `aster-uat.sales_forecast_project.sales_2`
WHERE date > "2024-01-01" and date <= "2024-12-10" and store_id is not null
GROUP BY
item_id)
WHERE quantity > 365
)
GROUP BY
  date,
  deliveryType,
  item_id,
  store_id,
  item_discount,
  quantity
ORDER BY date asc