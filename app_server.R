library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

covid_cases <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv", na.strings=c(""," ","NA"))
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
  # Creating a histogram showing frequency of cases in all of the U.S.
  # states/territories from the dataset
#  total_cases <- reactive({case_race %>% 
#       select(input$race)
#   })
  output$histogram <- renderPlotly({
    total_cases <- case_race %>% 
      select(input$race)
    hist_cases <- ggplot(total_cases, aes_string(x=input$race)) +
      geom_histogram(bins = 30) +
      labs(x = paste("Number of", input$race),
           y= "Frequency",
           title = paste("Distribution of Total", input$race, "Across the U.S."))
    ggplotly(hist_cases)
  })
  #chart 2
  output$barchart <- renderPlotly({
    test_data1 <- reactive({
      filtered_data <- new_proportions %>% 
        filter(Date <= input$date_choice[2], Date >= input$date_choice[1])
      filtered_data <-filtered_data %>% 
        select(-contains("Date"))
      names <- colnames(filtered_data)
      values <- as.numeric(head(filtered_data, 1))
      test_data <- data.frame("Race" = names, "Proportion" = values)
      test_data %>% filter(Race %in% input$race_choice)
    })
    my_plot <- ggplot(test_data1()) +
      geom_col(mapping = aes(x = Race, y = Proportion, fill = Race)) +
      labs(x = "Race", y = "Proportion of Deaths to Hospitalizations", title = "COVID Deaths to Hospitalizatons by Race")
    ggplotly(my_plot) 
  })
  
  #chart 3

  output$graph <- renderPlotly({
    hosp_by_day <- covid_cases %>% 
      select("Date", starts_with("Hosp")) %>% 
      group_by(Date) %>% 
      summarize(White = sum(Hosp_White, na.rm = T),
              Black = sum(Hosp_Black, na.rm = T),
              Latinx = sum(Hosp_Latinx, na.rm = T),
              Asian = sum(Hosp_Asian, na.rm = T),
              AIAN = sum(Hosp_AIAN, na.rm = T),
              NHPI = sum(Hosp_NHPI, na.rm = T),
              Multiracial = sum(Hosp_Multiracial, na.rm = T),
              Other = sum(Hosp_Other, na.rm = T),
              Unknown = sum(Hosp_Unknown, na.rm = T)
    ) %>% 
    mutate(Date = as.character(Date)) %>% 
    mutate(Date = as.Date(Date, "%Y%m%d")) %>% 
    #filter based on dates inputted by user
    filter(Date >= input$date_range[1], Date <= input$date_range[2]) %>% 
    #changes layout of the dataframe to make it suitable for plotting
    gather(key = Ethnicity,
           value = Hospitalizations,
           -Date)
  
  options(scipen = 5)
  
  chart <- ggplot(hosp_by_day) +
      geom_area(mapping = aes(x = Date, y = Hospitalizations, fill = Ethnicity)) +
      labs (
        title = "Hospitalizations by Ethnicity over Time",
        x = "Date",
        y = "Number of Hospitalizations"
      )
  chart
  })
}



