library(tidyverse)
covid_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")

#dataframe of proportion of deaths to hospitalizations by race with most current data
#all counts are cumulative across date
deaths_by_race <- covid_data %>%
  filter(Date == max(Date, na.rm = T)) %>% 
  select(starts_with("Deaths")) %>% 
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity")) %>% 
  summarize_if(is.numeric, sum, na.rm=TRUE)
hosp_by_race <- covid_data %>% 
  filter(Date == max(Date, na.rm = T)) %>% 
  select(starts_with("Hosp")) %>% 
  select(-contains("Total"), -contains("Unknown"), -contains("Ethnicity")) %>% 
  summarize_if(is.numeric, sum, na.rm=TRUE)
proportions <- deaths_by_race / hosp_by_race
proportions <- proportions %>% 
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
#switch x,y orientation of previous dataframe for ease of use
names <- colnames(proportions)
values <- as.numeric(head(proportion,1))
death_hosp_proportions <- data.frame("Race" = names, "Proportion" = values)
#Create scatterplot of proportions of deaths to hospitalizations by race 
plot <- ggplot(data = death_hosp_proportions) +
  geom_col(mapping = aes(x = Race, y = Proportion, color = Race)) +
  labs(x = "Race", y = "Proportion of Deaths to Hospitalizations", title = "National Proportion of COVID Deaths to Hospitalizatons by Race")
  