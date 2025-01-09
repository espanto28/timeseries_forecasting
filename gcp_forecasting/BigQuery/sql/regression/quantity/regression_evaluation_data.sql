SELECT
DATE as date,
SUM(predicted_quantity) as predicted_quantity,
SUM(real_quantity) as real_quantity
FROM(
SELECT
  date,
  item_id,
  store_id,
  ROUND(predicted_quantity,0)  as predicted_quantity,
  quantity as real_quantity
FROM
  ML.PREDICT(
    MODEL `a-better-mistake-2021.aster_uat.xgboost_regressor_quantity`,
    (
        SELECT
          date,
          EXTRACT(DAYOFWEEK FROM date) as day_of_week, #0 is sunday
          deliveryType as delivery_type,
          item_id,
          store_id,
          item_discount,
          quantity
        FROM
          `a-better-mistake-2021.aster_uat.sku_arima_evaluation_data`
          ORDER BY date ASC
    )
  )
)
GROUP BY DATE
ORDER BY DATE ASC