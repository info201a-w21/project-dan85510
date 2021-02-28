library(shiny)
library(ggplot2)

page_one <- tabPanel(
  "Introduction" 
)

page_two <- tabPanel(
  "Title" 
)

page_three <- tabPanel(
  "Title" 
)

page_four <- tabPanel(
  "Title" 
)

page_five <- tabPanel(
  "Title" 
)

ui <- navbarPage(
  "Final Project", 
  page_one,         
  page_two,
  page_three,
  page_four,
  page_five
)