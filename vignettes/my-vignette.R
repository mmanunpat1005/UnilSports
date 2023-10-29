## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(tibble.print_min = 4L, tibble.print_max = 4L)
library(rvest)
library(tidyverse)
library(lubridate)
library(dplyr)
library(lpSolve)
library(data.table)
library(rlang)
library(plotly)
library(ggplot2)
library(shiny)
library(shinythemes)
library(bslib)
library(here)
library(UnilSports)

## -----------------------------------------------------------------------------
library(UnilSports)

## -----------------------------------------------------------------------------
# To load the data
UnilSports::sport_schedule


## -----------------------------------------------------------------------------
# To load the data
UnilSports::met_values


## -----------------------------------------------------------------------------
# To load the data
UnilSports::mapping

## -----------------------------------------------------------------------------
# To load the data
UnilSports::clean_sport_schedule %>% head(5)

## ----echo=TRUE----------------------------------------------------------------
# Create Sport Schedule dataset
sport_schedule <- webscrape_sports(days = 7)
head(sport_schedule,5) # Visualize the first 5 rows of the data frame

# or without the parameter
sport_schedule <- webscrape_sports()
head(sport_schedule,5) # Visualize the first 5 rows of the data frame

## ----echo=TRUE----------------------------------------------------------------
# Create MET values dataset
met_values <- webscrape_MET()
head(met_values,10) # Visualize the first 10 rows of the data frame

## ----echo=TRUE----------------------------------------------------------------
# Clean and Link the datasets
clean_sport_schedule <- get_cleanschedule_met(sport_schedule,met_values)
head(clean_sport_schedule,5) # Visualize the first 5 rows of the data frame

## ----echo=TRUE----------------------------------------------------------------
# Amount of calories you want to burn
calburn <- 500

# Date preference - keep the same format*
date <- c('2022-12-14')

# Sport activity of interest
# The activity has to appear on the date selected
activity <- c('Football / Pratique libre','Badminton / Tous niveaux',
              'Aquagym', 'Zumba', 'Pilates', 'Agrès', 
              'Salsa cubaine / Débutants')

# Your current weight(kg)
weight <- 50

# Time availability
time <- c('07:00 \u2013 19:00')

# 1 if you want different activities, 0 otherwise
flag_no_duplicate_activities <- 1

# Load the clean_sport_schedule from the package
clean_sport_schedule <- UnilSports::clean_sport_schedule

# Apply optimize_schedule() function
optimize_output <- optimize_schedule(clean_sport_schedule, date, activity, 
                                    time, calburn, weight,
                                    flag_no_duplicate_activities)
# Call function and see the results
head(optimize_output$table_result,10)

## ----echo=TRUE----------------------------------------------------------------
# Amount of calories you want to burn
calburn <- 500

# Date preference - keep the same format*
date <- c('2022-12-14')

# Sport activity of interest
# The activity has to appear on the date selected
activity <- c('Football / Pratique libre','Badminton / Tous niveaux',
              'Aquagym', 'Zumba', 'Pilates', 'Agrès', 
              'Salsa cubaine / Débutants')

# Your current weight(kg)
weight <- 50

# Time availability
time <- c('07:00 \u2013 19:00')

# 1 if you want different activities, 0 otherwise
flag_no_duplicate_activities <- 1

# Load the clean_sport_schedule from the package
clean_sport_schedule <- UnilSports::clean_sport_schedule

# Run the function
optimize_output <- optimize_schedule(clean_sport_schedule, date, activity, 
                                    time, calburn, weight,
                                    flag_no_duplicate_activities)
optim_plot <- optimize_output$table_result

# Call function
pie_optim(optim_plot) 

## ----echo=TRUE, eval = F------------------------------------------------------
#  # Call the function
#  startApp()

