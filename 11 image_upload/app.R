library(shiny)
library(EBImage)  
upload_image <- list()

ui <- fluidPage(
  fileInput("file1", "Upload an Image"),
  plotOutput("img")
)

server <- function(input, output) {
  output$img <- renderPlot({ 
    req(input$file1)
    upload_image[[1]] <- readImage(input$file1$datapath)
    plot(upload_image[[1]])
  })
}


shinyApp(ui , server)