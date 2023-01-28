mod_summaryUI <- function(id) {
  
  ns <- NS(id)
  
  fluidRow(
    column(width = 3, valueBoxOutput(ns("total_infobox"), width = 12)),
    column(width = 3, valueBoxOutput(ns("base_infobox"), width = 12)),
    column(width = 3, valueBoxOutput(ns("npp_infobox"), width = 12)),
    column(width = 3, valueBoxOutput(ns("atr_infobox"), width = 12))
  )
  
  br()
  
  fluidRow(
    echarts4rOutput(ns("summary_echart"))
  )

}


mod_summaryServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    
    ######## SUMMARY LOGIC #####################################################
    
    ## OUTPUTS ##
    
    #INFO BOXES 
    
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
    
    
    #SUMMARY BAR GRAPH
    
    output$summary_echart <- renderEcharts4r({
      total_fy_budgets %>% e_charts(financial_year) %>% 
        e_bar(base, stack = "grp") %>% 
        e_bar(npp, stack = "grp") %>% 
        e_bar(atr, stack = "grp") %>% 
        e_tooltip(trigger = "axis") %>% 
        e_y_axis(formatter = e_axis_formatter("currency"))
    })
    
  })
}