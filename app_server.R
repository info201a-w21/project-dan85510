library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")
source("ChartTwo-Proportions.R")

# Chart 1 Components ------------------------------------------------------

# chart 1 filtered dataset

case_race <- covid_cases %>% 
  filter(Date == max(Date, na.rm = T)) %>%
  select(starts_with("Cases")) %>%
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity"))


# Chart 2 Components ------------------------------------------------------

covid_data <- covid_cases %>% 
  mutate(date_string = as.character(Date))
covid_data$date_string <- as.Date(covid_data$date_string, format = "%Y%m%d")

covid_data  <- covid_data  %>% 
  subset(select = -c(Date)) %>% 
  arrange(date_string) %>% 
  rename(
    Date = date_string
  )

deaths_by_race <- covid_data %>%
  group_by(Date) %>% 
  select(Date, starts_with("Deaths")) %>%
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity")) %>%
  summarize_if(is.numeric, sum, na.rm = TRUE) 

hosp_by_race <- covid_data %>%
  group_by(Date) %>% 
  select(Date, starts_with("Hosp")) %>%
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity")) %>%
  summarize_if(is.numeric, sum, na.rm = TRUE)

temp_deaths_by_race <- deaths_by_race %>% 
  subset(select = -c(Date)) 
temp_hosp_by_race <- hosp_by_race %>% 
  subset(select = -c(Date))

proportions <- temp_deaths_by_race / temp_hosp_by_race
proportions[mapply(is.infinite, proportions)] <- 0
time_data <- subset(deaths_by_race, select = c(Date))

new_proportions <- cbind(time_data, proportions)
new_proportions <- tail(new_proportions, -19)
new_proportions <- new_proportions  %>%
  rename(
    White = Deaths_White,
    Black = Deaths_Black,
    LatinX = Deaths_Latinx,
    Asian = Deaths_Asian,
    AIAN = Deaths_AIAN,
    NHPI = Deaths_NHPI,
    Multiracial = Deaths_Multiracial,
    Other = Deaths_Other
  ) 

dates <- new_proportions$Date
min_date <- min(dates)
max_date <- max(dates)
races <- c("White", "LatinX", "Asian", "AIAN", "NHPI", "Multiracial", "Other")
# Server Components -------------------------------------------------------

server <- function(input, output, session){
  # chart 1 info
  # Creating a histogram showing frequency of asian cases in all of the U.S.
  # states/territories from the dataset
  output$case_total <- renderPlot({
    #chart 1
    race_hist <- input$race_hist
    
    total_cases <- case_race %>% 
      select(input$race_hist)

    hist_cases <- ggplot(data = total_cases, aes(x = input$race_hist)) + 
    geom_bar() +
    labs(x = paste("Number of", input$race_hist),
         y= "Frequency",
         title = "Distribution of total", input$race_hist, "Across the U.S.")

    #return(dist_asian_cases)
  })
  #chart 2
  filtered_data <- reactive({new_proportions %>% 
      filter(Date >= input$date_choice[1], Date <= input$date_choice[2])
  })
  #this line is not working rn
  filtered_data <- reactive({filtered_data[ ,which((names(filtered_data) %in% input$race_choice)==TRUE)]})
  filtered_data <- reactive({filtered_data %>% 
    select(-contains("Date"))
    names <- colnames(filtered_data)
    values <- as.numeric(head(filtered_data, 1))
    death_hosp_proportions <- data.frame("Race" = names, "Proportion" = values)
  })
  output$barchart <- renderPlotly({
    my_plot <- ggplot(death_hosp_proportions) +
      geom_col(mapping = aes(x = Race, y = Proportion, color = Race)) +
      labs(x = "Race", y = "Proportion of Deaths to Hospitalizations", title = "COVID Deaths to Hospitalizatons by Race")
    ggplotly(my_plot) 
  })
}



