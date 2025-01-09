WITH forecast_data as (

SELECT
#date,
SAFE_CASt(DATE(cast(date as date))as string) as date,
ROUND(SUM(upper_forecast),1) as upper_forecast,
ROUND(SUM(avg_forecast_value),1) as avg_forecast,
ROUND(SUM(lower_forecast),1) as lower_forecast
FROM(
SELECT
  forecast_timestamp as date,
  item_id,
  store_id,
  round(prediction_interval_upper_bound,2) as upper_forecast,
  round(forecast_value,2) as avg_forecast_value,
  round(prediction_interval_lower_bound,2) as lower_forecast
FROM
  ML.FORECAST(MODEL `a-better-mistake-2021.aster_uat.sku_store_quantity_20250104`,
    STRUCT(7 AS horizon, 0.99 AS confidence_level))
WHERE forecast_timestamp >= "2024-12-11" and forecast_timestamp <= "2024-12-17"
ORDER BY forecast_timestamp asc)
GROUP BY date
ORDER BY date ASC)
,
evaluation_data as (
SELECT
SAFE_CAST(date as string) as date,
SUM(quantity) as real_quantity
FROM
  `a-better-mistake-2021.aster_uat.sku_arima_evaluation_data`
GROUP BY
date
ORDER BY date 
asc
)

SELECT
forecast_data.date,
real_quantity,
upper_forecast,
avg_forecast,
lower_forecast
FROM forecast_data 
JOIN evaluation_data
USING(date)
ORDER BY date asc