library(tidyverse)
library(lubridate)

group_budgets <- read_csv("Data/RandomGroupBudgets.csv") %>%
          mutate(across(Total:ATR, as.numeric)) %>%
          rename_with(tolower) %>%
          mutate(
            start_dates = lubridate::dmy(paste(01, 07, substr(financial_year, 3, 4))),
            end_dates = lubridate::dmy(paste(30, 06, substr(financial_year, 6, 7)))
            )


total_budgets <- group_budgets %>% 
          group_by(financial_year) %>% 
          summarise(total = sum(total),
                    base = sum(base),
                    atr = sum(atr),
                    npp = sum(npp))

  
total_group_budgets <- group_budgets %>%
          group_by(group) %>% 
          summarise(total = sum(total))
