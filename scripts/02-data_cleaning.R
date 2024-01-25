#### Preamble ####
# Purpose: Cleans the raw homicide data and select relevant columns. 
# Author: Hannah Yu
# Date: 19 January 2023  
# Contact: realhannah.yu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 01-download_data.R


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)
library(readr)
library(stringr)

#### Clean data ####
raw_data <- read_csv("inputs/data/raw_homicide_data.csv")

#### basic cleaning ####

# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
raw_homicide_data <-
  read_csv(
    file = "inputs/data/raw_homicide_data.csv",
    show_col_type = FALSE
  )

# Make the names easier to type 
cleaned_homicide_data <-
  clean_names(raw_homicide_data)

# Have a look at the first six rows
head(cleaned_homicide_data)


# select columns of interest #
cleaned_homicide_data <-
  cleaned_homicide_data |>
  select(
    occurrence_year, 
    homicide_type,
    occurrence_date,
    hood_id
  )


# find the day of the week of the homicide and determine if it is a weekend #
cleaned_homicide_data <-
  cleaned_homicide_data |>
  mutate(day_of_week = weekdays(occurrence_date))
                        
# find the season when the homicide occurred #
cleaned_homicide_data <-
  cleaned_homicide_data |>
  mutate(season = case_when(
           between(lubridate::month(occurrence_date), 3, 5) ~ "Spring",
           between(lubridate::month(occurrence_date), 6, 8) ~ "Summer",
           between(lubridate::month(occurrence_date), 9, 11) ~ "Fall",
           TRUE ~ "Winter")
  )

# Extract only the date part (YYYY-MM-DD) from the date variable #

cleaned_homicide_data$occurrence_date <- 
  str_sub(cleaned_homicide_data$occurrence_date, 1, 10)


# Count the occurrence of homicides every year #
 cleaned_homicide_data <- 
    cleaned_homicide_data |>
    group_by(occurrence_year)|>
    mutate(homicide_count = n())
  head(cleaned_homicide_data)


#### Save data ####
write_csv(
  x = cleaned_homicide_data,
  file = "inputs/data/cleaned_homicide_data.csv"
)

write_csv(cleaned_homicide_data, "outputs/data/analysis_data.csv")



