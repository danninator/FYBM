suppressPackageStartupMessages({
  library(tidyverse)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(lubridate)
  library(echarts4r)
})

source("data.R")
source("ui.R")
source("server.R")

shinyApp(ui, server)