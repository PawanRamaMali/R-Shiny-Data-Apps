# global.R


# LIBRARIES ----

# Shiny
library(shiny)
library(bslib)

# Modeling
library(modeldata)
library(DataExplorer)

# Widgets
library(plotly)

# Core
library(tidyverse)
#if (!require("DT")) install.packages('DT')
library(DT)

library(ggplot2)

library(rmarkdown)
library(knitr)
library(pander)


# LOAD DATASETS ----
utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list = list(
  "StackOverflow" = stackoverflow,
  "Car Prices"    = car_prices,
  "Sacramento Housing" = Sacramento
)