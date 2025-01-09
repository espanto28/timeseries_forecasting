CREATE OR REPLACE MODEL `a-better-mistake-2021.aster_uat.xgboost_regressor_quantity`
OPTIONS(
  model_type = 'BOOSTED_TREE_REGRESSOR',
  BOOSTER_TYPE = 'GBTREE',
  num_trials = 10,  -- Number of trials for random search
  max_iterations = 100,  -- Maximum number of boosting iterations
  early_stop = TRUE,  -- Enable early stopping
  input_label_cols = ['quantity'],  -- Replace with your target column
  # Define the hyperparameter search space
  HPARAM_TUNING_ALGORITHM = 'VIZIER_DEFAULT' 
) AS
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