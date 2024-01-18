#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Hannah Yu [...UPDATE THIS...]
# Date: 17 January 2024 [...UPDATE THIS...]
# Contact: realhannah.yu@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)

#### Simulate data ####

#### Data expectations ####
# There are a similar number of subdivisions per ward
# Voter turnout varies by ward
# Wards with more subdivisions will have a higher turnout

#### Simulate voter turnout by ward ####
#based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate

set.seed(853)

num_obs <- 1398

simulated_data <- 
  tibble(
    year = sample(2004:2023, num_obs, replace = TRUE),
    month = sample(1:12, num_obs, replace = TRUE),
    day = sample(1:31, num_obs, replace = TRUE),
    weekday = sample(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                       "Friday", "Saturday"), num_obs, replace = TRUE),
    homicide_type = sample(c("Shooting", "Stabbing", "Other"),  num_obs,
                           replace = TRUE),
    neighborhood_number = sample(1:158, num_obs, replace = TRUE),
)



# Print the first few rows of the tibble
print(simulated_data)


#Bar Plot for Homicide Type
library(ggplot2)


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
simulated_data$year |> max() == 2023

# Check the day of homicide occurrence is between 1-31

simulated_data$day |> min() == 1
simulated_data$day |> max() == 31

# Check the neighborhood number is between 1-158

simulated_data$neighborhood_number |> min() == 1
simulated_data$neighborhood_number |> max() == 158

# Check homicide type is character 

simulated_data$homicide_type |> class() == "character"