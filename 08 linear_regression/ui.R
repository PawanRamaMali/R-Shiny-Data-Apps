####
library(shinydashboard)
library(shiny)
library(shinyBS)
library(shinyjs)

## load functions
source('helper_functions.R')


## build ui.R -----------------------------------
## 1. header -------------------------------
header <-
  dashboardHeader(
    title = HTML("Intelligence Dashboard"),
    disable = FALSE,
    titleWidth  = 550
    
  )

header$children[[2]]$children[[2]] <-
  header$children[[2]]$children[[1]]
header$children[[2]]$children[[1]] <-
  tags$a(
    href = 'http://https://github.com/PawanRamaMali',
    tags$img(
      src = 'www/artificial-intelligence-logo.png',
      height = '67',
      width = '228.6',
      align = 'left'
    ),
    target = '_blank'
  )



## 2. siderbar ------------------------------
siderbar <-
  dashboardSidebar(
    width = 200,
    sidebarMenu(
      id = 'sidebar',
      style = "position: relative; overflow: visible;",
      
      ## 1st tab show the Main dashboard -----------
      menuItem(
        "Main Dashboard",
        tabName = 'dashboard',
        icon = icon('dashboard')
      )
      
    )
  )

## 3. body --------------------------------
body <- dashboardBody(
  ## 3.0. CSS styles in header ----------------------------
  tags$head(
    ## modify the dashboard's skin color
    tags$style(
      HTML(
        '
                       /* logo */
                       .skin-blue .main-header .logo {
                       background-color: #00b2e3;
                       }

                       /* logo when hovered */
                       .skin-blue .main-header .logo:hover {
                       background-color: #00b2e3;
                       }

                       /* navbar (rest of the header) */
                       .skin-blue .main-header .navbar {
                       background-color: #00b2e3;
                       }

                       /* active selected tab in the sidebarmenu */
                       .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                       background-color: #00b2e3;
                                 }
                       '
      )
    ),
    
    ## modify icon size in the sub side bar menu
    tags$style(
      HTML(
        '
                       /* change size of icons in sub-menu items */
                      .sidebar .sidebar-menu .treeview-menu>li>a>.fa {
                      font-size: 15px;
                      }

                      .sidebar .sidebar-menu .treeview-menu>li>a>.glyphicon {
                      font-size: 13px;
                      }

                      /* Hide icons in sub-menu items */
                      .sidebar .sidebar-menu .treeview>a>.fa-angle-left {
                      display: none;
                      }
                      '
      )
    ) ,
    
    tags$style(HTML("hr {border-top: 1px solid #000000;}")),
    
    ## to not show error message in shiny
    tags$style(HTML(
      ".shiny-output-error { visibility: hidden; }"
    )),
    tags$style(HTML(
      ".shiny-output-error:before { visibility: hidden; }"
    )),
    
    ## head dropdown menu size
    
    tags$style(
      HTML(
        '.navbar-custom-menu>.navbar-nav>li:last-child>.dropdown-menu { width:10px; font-size:10px; padding:1px; margin:1px;}'
      )
    ),
    tags$style(
      HTML(
        '.navbar-custom-menu> .navbar-nav> li:last-child > .dropdown-menu > h4 {width:0px; font-size:0px; padding:0px; margin:0px;}'
      )
    ),
    tags$style(
      HTML(
        '.navbar-custom-menu> .navbar-nav> li:last-child > .dropdown-menu > p {width:0px; font-size:0px; padding:0px; margin:0px;}'
      )
    )
  ),
  
  ## 3.1 Dashboard body --------
  tabItems(## 3.1 Main dashboard --------------
           tabItem(
             tabName = 'dashboard',
             ## contents for the dashboard tab
             div(id = 'main_wait_message',
                 h1() ,
                 tags$hr()),
             
             fluidRow(),
             
             h2(paste0("Dashboard Content")),
             fluidRow(),
             
           ))
)



## put UI together ----------
ui <-
  dashboardPage(header, siderbar, body)
