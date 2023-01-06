suppressPackageStartupMessages({
  library(tidyverse)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(lubridate)
  library(echarts4r)
  library(here)
})

source(here("R/data.R"))
source(here("R/ui.R"))
source(here("R/server.R"))

shinyApp(ui, server)