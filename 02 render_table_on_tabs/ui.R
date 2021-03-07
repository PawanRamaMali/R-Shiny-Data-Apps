navbarPage(
  "shiny::renderTable",
  tabPanel(
    "Star Narrow",
    fluidPage(
      sliderInput("height_limit_star_narrow",
                  label = "Height limit",
                  min = 66,
                  max = 264,
                  value = 180),
      tableOutput("star_narrow")
    )
  ),
  tabPanel(
    "Star Wide",
    fluidPage(
      sliderInput("height_limit_star_wide",
                  label = "Height limit",
                  min = 66,
                  max = 264,
                  value = 180),
      tableOutput("star_wide")
    )
  ),
  tabPanel(
    "Star List",
    fluidPage(
     tableOutput("star_lists") 
    )
  ),
  collapsible = TRUE
)