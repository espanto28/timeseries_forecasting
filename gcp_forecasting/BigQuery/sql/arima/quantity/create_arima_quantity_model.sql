CREATE OR REPLACE MODEL `a-better-mistake-2021.aster_uat.sku_store_quantity_20250104` 
OPTIONS (
  model_type='ARIMA_PLUS',
  time_series_timestamp_col='date', 
  time_series_data_col='quantity',
  HOLIDAY_REGION='AE',
  TIME_SERIES_ID_COL = ["item_id","store_id"],
  horizon = 7, -- Adjust as needed
  auto_arima = TRUE,  
  data_frequency = 'AUTO_FREQUENCY' -- Or specify 'HOURLY', 'DAILY', etc.
) AS (
SELECT
  date,
  item_id,
  store_id,
  quantity
FROM
  `a-better-mistake-2021.aster_uat.aster_quantity_raw_data`
ORDER BY date asc
)