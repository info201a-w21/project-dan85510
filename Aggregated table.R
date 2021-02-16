library(tidyverse)
library(lintr)
library(styler)
library(tibble)
library(knitr)
covid_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8SzaERcKJOD_EzrtCDK1dX1zkoMochlA9iHoHg_RSw3V8bkpfk1mpw4pfL5RdtSOyx_oScsUtyXyk/pub?gid=43720681&single=true&output=csv")

#Select only the data we will need for this analysis
covid_19_data_analysis <- covid_data %>%
  subset(select = -State) %>%
  select(-contains("Total")) %>%
  filter(Date == max(Date)) %>%
  replace(is.na(.), 0) %>%
  summarize_all(list(sum)) %>%
  subset(select = -Date)

#Make data set with just deaths for each ethnicity
deaths_by_ethnicity <- covid_19_data_analysis %>%
  select(contains("Deaths")) %>%
  rename(White = Deaths_White,
         Black = Deaths_Black,
         Latinx = Deaths_Latinx,
         Asian = Deaths_Asian,
         AIAN = Deaths_AIAN,
         NHPI = Deaths_NHPI,
         Multiracial = Deaths_Multiracial,
         Other = Deaths_Other,
         Unknown = Deaths_Unknown,
         Hispanic = Deaths_Ethnicity_Hispanic,
         NonHispanic = Deaths_Ethnicity_NonHispanic,
         Ethnicity_Unknown = Deaths_Ethnicity_Unknown)

#Flip columns and rows for easier use
deaths_by_ethnicity <- as.data.frame(t(deaths_by_ethnicity))

#Name columns
deaths_by_ethnicity <- setNames(cbind(rownames(deaths_by_ethnicity),
                                      deaths_by_ethnicity,
                                      row.names = NULL),
                                c("Ethnicity", "Deaths"))
 
#Make data set with just cases for each ethnicity
cases_by_ethnicity <- covid_19_data_analysis %>%
  select(contains("Cases")) %>%
  rename(White = Cases_White,
         Black = Cases_Black,
         Latinx = Cases_Latinx,
         Asian = Cases_Asian,
         AIAN = Cases_AIAN,
         NHPI = Cases_NHPI,
         Multiracial = Cases_Multiracial,
         Other = Cases_Other,
         Unknown = Cases_Unknown,
         Hispanic = Cases_Ethnicity_Hispanic,
         NonHispanic = Cases_Ethnicity_NonHispanic,
         Ethnicity_Unknown = Cases_Ethnicity_Unknown)

#Flip columns and rows
cases_by_ethnicity <- as.data.frame(t(cases_by_ethnicity))

#Name columns
cases_by_ethnicity <- setNames(cbind(rownames(cases_by_ethnicity),
                                     cases_by_ethnicity,
                                     row.names = NULL),
                               c("Ethnicity", "Cases"))

#Make data set with just hospitalizations for each ethnicity
hosp_by_ethnicity  <- covid_19_data_analysis %>%
  select(contains("Hosp")) %>%
  rename(White = Hosp_White,
         Black = Hosp_Black,
         Latinx = Hosp_Latinx,
         Asian = Hosp_Asian,
         AIAN = Hosp_AIAN,
         NHPI = Hosp_NHPI,
         Multiracial = Hosp_Multiracial,
         Other = Hosp_Other,
         Unknown = Hosp_Unknown,
         Hispanic = Hosp_Ethnicity_Hispanic,
         NonHispanic = Hosp_Ethnicity_NonHispanic,
         Ethnicity_Unknown = Hosp_Ethnicity_Unknown)

#Flip columns and rows
hosp_by_ethnicity <- as.data.frame(t(hosp_by_ethnicity))

#Name columns
hosp_by_ethnicity <- setNames(cbind(rownames(hosp_by_ethnicity),
                                    hosp_by_ethnicity,
                                    row.names = NULL),
                              c("Ethnicity", "Hospitalizations"))


#Make data set with just tests for each ethnicity
tests_by_ethnicity <- covid_19_data_analysis %>%
  select(contains("Tests")) %>%
  rename(White = Tests_White,
         Black = Tests_Black,
         Latinx = Tests_Latinx,
         Asian = Tests_Asian,
         AIAN = Tests_AIAN,
         NHPI = Tests_NHPI,
         Multiracial = Tests_Multiracial,
         Other = Tests_Other,
         Unknown = Tests_Unknown,
         Hispanic = Tests_Ethnicity_Hispanic,
         NonHispanic = Tests_Ethnicity_NonHispanic,
         Ethnicity_Unknown = Tests_Ethnicity_Unknown)

#Flip columns and rows
tests_by_ethnicity <- as.data.frame(t(tests_by_ethnicity))

#Name columns
tests_by_ethnicity <- setNames(cbind(rownames(tests_by_ethnicity),
                                     tests_by_ethnicity,
                                     row.names = NULL),
                               c("Ethnicity", "Tests"))

#Join data frames together into one data frame
COVID_19_Data <- left_join(cases_by_ethnicity, deaths_by_ethnicity, by = "Ethnicity") %>%
  left_join(., hosp_by_ethnicity, by = "Ethnicity") %>%
  left_join(., tests_by_ethnicity, by = "Ethnicity")

kable(COVID_19_Data)
