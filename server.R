server <- function(input, output,session) {

  output$summary <- renderUI({
    p1 <- as.numeric(input$p1)
    p2 <- as.numeric(input$p2)
    
    
    HTML(paste("<b>Definition:</b> ", "cohend", "<p/>"))
  })
  
    
}

