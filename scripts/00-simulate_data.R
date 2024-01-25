#### Preamble ####
# Purpose: Simulates Homicide Data
# Author: Hannah Yu
# Date: 17 January 2024 
# Contact: realhannah.yu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None



#### Workspace setup ####
library(tidyverse)
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(ggplot2)


#### Simulate data ####

#### Data expectations ####
# The year, month, and day variables contain values within their specified ranges.
# The weekday variable only include the days of the week from Monday to Sunday.
# The homicide_type variable only include the following categories: "Shooting," "Stabbing," and "Other." 
# The neighborhood_number variable include integers ranging from 1 to 140.
# Columns: year, month, day, weekday, homicide_type, neighborhood_number

#### Simulate Toronto Homicide Data ####
#based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate

set.seed(853)

num_obs <- 1398

simulated_data <- 
  tibble(
    year = sample(2004:2020, num_obs, replace = TRUE),
    #month = sample(1:12, num_obs, replace = TRUE),
    #day = sample(1:31, num_obs, replace = TRUE),
    weekday = sample(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                       "Friday", "Saturday"), num_obs, replace = TRUE),
    homicide_type = sample(c("Shooting", "Stabbing", "Other"),  num_obs,
                           replace = TRUE),
    neighborhood_number = sample(1:140, num_obs, replace = TRUE),
)

simulated_data <- 
  tibble(
    year = sample(2004:2020, num_obs, replace = TRUE),
    weekday = sample(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                       "Friday", "Saturday"), num_obs, replace = TRUE),
    homicide_type = sample(c("Shooting", "Stabbing", "Other"),  num_obs,
                           replace = TRUE),
    neighborhood_number = sample(1:140, num_obs, replace = TRUE),
  )

# Create a date column using lubridate
simulated_data <-
  simulated_data |>
  mutate(month = sample(1:12, num_obs, replace = TRUE),
         day = sample(1:31, num_obs, replace = TRUE),
         date = make_date(year, month, day))


# Print the first few rows of the tibble
print(simulated_data)


#Bar Plot for Homicide Type


ggplot(simulated_data, aes(x = homicide_type, fill = homicide_type)) +
  geom_bar() +
  labs(title = "Distribution of Homicide Types", x = "Homicide Type",
       y = "Count") +
  theme_minimal()

#Histogram for Neighborhood Number

ggplot(simulated_data, aes(x = neighborhood_number)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Distribution of Neighborhood Numbers", x = "Neighborhood 
       Number", y = "Frequency")

# Check the year of homicide occurrence is between 2004-2023

simulated_data$year |> min() == 2004
simulated_data$year |> max() == 2020

# Check the day of homicide occurrence is between 1-31

simulated_data$day |> min() == 1
simulated_data$day |> max() == 31

# Check the neighborhood number is between 1-140

simulated_data$neighborhood_number |> min() == 1
simulated_data$neighborhood_number |> max() == 140

# Check homicide type is character 

simulated_data$homicide_type |> class() == "character"