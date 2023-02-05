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
  
  dashboardSidebar(
    collapsed = TRUE,
    width = 0
    # disable = TRUE
  ),
  
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "style.css"
      )
    ),
    
    # --??-- WHY IS IT THAT I NEED TO ADD br() IN TO MAKE THE BOX START IN THE DASH BODY? 
    
    br(), br(), br(),
    
    tabsetPanel(
      id = "tabs_UI",
      type = "hidden",
      selected = "summary_tab",
      
      tabPanel(title = "Summary",
               value = "summary_tab",
               box(
                 width = 12,
                 title = "Five Year Budget - Summary",
                 
                 solidHeader = TRUE,
                 
                 br(),
                 
                 mod_summaryUI("mod_summary")
                 
               )
      ),
      
      tabPanel(title = "Group",
               value = "group_tab",
               box(
                 width = 12,
                 title = textOutput("group_title"),
                 
                 mod_groupUI("mod_group")
                 
                 )
               )
      )
    )
)