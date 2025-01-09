# timeseries_forecasting
Time series forecasting solutions

This notebook will compare a few different forecasting solutions and have a few notebooks for experimentation.

This notebook also shows how to build a blended ARIMA_PLUS_XREG model with BigQuery ML after January 4, 2025

## SARIMA

We will use AutoRegressive Intergrated Seasonal Moving Average with a seasonal component. 

This type of model performs better than a normal ARIMA model when it has to deal with seasonality. 

The main channel with this model is identifying the parameters. 


## Facebook Prophet's Library

Facebook built a forecasting library called Prophet. It is located here: https://facebook.github.io/prophet/. 

This library is pretty easy to use and quick to implement. 


## Recurrent Neural Nets with Tensorflow

This is a Recurrent Neural Net using a time series generator on Tensorflow. 

It is pretty good for identiying a sequences of steps. 

## Convolutional Neural Net with Tensorflow

This is a Convolutional Neural Net with 2 layers and it does a pretty good job with unknowns or anomalies. 

## GCP Forecasting Folder

This folder shows how to build forecasting models using XGboost and ARIMA+ via BigQuery ML. And it also shows how you can build a blended model approach. 




