# global.R

rm(list=ls())

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

library(shiny)
library(shinydashboard)
library(shinyAce)
library(shinyWidgets)
library(data.table)
library(esquisse)
library(rvg)
library(magrittr)


## Setting Upload Size to 1GB
options(shiny.maxRequestSize = 1000000000)
options("esquisse.display.mode" = "browser")

# LOAD DATASETS ----
utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list = list(
  "StackOverflow" = stackoverflow,
  "Car Prices"    = car_prices,
  "Sacramento Housing" = Sacramento
)