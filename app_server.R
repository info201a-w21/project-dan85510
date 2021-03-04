library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")

server <- function(input, output){
  # chart 1 info 
  # Creating a histogram showing frequency of asian cases in all of the U.S.
  # states/territories from the dataset
  output$dist_asian_cases <- renderPlot({
    state <- input$states
    
    total_cases <- covid_cases %>% 
      filter(Date == max(Date, na.rm = T)) %>% 
      filter(State == input$states)

    dist_asian_cases <- ggplot(data = total_cases) + 
    geom_histogram(
      mapping = aes(x = Cases_Asian)
    ) +
    labs(x = "Number of Asian Cases",
         y= "Frequency",
         title = "Distribution of total Asian Cases Across the U.S.")
    
    return(dist_asian_cases)
  })
}



