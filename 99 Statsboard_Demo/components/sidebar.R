###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
sidebar <- dashboardSidebar(
  sidebarMenu(

   # menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Data Selection", tabName = "tab_data_selection", icon = icon("table")),
    menuItem("Data Overview", tabName = "tab_data_overview", icon = icon("database")),
    menuItem("Linear Regression", tabName = "tab_linear_regression", icon = icon("chart-line")),
    menuItem("Correlation", tabName = "tab_correlation", icon = icon("project-diagram")),
    menuItem("App Settings", tabName = "tab_app_settings", icon = icon("cog")),
    menuItem("About Me", tabName = "tab_about_me", icon = icon("user"))
    
  )
)
