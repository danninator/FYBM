ui <- dashboardPage(
  title = "FYBM",
  
  shinydashboardPlus::dashboardHeader(
    title = textOutput("db_title"),
    titleWidth = 240,
    fixed = TRUE,
    leftUi = tagList(
      actionButton(inputId = "nav_summary",
                   label = "Summary",
                   width = 100),
      actionButton(inputId = "nav_group",
                   label = "Group",
                   width = 100)
    )
  ),
  
  shinydashboardPlus::dashboardSidebar(
    width = 0
  ),
  
  dashboardBody(
    
    # -- ?? -- WHY IS IT THAT I NEED TO ADD br() IN TO MAKE THE BOX START IN THE DASH BODY?
    
    br(), br(), br(),
    
    box(
      title = "Summary Box",
      id = "summary_box",
      collapsible = TRUE,
      width = 12,
      
      fluidRow(
        column(width = 3, "Total Col"),
        column(width = 3, "Base Col"),
        column(width = 3, "NPP Col"),
        column(width = 3, "ATR Col")
      ),
      
      fluidRow(
        plotOutput(outputId = "summary_graph")
      )
    )
    
    
  )
)