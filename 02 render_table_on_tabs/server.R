library("tidyverse")

function(input, output, session){
  
  output$star_narrow <- renderTable({
    
    starwars %>%
      select(name, species, homeworld, height) %>%
      filter(height <= input$height_limit_star_narrow) %>%
      arrange(desc(height))
    
  }, striped = TRUE,
  hover = TRUE,
  na = "[MISSING]")
  
  output$star_wide <- renderTable({
    
    starwars %>%
      select(name:species) %>%
      filter(height <= input$height_limit_star_wide) %>%
      arrange(desc(height))
    
  })
  
  output$star_lists <- renderTable({
    
    starwars %>%
      select(name, films, vehicles, starships) %>%
      mutate_if(is.list, list(~map_chr(.,~paste(.x, collapse = '<br>'))))
    
  }, width = "100%",
  sanitize.text.function = identity)
  
}