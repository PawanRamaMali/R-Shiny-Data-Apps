library(shiny)


shinyUI(fluidPage(# Application title
    titlePanel("Code Bench"),
    
    mainPanel(tabsetPanel(
        tabPanel(
            "Python Code Bench",
            br(),
            br(),
            
            
            # * Execute Python Code Button ----
            actionButton(
                inputId = "Button_Execute_Python_Code",
                label = "  Execute",
                icon = shiny::icon("play")
            ),
            
            # * Reset Python Code Button ----
            actionButton(
                inputId = "Button_Reset_Python_Code",
                label = "Reset All",
                icon = shiny::icon("trash-alt")
            ),
            # * Python Code Settings Button ----
            actionButton(
                inputId = "Button_Show_Python_Settings",
                label = "Settings",
                icon = shiny::icon("cog")
            ),
            
            br(),
            br(),
            
            # *  Python Code Editor ----
            column(
                6,
                shinyAce::aceEditor(
                    outputId = "Python_Code_editor",
                    theme = "chrome",
                    mode = "python",
                    height = "600px",
                    tabSize = 4,
                    selectionId = "selection",
                    value = Default_AceEditor_Python_Code(),
                    placeholder = "type your code here..."
                )
            ),
            
            column(6,
                   #* Python Code Output ----
                   uiOutput("Python_Code_Output"))
            
            
        ),
        tabPanel(
            "R Code Bench",
            br(),
            br(),
            
            # * Execute R Code Button ----
            
            actionButton(
                inputId = "Button_Execute_R_Code",
                label = "  Execute",
                icon = shiny::icon("play")
            ),
            actionButton(
                inputId = "Button_Reset_R_Code",
                label = "Reset All",
                icon = shiny::icon("trash-alt")
            ),
            actionButton(
                inputId = "Button_Show_R_Settings",
                label = "Settings",
                icon = shiny::icon("cog")
            ),
            
            br(),
            br(),
            
            # * R Code Editor ----
            column(
                6,
                shinyAce::aceEditor(
                    outputId = "R_Code_editor",
                    theme = "chrome",
                    mode = "r",
                    height = "600px",
                    tabSize = 4,
                    selectionId = "selection",
                    value = Default_AceEditor_R_Code(),
                    placeholder = "type your code here..."
                )
            ),
            
            column(6,
                   #* R Code Output ----
                   uiOutput("R_Code_Output"))
        )
        
        
    ))))
