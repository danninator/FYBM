server <- function(input, output, session) {
  
  output$db_title <- renderText("Five Year Budget")
  
  rv_ui <- reactiveValues(show = "summary")
  
  output$summary_graph <- renderPlot({
    ggplot(group_budgets, aes(x = total, y = financial_year, fill = group)) +
      geom_col() +
      coord_flip() +
      scale_x_continuous(labels = scales::dollar)
  })
  
  output$summary_echart <- renderEcharts4r({
    group_budgets %>% e_charts(group) %>% 
      e_bar(base, stack = "grp") %>% 
      e_bar(npp, stack = "grp") %>% 
      e_bar(atr, stack = "grp")
  })
  
  
  output$summary_graph2 <- renderPlot ({
    group_budgets %>% e_charts() %>% 
      e_line()
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