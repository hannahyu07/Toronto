#### Preamble ####
# Purpose: Cleans the raw homicide data by and selecting relevant columns. 
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
    division,
    homicide_type,
    occurrence_date,
    hood_id
  )


# find the day of the week of the homicide and determine if it is a weekend #
cleaned_homicide_data <-
  cleaned_homicide_data |>
  mutate(day_of_week = weekdays(occurrence_date),
         weekend = ifelse(day_of_week %in% c("Saturday", "Sunday"), TRUE,
                          FALSE))
                        
# find the season when the homicide occurred #
cleaned_homicide_data <-
  cleaned_homicide_data |>
  mutate(season = case_when(
           between(lubridate::month(occurrence_date), 3, 5) ~ "Spring",
           between(lubridate::month(occurrence_date), 6, 8) ~ "Summer",
           between(lubridate::month(occurrence_date), 9, 11) ~ "Fall",
           TRUE ~ "Winter")
  )

# Count the occurrence of homicides by year #
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


# cleaned_data <-
#   raw_data |>
#   janitor::clean_names() |>
#   select(wing_width_mm, wing_length_mm, flying_time_sec_first_timer) |>
#   filter(wing_width_mm != "caw") |>
#   mutate(
#     flying_time_sec_first_timer = if_else(flying_time_sec_first_timer == "1,35",
#                                    "1.35",
#                                    flying_time_sec_first_timer)
#   ) |>
#   mutate(wing_width_mm = if_else(wing_width_mm == "490",
#                                  "49",
#                                  wing_width_mm)) |>
#   mutate(wing_width_mm = if_else(wing_width_mm == "6",
#                                  "60",
#                                  wing_width_mm)) |>
#   mutate(
#     wing_width_mm = as.numeric(wing_width_mm),
#     wing_length_mm = as.numeric(wing_length_mm),
#     flying_time_sec_first_timer = as.numeric(flying_time_sec_first_timer)
#   ) |>
#   rename(flying_time = flying_time_sec_first_timer,
#          width = wing_width_mm,
#          length = wing_length_mm
#          ) |> 
#   tidyr::drop_na()
# 
# #### Save data ####
# write_csv(cleaned_data, "outputs/data/analysis_data.csv")
