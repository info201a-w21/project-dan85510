library(tidyverse)
library(lintr)
library(styler)
covid_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")

total_cases <- covid_data %>%
  filter(Date == max(Date, na.rm = T)) %>%
  select(Cases_Total) %>%
  sum(na.rm = T)
total_tests <- covid_data %>%
  filter(Date == max(Date, na.rm = T)) %>%
  select(Tests_Total) %>%
  sum(na.rm = T)
total_deaths <- covid_data %>%
  filter(Date == max(Date, na.rm = T)) %>%
  select(Deaths_Total) %>%
  sum(na.rm = T)
total_hosps <- covid_data %>%
  filter(Date == max(Date, na.rm = T)) %>%
  select(Hosp_Total) %>%
  sum(na.rm = T)
total_obvs <- nrow(covid_data)

summary_info <- list("Total Cases" = total_cases, "Total Tests" = total_tests, "Total Deaths" = total_deaths, "Total Hospitalizations" = total_hosps, "Total Observations" = total_obvs)
