WITH regression_predictions as (SELECT
  SAFE_CAST(date as string) as date,
  item_id,
  store_id,
  predicted_quantity as regression_preds
FROM
  `a-better-mistake-2021.aster_uat.sku_regression_quantity_prediction_data`)
,
arima_predictions as (
SELECT
  SAFE_CAST(date as string) as date,
  store_id,
  item_id,
  upper_forecast,
  avg_forecast,
  lower_forecast
FROM
  `a-better-mistake-2021.aster_uat.sku_arima_regression_quantity_prediction_data`
GROUP BY
  date,
  store_id,
  item_id,
  upper_forecast,
  avg_forecast,
  lower_forecast
ORDER BY DATE asc
)
,
blended_data_prep_1 as (
SELECT
date,
item_id,
store_id,
regression_preds,
upper_forecast,
avg_forecast,
lower_forecast,
#Blended approach
(regression_preds + upper_forecast) / 2 as blended_upper_forecast,
(regression_preds + lower_forecast) / 2 as blended_lower_forecast,
(regression_preds + avg_forecast) / 2 as blended_avg_forecast,
FROM regression_predictions
JOIN arima_predictions
USING(date,item_id,store_id)
ORDER BY date asc)

SELECT
*
FROM(
SELECT
date,
item_id,
store_id,
regression_preds,
upper_forecast,
avg_forecast,
lower_forecast,
blended_data_prep_1.blended_avg_forecast,
blended_data_prep_1.blended_lower_forecast,
blended_data_prep_1.blended_upper_forecast
FROM blended_data_prep_1
order by date asc)
ORDER BY DATE asc