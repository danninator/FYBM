ui <- dashboardPage(
  title = "FYBM",
  
  dashboardHeader(
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
    collapsed = TRUE
    # width = 0
  ),
  
  dashboardBody(
    
    # --??-- WHY IS IT THAT I NEED TO ADD br() IN TO MAKE THE BOX START IN THE DASH BODY? 
    # Shouldn't it already be within the body? By that logic, BELOW the header?
    
    br(), br(), br(),
    
    tabsetPanel(
      id = "tabs_UI",
      type = "hidden",
      selected = "summary_tab",
      
      tabPanel(title = "Summary",
               value = "summary_tab",
               box(
                 width = 12,
                 title = "Five Year Budget Summary",
                 
                 # solidHeader = TRUE,
                 
                 br(),
                 fluidRow(
                   column(width = 3, valueBoxOutput("total_infobox", width = 12)),
                   column(width = 3, valueBoxOutput("base_infobox", width = 12)),
                   column(width = 3, valueBoxOutput("npp_infobox", width = 12)),
                   column(width = 3, valueBoxOutput("atr_infobox", width = 12))
                 ),
                 br(),
                 fluidRow(
                   echarts4rOutput(outputId = "summary_echart")
                     )
                 )
      ),
      
      tabPanel(title = "Group",
               value = "group_tab",
               box(
                 width = 12,
                 title = textOutput("group_tab_title"),
                 selectInput(inputId = "select_group",
                             label = "Select Group:",
                             choices = distinct(group_budgets, group),
                             selected = group_budgets$group[1],
                             width = 200),
                 fluidRow(
                   textOutput(outputId = "tester"),
                   echarts4rOutput(outputId = "group_echart")
                 )
                 )
               )
      )
    )
)