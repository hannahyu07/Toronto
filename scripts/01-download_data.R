#### Preamble ####
# Purpose: Downloads and saves the data from OpenData Toronto portal
# Author: Hannah Yu 
# Date: 17 January 2024  
# Contact: realhannah.yu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data ####

raw_homicide_data <-

  list_package_resources("7d72bbbe-8adc-4b36-8ad1-5359f1c7a9cc") |>
  filter(format == "CSV") |>
  head(1) |>
  get_resource()


#### Save data ####

write_csv(
  x = raw_homicide_data,
  file = "inputs/data/raw_homicide_data.csv"
)



