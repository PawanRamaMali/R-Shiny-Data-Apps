# body.R

body <- dashboardBody(tabItems( id = "tabs"
  # # Dashboard Tab ----
  
  # tabItem(tabName = "dashboard",
  #         fluidPage(h2("Dashboard View"))),
  
  
  
  # Data Selection Tab ----
  
  
  tabItem(tabName = "tab_data_selection",
          fluidPage(
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
              
              mainPanel(dataTableOutput("show_data"))
            )
          )),
  
  # Data Overview Tab ----
  # 
  tabItem(tabName = "tab_data_overview",
          fluidPage(
            h1("Data Overview"),
           
            chooseDataUI(id = "choose1"),
            esquisserUI(
              
              id = "esquisse",
              header = FALSE, # dont display gadget title
              choose_data = TRUE, # dont display button to change data
              container = esquisseContainer(height = "700px")
              
            )
            
          )),
  
  
  
  # Linear Regression Tab ----
  
  tabItem(
    tabName = "tab_linear_regression",
    fluidPage(
      titlePanel("Linear Regression"),
      br(),
      withMathJax(),
      
      sidebarLayout(
        sidebarPanel(
          tags$b("Data:"),
          textInput("x", "x", value = "90, 100, 90, 80, 87, 75", placeholder = "Enter values separated by a comma with decimals as points, e.g. 4.2, 4.4, 5, 5.03, etc."),
          textInput("y", "y", value = "950, 1100, 850, 750, 950, 775", placeholder = "Enter values separated by a comma with decimals as points, e.g. 4.2, 4.4, 5, 5.03, etc."),
          hr(),
          tags$b("Plot:"),
          checkboxInput("se", "Add confidence interval around the regression line", TRUE),
          textInput(
            "xlab",
            label = "Axis labels:",
            value = "x",
            placeholder = "x label"
          ),
          textInput(
            "ylab",
            label = NULL,
            value = "y",
            placeholder = "y label"
          ),
          hr(),
          
          # radioButtons("format", "Download report:", c("HTML", "PDF", "Word"),
          #              inline = TRUE),
          # checkboxInput("echo", "Show code in report?", FALSE),
          # downloadButton("downloadReport"),
          # hr(),
          
          hr()
        ),
        
        mainPanel(
          tabsetPanel(
            tabPanel(
              "Data ",
              br(),
              tags$b("Input data:"),
              DT::dataTableOutput("tbl"),
              br()
            ),
            
            tabPanel(
              "Compute parameters by Hand",
              uiOutput("data"),
              tags$b("Compute parameters by hand:"),
              uiOutput("by_hand")
            ),
            tabPanel(
              "Compute parameters ",
              tags$b("Compute parameters in R:"),
              
              verbatimTextOutput("summary")
            ),
            tabPanel(
              "Regression plot ",
              tags$b("Regression plot:"),
              uiOutput("results"),
              plotlyOutput("plot")
            ),
            tabPanel(
              "Interpretation ",
              tags$b("Interpretation:"),
              uiOutput("interpretation"),
            )
          )
          
        )
      )
    )
    
  ),
  
  
  # Correlation Tab ----
  
  
  tabItem(tabName = "tab_correlation",
          fluidPage(
            title = "Correlation Plot",
            mainPanel(
              plotlyOutput("corrplot", height = 700)
            )
          )),
  
  
  
  
  # Settings Tab ----
  
  
  tabItem(tabName = "tab_app_settings",
          fluidPage(
            title = "Settings",
            
            mainPanel(
              h1("Custom Settings"),
              hr(),
              checkboxInput("show_rownames",
                            label = "Show row numbers"),
              checkboxInput("show_features_responsive",
                            label = "Responsive Layout")
              
            )
            
            
            
          )),
  
  
  # About Me Tab ----
  
  
  tabItem(tabName = "tab_about_me",
          fluidPage(sidebarPanel(
            width = 3,
            h2("About Me"),
         
            hr(),
            h5(" I am Pawan Rama Mali"),
            h6(" I'm currently working on Software Development"),
            h6(" Also, I'm currently learning Artificial Intelligence"),
            h5(
              tags$a(href = "https://www.github.com/PawanRamaMali", "GitHub Link")
            ),
            h5(
              tags$a(href = "https://pawanramamali.github.io/", "Website Link")
            )
          )))
  
  
  
))