library("DT")

navbarPage(
  "DT Interactive Tables",
  tabPanel(
    "Star Narrow",
    fluidPage(
      DTOutput("star_narrow")
    )
  ),
  tabPanel(
    "Star Wide",
    fluidPage(
      checkboxInput("show_rownames",
                    label = "Show rownames?"),
      DTOutput("star_wide")
    )
  ),
  tabPanel(
    "Star List",
    fluidPage(
      DTOutput("star_list")
    )
  ),
  collapsible = TRUE
)