WITH
  blended_predictions AS (
  SELECT
    date,
    item_id,
    store_id,
    regression_preds,
    upper_forecast,
    avg_forecast,
    lower_forecast,
    blended_avg_forecast,
    blended_lower_forecast,
    blended_upper_forecast
  FROM
    `a-better-mistake-2021.aster_uat.blended_predictions`
)
,
blended_model_prep_data as (
SELECT
  date,
  ROUND(SUM(regression_preds), 0) AS regression_preds,
  ROUND(SUM(upper_forecast), 0) AS upper_forecast,
  ROUND(SUM(avg_forecast), 0) AS avg_forecast,
  ROUND(SUM(lower_forecast), 0) AS lower_forecast,
  ROUND(SUM(blended_avg_forecast), 0) AS blended_avg_forecast,
  ROUND(SUM(blended_lower_forecast), 0) AS blended_lower_forecast,
  ROUND(SUM(blended_upper_forecast), 0) AS blended_upper_forecast
FROM
  blended_predictions
GROUP BY
  date)
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
date,
real_quantity,
regression_preds,
upper_forecast,
avg_forecast,
lower_forecast,
blended_avg_forecast,
blended_lower_forecast,
blended_upper_forecast
FROM blended_model_prep_data
JOIN evaluation_data
USING(date)
ORDER BY DATE ASC

