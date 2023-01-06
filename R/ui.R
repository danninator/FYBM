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
    width = 0
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
                 fluidRow(
                   column(width = 3, infoBoxOutput("total_infobox", width = 12)),
                   column(width = 3, infoBoxOutput("base_infobox", width = 12)),
                   column(width = 3, infoBoxOutput("npp_infobox", width = 12)),
                   column(width = 3, infoBoxOutput("atr_infobox", width = 12))
                   ),
                 br(),
                 box(
                   fluidRow(
                     plotOutput(outputId = "summary_graph")
                     )
                   )
                 ),
               ),
      
      tabPanel(title = "Group",
               value = "group_tab",
               box(
                 width = 12,
                 title = "Group Budget Summary"
                 )
               )
      )
    )
)