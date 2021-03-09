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
  choices = list("Turquoise" = "turquoise", "Tomato" = "tomato", 
                 "Blue" = "blue", "Honeydew" = "honeydew")
)

# graph inputs for chart 2 ------------------------------------------------

#select for which year
race_input <- checkboxGroupInput(
  inputId = "race_choice",
  choices = races,
  label = "choose a racial group to display",
  selected = c("Asian", "AIAN")
)

#Select which date
date_input <- sliderInput(
  inputId = "date_choice", 
  label = "choose a date range for the data to display",
  min = as.Date("2020-06-17","%Y-%m-%d"),
  max = as.Date("2021-03-07","%Y-%m-%d"),
  value = c(as.Date("2020-06-29"), as.Date("2021-01-29")), 
  timeFormat="%Y-%m-%d", 
  step = 30,
  animate = animationOptions(interval = 300, loop = TRUE)
)

# graph inputs for chart 3 ------------------------------------------------
dates_input <- sliderInput (
  inputId = "date_range",
  label = "Choose a range of dates to display",
  min = as.Date("2020-04-12", "%Y-%m-%d"),
  max = as.Date("2021-03-03", "%Y-%m-%d"),
  value = c(as.Date("2020-08-01"), as.Date("2020-12-01")),
  step = 1,
  animate = animationOptions(interval = 300, loop = TRUE)
)

#UI Features:
# UI Components -----------------------------------------------------------

page_one <- tabPanel(
  "Introduction", 
  p("The main topic of our project is looking at accessibility to COVID hospitalization in the US among different demographics. We wanted to analyze if demographics affect the ability to get COVID-related support in hospitals. The data we are looking at was gathered from the COVID Tracking Project and Boston University Center for Antiracist Research. They obtained the data from the states' reports of them. This dataset helps to answer our research question by looking at a lot of different variables regarding how COVID-19 has affected different ethnicities across the U.S. The two main points of focus are looking at how treatment rates of COVID cases differ based on different ethnicity groups and how hospitalization rates differ according to different parts (cities, states, etc.) of the country? In looking at these variables and doing analysis over them some important findings can be made about the ways in which different ethnicities in the U.S. dealt with COVID-19. ")
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
  titlePanel("Observing Deaths to Hospitalization Proportions Across Ethnicities"),
  br(),
  sidebarLayout(
    sidebarPanel(
      race_input,
      date_input
    ),
    mainPanel(
      plotlyOutput(outputId = "barchart"),
    )
  ),
  br(),
  #Why included chart and what patterns shown 
  p("I included this chart to view the breakdown of deaths to hospitalization proportion across different races. Some patterns that I observed was that the White and Asian proportions were always the highest out of all the other races regardless of the time frame. However, I saw that in the early 2020 year, Asians had a higher deaths to hospitalizations proportion until late 2020, where the White proportion surpassed the Asian proportion. While I was wrangling the data, I also noticed that there was a significant lack of data in the hospitalizations for all races during March and April of 2020, which could affect the contextualization of this graph.")
)

page_four <- tabPanel(
  "Chart 3",
  titlePanel("Examining COVID Hospitalizations by Race over Time"),
  br(),
  sidebarLayout(
    sidebarPanel(
      dates_input
    ),
    mainPanel(
      plotlyOutput(outputId = "graph")
    )
  )
  
)

page_five <- tabPanel(
  "Summary/Takeaways",
  titlePanel("Major takeaways"),
  br(),
  sidebarLayout(
    sidebarPanel(
      p("Takeaway 1")
    ),
  mainPanel(
    plotlyOutput(outputId = "BAR"),
    br(),
    p("takeaway 2"),
    br(),
    p("takeaway 3")
     )
    )
  )

ui <- navbarPage(
  "Final Project", 
  page_one,         
  page_two,
  page_three,
  page_four,
  page_five
)