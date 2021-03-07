library(DT)

function(input, output, session){
  
  output$star_narrow <-  renderDT({
    starwars %>%
      select(name, height, homeworld) %>%
      arrange(desc(height))
  }, rownames = FALSE)
  
  output$star_wide <- renderDT({
    starwars %>%
      select(name:homeworld) %>%
      arrange(desc(height)) %>%
      datatable(rownames = input$show_rownames,
                extensions = "Responsive")
  })
  
  output$star_list <- renderDT({
    starwars %>%
      select(name,films:starships) %>%
      datatable(rownames = FALSE)
  })
}