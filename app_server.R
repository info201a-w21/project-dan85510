library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")
# chart 1 filtered dataset

case_race <- covid_cases %>% 
  filter(Date == max(Date, na.rm = T)) %>%
  select(starts_with("Cases")) %>%
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity"))

server <- function(input, output){
  # chart 1 info 
  output$case_total <- renderPlot({
    
    total_cases <- case_race %>% 
      select(input$race_hist)

    hist_cases <- ggplot(data = total_cases, aes(x = input$race_hist)) + 
    geom_bar() +
    labs(x = paste("Number of", input$race_hist),
         y= "Frequency",
         title = "Distribution of total", input$race_hist, "Across the U.S.")
    
    return(hist_cases)
  })
}



