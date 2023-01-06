server <- function(input, output, session) {
  
  output$db_title <- renderText("ATO Five Year Budget")
  
  rv_ui <- reactiveValues(show = "summary")
  
  output$summary_graph <- renderPlot({
    ggplot(group_budgets, aes(x = total, y = financial_year)) +
      geom_col(width = 100) +
      coord_flip()
  })
  
  observeEvent(input$nav_summary, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "summary_tab")
    }, ignoreInit = TRUE)
  
  observeEvent(input$nav_group, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "group_tab")
    }, ignoreInit = TRUE)
  
  
}