server <- function(input, output, session) {
  
  output$db_title <- renderText("Five Year Budget")
  
  output$group_title <- renderText({
    a <- "Five Year Budget"
    b <- input$select_group
    return(paste(a, " - ", b, " Group"))
  })
  
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
  
  output$summary_echart <- renderEcharts4r({
    total_fy_budgets %>% e_charts(financial_year) %>% 
      e_bar(base, stack = "grp") %>% 
      e_bar(npp, stack = "grp") %>% 
      e_bar(atr, stack = "grp") %>% 
      e_tooltip(trigger = "axis") %>% 
      e_y_axis(formatter = e_axis_formatter("currency"))
  })

  output$group_tab_title <- renderText({
    ifelse(!input$select_group, "Group Budget Summary", paste0(input$select_group, " Budget Summary"))
  })
  
  observeEvent(input$nav_summary, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "summary_tab")
    }, ignoreInit = TRUE)
  
  observeEvent(input$nav_group, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "group_tab")
    }, ignoreInit = TRUE)
  
  output$total_infobox <- renderValueBox({
    valueBox(subtitle = "Total", 
             value = round(sum(total_fy_budgets$total)/1000000000,1),
             color = "black")
  })
  
  output$base_infobox <- renderValueBox({
    valueBox(subtitle = "Base",
             value = round(sum(total_fy_budgets$base)/1000000000,1),
             color = "light-blue")
  })
  
  output$npp_infobox <- renderValueBox({
    valueBox(subtitle = "NPP", 
             value = round(sum(total_fy_budgets$npp)/1000000000,1),
             color = "orange")
  })
  
  output$atr_infobox <- renderValueBox({
    valueBox(subtitle = "ATR", 
             value = round(sum(total_fy_budgets$atr)/1000000000,1),
             color = "red")
  })
  
}