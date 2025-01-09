SELECT
date,
EXTRACT(DAYOFWEEK FROM date) as day_of_week, #0 is sunday
deliveryType as delivery_type,
item_id,
store_id,
item_discount,
quantity
FROM
  `a-better-mistake-2021.aster_uat.aster_quantity_raw_data`
ORDER BY date
ASC