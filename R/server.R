server <- function(input, output, session) {
  
  output$db_title <- renderText("Five Year Budget")
  
  
  
  group <- reactiveValues(selected = "")
  
  observeEvent(input$select_group, {
    if (is.null(group$selected) == FALSE) {
      group$selected <- paste0(input$select_group)
    } 
  })
  
  output$tester <- renderText(input$select_group)
  
  output$group_echart <- renderEcharts4r({
    select_group_budget <- group_budgets %>% filter(group == group$selected)

    select_group_budget %>%
      e_charts(financial_year) %>%
      e_bar(base, stack = "grp") %>%
      e_bar(npp, stack = "grp") %>%
      e_bar(atr, stack = "grp") %>%
      e_y_axis(formatter = e_axis_formatter("currency"))
  })
  
  
  
  output$summary_echart <- renderEcharts4r({
    group_budgets %>% e_charts(financial_year) %>% 
      e_bar(base, stack = "grp") %>% 
      e_bar(npp, stack = "grp") %>% 
      e_bar(atr, stack = "grp") %>% 
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
  
  observeEvent(input$select_group, {
    group_budgets 
    
  })
  
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