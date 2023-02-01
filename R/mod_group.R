mod_groupUI <- function(id) {
  
  ns <- NS(id)
  
  fluidRow(
    column(width = 9,
           selectInput(inputId = ns("select_group"),
                       label = "Select Group:",
                       choices = distinct(group_budgets, group),
                       selected = group_budgets$group[1],
                       width = 200)
    ),
    column(width = 3,
           downloadButton(outputId = ns("group_data_download"),
                          label = "Download Data")
    ),
  )
  
  fluidRow(
    echarts4rOutput(outputId = ns("group_echart"))
  )

  
}


mod_groupServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    ######## GROUP TAB #########################################################
    
    ## TITLE ##
    
    output$group_title <- renderText({
      a <- "Five Year Budget"
      b <- input$select_group
      return(paste(a, " - ", b, " Group"))
    })
    
    ## DATA ##
    
    selected_group_budget <- reactive({
      
      one_group_budget <- group_budgets %>% 
        filter(group == input$select_group)
    })
    
    reactive_group_budgets <- reactive({
      if (is.null(input$select_group) == FALSE) {
        download_group_data <- selected_group_budget()
      } else {
        NULL
      }
      return(download_group_data)
    })  
    
    ## OUTPUTS ##
    
    output$group_data_download <- downloadHandler(
      filename = function() {paste(input$select_group, "_Five_Year_Budget_", Sys.Date(), ".csv", sep = "")},
      content = function(file) {write_csv(reactive_group_budgets(), file)}
    )
    
    output$group_echart <- renderEcharts4r({
      selected_group_budget() %>% 
        e_charts(financial_year) %>%
        e_bar(base, stack = "grp") %>%
        e_bar(npp, stack = "grp") %>%
        e_bar(atr, stack = "grp") %>%
        e_tooltip(trigger = "axis") %>% 
        e_y_axis(formatter = e_axis_formatter("currency"))
    })
    
    
    
  })
}