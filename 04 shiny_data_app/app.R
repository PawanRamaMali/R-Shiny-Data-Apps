# LIBRARIES ----

# Shiny
library(shiny)
library(bslib)

# Modeling
library(modeldata)
library(DataExplorer)

# Widgets
library(plotly)

# Core
library(tidyverse)
#if (!require("DT")) install.packages('DT')
library(DT)

# LOAD DATASETS ----
utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list = list(
    "StackOverflow" = stackoverflow,
    "Car Prices"    = car_prices,
    "Sacramento Housing" = Sacramento
)

# 1.0 USER INTERFACE ----
ui <- navbarPage(

    title = "Data Explorer",

#    theme = bslib::bs_theme(version = 4, bootswatch = "minty"),

    tabPanel(
        title = " Data Selection",

        sidebarLayout(

            sidebarPanel(
                width = 3,
                h1("Explore a Dataset"),

                shiny::selectInput(
                    inputId = "dataset_choice",
                    label   = "Data Connection",
                    choices = c("StackOverflow", "Car Prices", "Sacramento Housing")
                ),

                hr(),
                
                # Moved to settings Panel
                # checkboxInput("show_rownames",
                #               label = "Show row numbers"),
                # checkboxInput("show_features_responsive",
                #               label = "Responsive Layout")
            ),

            mainPanel(
                    dataTableOutput("show_data")
             
            )
        )

    ),
    tabPanel(
        title = "Correlation Matrix",
   
        mainPanel(
            h1("Correlation"),
            plotlyOutput("corrplot", height = 700)
            
        )
        
    ),
    tabPanel(
        title = "Settings",
        
        mainPanel(
            h1("Custom Settings"),
            hr(),
            checkboxInput("show_rownames",
                          label = "Show row numbers"),
            checkboxInput("show_features_responsive",
                          label = "Responsive Layout")
            
        ), 
        shinythemes::themeSelector(),
        
    )
    


)

# 2.0 SERVER ----
server <- function(input, output) {


    rv <- reactiveValues()

    observe({
        
        if(input$show_features_responsive){
            features <-  c("Responsive")
        }
        else
            features <-  c("FixedHeader")
        
        rv$data_set <- data_list %>% pluck(input$dataset_choice)
        output$show_data <- renderDataTable({
            rv$data_set %>%
                datatable(rownames = input$show_rownames,
                          options = list(scrollX = TRUE),
                          extensions = features)
        })

    })

    output$corrplot <- renderPlotly({

        g <- DataExplorer::plot_correlation(rv$data_set)

        plotly::ggplotly(g)
    })
    


}

# Run the application
shinyApp(ui = ui, server = server)
