library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPagePlus(
    header = dashboardHeaderPlus(
      fixed = TRUE,
      title = tagList(
        tags$head(tags$style(".main-header .logo { float:left; overflow: visible;display:block;}")),
        img(src = "ai-logo.png", height = "50px",width="230px"),
        span(class = "logo-lg", "shinydashboardPlus")), 
      enable_rightsidebar = TRUE,
      rightSidebarIcon = "gears",
      left_menu = tagList(
        dropdownBlock(
          id = "mydropdown",
          title = "Menu with Dropdown 1",
          icon = icon("sliders"),
          sliderInput(
            inputId = "n",
            label = "Number of observations",
            min = 10, max = 100, value = 30
          ),
          prettyToggle(
            inputId = "na",
            label_on = "NAs keeped",
            label_off = "NAs removed",
            icon_on = icon("check"),
            icon_off = icon("remove")
          )
        ),
        dropdownBlock(
          id = "mydropdown2",
          title = "Menu with Dropdown 2",
          icon = icon("sliders"),
          prettySwitch(
            inputId = "switch4",
            label = "Fill switch with status:",
            fill = TRUE,
            status = "primary"
          ),
          prettyCheckboxGroup(
            inputId = "checkgroup2",
            label = "Click me!",
            thick = TRUE,
            choices = c("Click me !", "Me !", "Or me !"),
            animation = "pulse",
            status = "info"
          )
        )
      )
    ),
    sidebar = dashboardSidebar(),
    body = dashboardBody(
      setShadow(class = "dropdown-menu")
      
    ),
    rightsidebar = rightSidebar(),
    title = "DashboardPage"
  ),
  server = function(input, output) { }
)