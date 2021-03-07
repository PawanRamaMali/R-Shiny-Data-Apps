function(input,output, session){
  
  output$curve_plot <- renderPlot({
    curve(x^input$exponent, from = -5, to = 5)
  }
  )
  
}