server <- function(input, output, session) {
  
  output$db_title <- renderText("ATO Five Year Budget")
  
  output$summary_graph <- renderPlot({
    ggplot(group_budgets, aes(x = total, y = financial_year)) +
      geom_col(width = 100) +
      coord_flip()
  })
  
}