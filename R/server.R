server <- function(input, output, session) {
  
######## TITLE & SLECT TAB #####################################################
  
  output$db_title <- renderText("Five Year Budget")
  
  
  observeEvent(input$nav_summary, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "summary_tab")
  }, ignoreInit = TRUE)
  
  observeEvent(input$nav_group, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "group_tab")
  }, ignoreInit = TRUE)
  
  

#### TAB MODULES ###############################################################
  
  ## SUMMARY MODULE ##
  
  mod_summaryServer("mod_summary")
  
  
  ## GROUP MODULE ##
  
  mod_groupServer("mod_group")
  
}