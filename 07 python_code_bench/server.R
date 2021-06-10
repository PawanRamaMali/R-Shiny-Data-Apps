library(shiny)
library(knitr)
library(shinyAce)

print(getwd())
#setwd(paste0(getwd(),"/07 python_code_bench/Python_Code_Bench/"))

source('functions_for_code_bench.R')

shinyServer(function(input, output, session) {
    
    Run_Python_Script <- function(value=NULL) {
        
        if (is.null(value))
            Python_Code <- input$Python_Code_editor
        else
            Python_Code <- as.character(value)
        print(Python_Code)
        Rmarkdown_Content <-
            Generate_Rmarkdown_Python_Content(Python_Code)
        Rmd_Code_File <-  "Py_Code.Rmd"
        
        Build_Rmarkdown_File(Rmarkdown_Content, Rmd_Code_File)
        
        output$Python_Code_Output <-
            renderUI(withMathJax(includeMarkdown(
                Build_Markdown_File(Rmd_Code_File)
            )))
    }
    
    Run_R_Script <- function(value=NULL) {
        if (is.null(value))
            R_Code <- input$R_Code_editor
        else
            R_Code <- as.character(value)
        Rmarkdown_Content <- Generate_Rmarkdown_R_Content(R_Code)
        Rmd_Code_File <-  "R_Code.Rmd"
        Build_Rmarkdown_File(Rmarkdown_Content, Rmd_Code_File)
        
        
        # Show_Code_Output(R_Code_Output,Rmd_Code_File)
        
        output$R_Code_Output <-
            renderUI(withMathJax(includeMarkdown(
                Build_Markdown_File(Rmd_Code_File)
            )))
        
    }
    # * Execute Python Code ----
    observeEvent(input$Button_Execute_Python_Code, {
        Run_Python_Script()
    })
    
    # * Execute R Code ----
    observeEvent(input$Button_Execute_R_Code, {
        Run_R_Script()
    })
    
    
    # * Reset Python CodeEditor ----
    observeEvent(input$Button_Reset_Python_Code, {
        updateAceEditor(session, "Python_Code_editor", value = "")
        print("Inside Reset observe")
        Run_Python_Script(" ")
    })
    
    # * Reset R CodeEditor ----
    observeEvent(input$Button_Reset_R_Code, {
        updateAceEditor(session, "R_Code_editor", value = "")
        Run_R_Script(" ")
    })
    
    
})
