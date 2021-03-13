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
  tags$img(alt="Covid-19", src="COVID-19.png"),
  tags$h1("Project Overview"),
  p("The main topic of our project is looking at accessibility to COVID hospitalization 
    in the US among different demographics. We wanted to analyze if demographics affect 
    the ability to get COVID-related support in hospitals. The data we are looking at was 
    gathered from the COVID Tracking Project and Boston University Center for Antiracist Research. 
    They obtained the data from the states' reports of them. This dataset helps to answer our 
    research question by looking at a lot of different variables regarding how COVID-19 has affected 
    different ethnicities across the U.S. The two main points of focus are looking at how treatment 
    rates of COVID cases differ based on different ethnicity groups and how hospitalization rates differ 
    based on different ethnicity groups? In looking at these variables 
    and doing analysis over them some important findings can be made about the ways in which 
    different ethnicities in the U.S. dealt with COVID-19. "),
  br(),
  tags$h2("Please Read Carefully"),
  tags$h3("Check if you are experiencing any of the following symptoms, if so consult a doctor or dial 911."),
  tags$ul(
    tags$li("Fever or chills"),
    tags$li("Cough"),
    tags$li("Shortness of breath or difficulty breathing"),
    tags$li("Muscle or body aches"),
    tags$li("Headache"),
    tags$li("New loss of taste or smell"),
    tags$li("Sore throat"),
    tags$li("Congestion or runny nose"),
    tags$li("Nausea or vomiting"),
    tags$li("Diarrhea")
  ),
  br(),
  tags$h3("Fun Facts About Covid-19"),
  tags$ul(
    tags$li("The first covid case in the U.S. was in Kirkland, Washington"),
    tags$li("People of blood type A are more likely to get COVID-19"),
    tags$li("The coronavirus is named SARS-CoV-2 while the disease is called COVID-19.")
  )
)

page_two <- tabPanel(
  "Histogram of Cases by Ethnicity",
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
  p("I chose to include this chart because it was a very important starting 
    point before analyzing the dataset further. We wanted to look at and see 
    how the number of COVID-19 cases differed for each ethnicity. One important 
    note is that for many of the different histograms by ethnicity, there were 
    outliers where the case number was much higher than the majority of the 
    other data points. We can assume that it was either in states that had a 
    larger population in general, a state in which that ethnicity composed a 
    greater percentage of the total population, or states where there were 
    more overall cases. A pattern I noticed was that the White and Black 
    population had a higher frequency of cases towards the middle and end 
    of the histogram as well as had much higher case numbers than other races. 
    For some ethnicities, there were states or territories that didn’t register
    the number of cases which could affect the distribution of data for a 
    specific ethnicity.")
)

page_three <- tabPanel(
  "Deaths to Hospitalizations Ratio", 
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
  "COVID Hospitalizations over Time",
  titlePanel("Examining COVID Hospitalizations by Race over Time"),
  br(),
  sidebarLayout(
    sidebarPanel(
      dates_input
    ),
    mainPanel(
      plotlyOutput(outputId = "graph")
    )
  ),
  br(),
  p("This chart shows that over time, White and Latinx individuals consistently have the highest hospitalization
     rates due to COVID-19. However, especially in later months, starting in 2021, White hospitalizations have increased
    dramatically relative to other ethnicities, which have largely remained constant starting in 2021. Therefore, this 
    indicates that either White individuals have more access to hospitals relative to other ethnicities, or they are
    getting COVID at higher rates compared to other ethnicities.")
)

page_five <- tabPanel(
  "Summary/Takeaways",
  titlePanel("Major takeaways"),
  br(),
  sidebarLayout(
    sidebarPanel(
      p("Through our data collecting and analysis, we were able to identify key aspects of the data we investigated and researched.
      Overall, the largest percentage of individuals hospitalized from the coronavirus to date was the white population; 
      as of March 3, 2017, White Americans were responsible for almost half of all 
      the total US hospitalizations (around 46.57%, 288,383 individuals) while the other minority groups accounted for 
      the remaining 53.43% of COVID-19 hospitalizations in the United States. This result shows that White Americans had
      greater accessibility to COVID-19 support that came in the form of hospital/medical attention than other ethnicities due to possible
      factors such as financial status, skeptism/trust towards public medical care, or ethical values." )
    ),
  mainPanel(
    plotlyOutput(outputId = "BAR"),
    br(),
    br(),
    p("Another takeaway we found was the changes in the deaths to hospitalizations proportion for Asian and White ethnicities. 
      From chart 2, we initially found a greater proportion of deaths to hospitalizations for Asians; Understanding 
      that the source of COVID-19 was located in Asia, travelers from countries that endured the first wave of the coronavirus 
      the hardest from Asia could have more easily spread the virus to individuals whom they closely socialized with (family, friends) in the US. However, 
      we found that in the later half of 2020, we saw a drastic increase in the deaths to hospitalizations proportion for white Americans, showing the results 
      of primarily young Americans' neglecting health and safety protocols and the absence of strict coronavirus restrictions until after 
      large surges in COVID-19 cases."),
    br(),
    p("Finally, we saw various US states/territories that had drastically large numbers of COVID-19 cases compared to the majority of states/territories that 
      accounted for less than 50,000 COVID-19 positive tests each. Specifically, groups identifying as White or Black saw various areas across the country where 
      cases were well above 100,000. From our data, we found that 32 states/territories had on average more than 100,000 coronavirus cases for the white population, while the Black population's
      positive tests surpassed the same mark in 8 states/territories. The data collected suggests that the higher average COVID-19 cases for White and Black ethnic groups 
      in many states/territories compared to other minority populations could show why White individuals had a drastically large amount of people hospitalized while Black individuals had the 3rd highest at 110,220 hospitalizations. 
      ")
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