library(tidyverse)
library(lintr)
library(styler)
library(ggplot2)
covid_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")

#creates a dataframe with total hospitalizations by ethnicity, by day
hosp_by_day <- covid_data %>% 
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
  #changes layout of the dataframe to make it suitable for plotting
  gather(key = Ethnicity,
         value = Hospitalizations,
         -Date)

options(scipen = 5)
#area plot
graph <- ggplot(hosp_by_day, aes(x = Date, y = Hospitalizations, fill = Ethnicity)) +
  geom_area() +
  labs (
    title = "Hospitalizations by Ethnicity over Time"
  )
