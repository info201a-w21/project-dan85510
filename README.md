# Final Project
**Topic**: Accessibility to COVID hospitalization in the US among different demographics
**Description**: We want to analyze if demographics affect the ability to get COVID-related support in hospitals.

**DOMAIN OF INTEREST**
As we've discussed, data science can expose underlying patterns in any domain that uses or collects data (which is nearly _any_ domain). Anything from the [forced relocation of homeless individuals](https://www.theguardian.com/us-news/ng-interactive/2017/dec/20/bussed-out-america-moves-homeless-people-country-study) to how people display [gender representation](https://pudding.cool/2017/09/this-american-life/).

In the media, data can expose interesting (and actionable) patterns. In this section, you'll identify a domain that you are interested in (e.g., music, education, dance, immigration -- any field of your interest) and answer the following questions in your README.md file:

- _Why are you interested in this field/domain?_
COVID is an immediate problem that affects everyone in the US. Accessibility to COVID treatment is especially pertinent now since COVID cases are on the rise and vaccinations are starting to be distributed.

- What other examples of data driven project have you found related to this domain?
  - [Link 1](https://covidtracking.com/race)
    - This project tracks COVID CASES (along with the resulting death rates, treatments, etc.) and separates the cases based on ethnicity.
  - [Link 2](https://www.statista.com/statistics/1122354/covid-19-us-hospital-rate-by-age/)
    - This data presents the number of laboratory-related COVID-19 hospitalizations in the United States by age groups.
  - [Link 3](https://www.cdc.gov/nchs/nvss/vsrr/covid19/health_disparities.htm)
    - This data set is specifically focusing on Hispanics in comparison to other races with data focusing on death/age distribution.

- What data driven questions do you hope to answer to answer about this domain?

  - How do treatment rates of COVID cases differ based on different ethnicity or age groups?
  - How do treatment rates differ according to different parts (cities, states, etc.) of the country?
  - Is there a significant difference in treatment rates according to the median incomes of the location?

**FINDING DATA**

1. [US COVID-19 cases and deaths by state](https://covid.cdc.gov/covid-data-tracker/?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fcases-updates%2Fcases-in-us.html#cases_casesper100klast7days )
  - We downloaded the data from this URL above
  - The data was collected by the CDC from officially submitted COVID-19 reports from autonomous reporting entities
  - Rows
  - Columns
  - ------
2. [US COVID-19 Racial Data Tracker](https://covidtracking.com/race)
  - The data was downloaded from the URL above.
  - The data was gathered from the COVID Tracking Project and Boston University Center for Antiracist Research. They obtained the data from the states reports of them.
  - There are 4,648 rows in the dataset.
  - There are 54 columns in the dataset.
  - A questions that can be answered from this dataset is how different races are being affected either in infection rate, death rate, hospitalization, and more by state.
  - -----
3. [UW COVID-19 Hospitalization Rate by State, Age, and Ethnicity](https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html)
  - The data was downloaded from the UWL above.
  - The data is accumulated by the COVID-19-Associated Hospitalization Surveillance Network, which collects the hospitalization rates of nearly 100 counties in 10 Emerging Infections Program (EIP) states.
  - There are 34,275 observation rows in the dataset.
  - There are 10 features in the dataset, 8 of which are applicable to the research.
  - Questions that can be answered from this data include how the number of COVID-19 cases per 100,000 people vary from state to state, how it varies by ethnicity, and how it varies over time.
