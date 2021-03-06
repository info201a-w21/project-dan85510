library(shiny)
library(ggplot2)
source("app_server.R")

#Widget Components:
# graph inputs for chart 1 ------------------------------------------------
race_option <- selectInput(
  inputId = "race",
  choices = colnames(case_race),
  label = "Choose a race/ethnicity",
  selected = "Cases_White"
)

color_options <- radioButtons(
  inputId = "colors",
  label = h3("Color options"),
  choiceValues = c("turquoise", "tomato", "ivory", "honeydew"), 
  choiceNames = list("Turquoise", "Tomato", "Ivory", "Honeydew"),
  selected = 1,
)

# graph inputs for chart 2 ------------------------------------------------

#select for which year
race_input <- checkboxGroupInput(
  inputId = "race_choice",
  choices = races,
  label = "choose a racial group to display",
  selected = "Asian"
)

#Select which date
date_input <- sliderInput(
  inputId = "date_choice", 
  label = "choose a date range for the data to display",
  min = as.Date("2020-06-17","%Y-%m-%d"),
  max = as.Date("2021-03-03","%Y-%m-%d"),
  value = c(as.Date("2020-06-29"), as.Date("2021-01-29")), 
  timeFormat="%Y-%m-%d", 
  step = 1,
  animate = animationOptions(interval = 1800)
)
#UI Features:
# UI Components -----------------------------------------------------------

page_one <- tabPanel(
  "Introduction"
)

page_two <- tabPanel(
  "Chart 1",
  titlePanel("Title"),
  br(),
  sidebarLayout(
    sidebarPanel(
        race_option,
        color_options
    ),
    mainPanel(
      h2("Chart"),
      plotlyOutput(outputId = "histogram"),
    )
  ),
  br(),
  p("I chose to include this because ... ")
)

page_three <- tabPanel(
  "Chart Two", 
  titlePanel("title of chart"),
  br(),
  #Put all the inputs here
  sidebarLayout(
    sidebarPanel(
      race_input,
      date_input
    ),
    #Display the actual chart here
    mainPanel(
      # Actual chart
      plotlyOutput(outputId = "barchart"),
    )
  ),
  br(),
  #Why included chart and what patterns shown 
  p("some explanation")
)

page_four <- tabPanel(
  "Title" 
)

page_five <- tabPanel(
  "Summary/Takeaways" 
)

ui <- navbarPage(
  "Final Project", 
  page_one,         
  page_two,
  page_three,
  page_four,
  page_five
)