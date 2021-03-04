library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")
# chart 1 filtered dataset

case_race <- covid_cases %>% 
  filter(Date == max(Date, na.rm = T)) %>%
  select(starts_with("Cases")) %>%
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity")) %>%
  summarize_if(is.numeric, sum, na.rm = TRUE)

server <- function(input, output){
  # chart 1 info 
  # Creating a histogram showing frequency of asian cases in all of the U.S.
  # states/territories from the dataset
  output$dist_asian_cases <- renderPlot({
    race_hist <- input$race_hist
    
    total_cases <- case_race %>% 
      select(race_hist)

    dist_asian_cases <- ggplot(data = total_cases) + 
    geom_histogram(
      mapping = aes(x = race_hist)
    ) +
    labs(x = paste("Number of", race_hist, "Cases"),
         y= "Frequency",
         title = "Distribution of total", race_hist, "Across the U.S.")
    
    return(dist_asian_cases)
  })
}



