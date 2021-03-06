covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")
library(tidyverse)

# Obtaining all asian cases from the most recent date in all U.S. 
# states/territories
asian_cases <- covid_cases %>%
  filter(Date == max(Date, na.rm = T)) %>%
  select(Cases_Asian)

# Creating a histogram showing frequency of asian cases in all of the U.S.
# states/territories from the dataset
dist_asian_cases <- ggplot(data = asian_cases, aes(x=Cases_Asian)) + 
  geom_histogram(bins = 30) +
  labs(x = "Number of Asian Cases",
       y= "Frequency",
       title = "Distribution of total Asian Cases Across the U.S.")



