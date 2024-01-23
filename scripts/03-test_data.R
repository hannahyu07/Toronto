#### Preamble ####
# Purpose: Tests cleaned data
# Author: Hannah Yu
# Date: 23 January 2024 
# Contact: realhannah.yu@mail.utoronto.ca  
# License: MIT
# Pre-requisites: 02-data_cleaning.R
 

#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Check the year of homicide occurrence is between 2004-2020

cleaned_homicide_data$occurrence_year |> min() == 2004
cleaned_homicide_data$occurrence_year |> max()== 2020


# Check the neighborhood number is between 1-140

cleaned_homicide_data$hood_id |> min() == 1
cleaned_homicide_data$hood_id |> max() == 140

# Check homicide type is character 

cleaned_homicide_data$homicide_type |> class() == "character"
