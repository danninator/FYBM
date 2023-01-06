suppressPackageStartupMessages({
  library(tidyverse)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(lubridate)
  library(echarts4r)
})

source("R/data.R")
source("R/ui.R")
source("R/server.R")

shinyApp(ui, server)