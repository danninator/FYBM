library(tidyverse)
library(lubridate)

group_budgets <- read_csv("Data/RandomGroupBudgets.csv") %>%
  mutate(across(Total:ATR, as.numeric)) %>%
  rename_with(tolower) %>%
  mutate(
    start_dates = lubridate::dmy(paste(01, 07, substr(financial_year, 3, 4))),
    end_dates = lubridate::dmy(paste(30, 06, substr(financial_year, 6, 7)))
    )
