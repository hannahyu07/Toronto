#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Hannah Yu [...UPDATE THIS...]
# Date: 17 January 2024 [...UPDATE THIS...]
# Contact: realhannah.yu@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
# [...UPDATE THIS...]

#### Download data ####
# [...ADD CODE HERE TO DOWNLOAD...]

raw_homicide_data <-

  list_package_resources("7d72bbbe-8adc-4b36-8ad1-5359f1c7a9cc") |>
  filter(format == "CSV") |>
  head(1) |>
  get_resource()


#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
#write_csv(the_raw_data, "inputs/data/raw_data.csv") 

write_csv(
  x = raw_homicide_data,
  file = "inputs/data/raw_homicide_data.csv"
)



