###################
# body.R
###################
body <- dashboardBody(tabItems(
  
  ########################
  # Dashboard Tab ----
  ########################
  tabItem(tabName = "dashboard",
          fluidPage(h2("Dashboard View"))),
  
  ########################
  # Linear Regression Tab ----
  ########################
  tabItem(
    tabName = "tab_linear_regression",
    fluidPage(
      titlePanel("Simple Linear Regression"),
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
  
  ########################
  # Linear Regression Tab ----
  ########################
  
  tabItem(tabName = "tab_about_me",
          fluidPage(
            h2("About Me"),
            h4(
              tags$a(href = "https://www.github.com/PawanRamaMali", "GitHub Link")
            ),
            h4(
              tags$a(href = "https://pawanramamali.github.io/", "Website Link")
            )
                    ))
  
  
  
))