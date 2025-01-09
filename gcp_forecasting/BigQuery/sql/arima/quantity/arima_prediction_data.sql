WITH
  forecast_data AS (
  SELECT
    #date,
    SAFE_CAST(DATE(CAST(date AS date))AS string) AS date,
    store_id,
    item_id,
    ROUND(SUM(upper_forecast),1) AS upper_forecast,
    ROUND(SUM(avg_forecast_value),1) AS avg_forecast,
    ROUND(SUM(lower_forecast),1) AS lower_forecast
  FROM (
    SELECT
      forecast_timestamp AS date,
      item_id,
      store_id,
      ROUND(prediction_interval_upper_bound,2) AS upper_forecast,
      ROUND(forecast_value,2) AS avg_forecast_value,
      ROUND(prediction_interval_lower_bound,2) AS lower_forecast
    FROM
      ML.FORECAST(MODEL `a-better-mistake-2021.aster_uat.sku_store_quantity_20250104`,
        STRUCT(7 AS horizon,
          0.99 AS confidence_level))
    WHERE
      forecast_timestamp >= "2024-12-11"
      AND forecast_timestamp <= "2024-12-17"
    ORDER BY
      forecast_timestamp ASC)
  GROUP BY
    date,
    store_id,
    item_id
  ORDER BY
    date ASC)
SELECT
  forecast_data.date,
  store_id,
  item_id,
  upper_forecast,
  avg_forecast,
  lower_forecast
FROM
  forecast_data
GROUP BY
  forecast_data.date,
  store_id,
  item_id,
  upper_forecast,
  avg_forecast,
  lower_forecast
ORDER BY forecast_data.date asc