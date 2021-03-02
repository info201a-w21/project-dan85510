library(shiny)
library(ggplot2)
source("app_server.R")
page_one <- tabPanel(
  "Introduction" 
)

# graph inputs for chart 2
states <- selectInput(
  inputId = "state",
  choices = covid_cases$State,
  label = "Choose a state"
)

color_options <- radioButtons(
  inputId = "colors",
  label = h3("Color options"),
  choiceValues = c("turquoise", "tomato", "ivory", "honeydew"), 
  choiceNames = list("Turquoise", "Tomato", "Ivory", "Honeydew"),
  selected = 1,
)

page_two <- tabPanel(
  "Chart 1",
  titlePanel("Title"),
  br(),
  sidebarLayout(
    sidebarPanel(
        states,
        color_options
  ),
  mainPanel(
    h2("Chart"),
  )
  ),
)

page_three <- tabPanel(
  "Title" 
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