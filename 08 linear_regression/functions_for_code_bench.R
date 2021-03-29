
Default_AceEditor_Python_Code <- function(){
  return("\nimport pandas as pd\ndata = [1,2,3,4,5]\ndf = pd.DataFrame(data)\nprint(df)")
}

Default_AceEditor_R_Code <- function(){
  return("\n # Create the data for the chart  
H <- c(7,12,28,3,41)
M <- c('Mar','Apr','May','Jun','Jul')
# Plot the bar chart 
barplot(H,names.arg=M,xlab='Month',ylab='Revenue',col='blue',
main='Revenue chart',border='red')")
}

Generate_Rmarkdown_Python_Content <- function(content){
  rmd_content <- paste0("Output
```{python py-code,echo=FALSE  ,exercise=TRUE}\n",content, "\n```")
  trimws(rmd_content, whitespace = "[\t\r]")
  return(rmd_content)
}

Generate_Rmarkdown_R_Content <- function(content){
  rmd_content <- paste0("Output
```{r r-code,echo=FALSE  ,exercise=TRUE}\n",content, "\n```")
  trimws(rmd_content, whitespace = "[\t\r]")
  return(rmd_content)
}


Build_Rmarkdown_File <- function(rmd_content,fileName){
  # print(rmd_content)
  # print(fileName)
  rcon <- file(fileName, "w")
  cat(rmd_content, file = rcon)
  
  close(rcon)
}

Build_Markdown_File <- function(fileName){
    return(sapply(fileName, knit, quiet = T))
}

# Show_Code_Output <- function(type,Code_File){
#   return(output$type <- renderUI(withMathJax(includeMarkdown(
#     Build_Markdown_File(Code_File)
#   ))))
# }
#   