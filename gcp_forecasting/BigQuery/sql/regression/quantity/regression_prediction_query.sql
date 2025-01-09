SELECT
  date,
  item_id,
  store_id,
  ROUND(predicted_quantity,0)  as predicted_quantity
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
          item_discount
          #quantity
        FROM
          `a-better-mistake-2021.aster_uat.sku_arima_evaluation_data`
          ORDER BY date ASC
    )
  )
ORDER BY DATE asc