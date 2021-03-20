#### Libraries 

library(shinydashboard)
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(highcharter)
library(lubridate)
library(DT)
library(shinyBS)
library(shinyjs)
library(shinycssloaders)


# load data

## load functions
source('helper_functions.R')


## Build ui.R ----
## 1. Header ----
header <-
  dashboardHeader(
    title = HTML("AI Dashboard"),
    disable = FALSE,
    titleWidth  = 550,
    dropdownMenuCustom(
      type = 'message',
      customSentence = customSentence,
      messageItem(
        from = "prm@outlook.in",
        #'Feedback and suggestions',
        message =  "",
        icon = icon("envelope"),
        href = "mailto:prm@outlook.in"
      ),
      icon = icon('comment')
    ),
    dropdownMenuCustom(
      type = 'message',
      customSentence = customSentence_share,
      icon = icon("share-alt"),
      messageItem(
        from = 'Twitter',
        message = "",
        icon = icon("twitter"),
        href = "https://twitter.com/PawanRamaMali"
      ),
      messageItem(
        from = 'Facebook',
        message = "",
        icon = icon("facebook"),
        href = "https://www.facebook.com/pawanrm"
      ),
      messageItem(
        from = 'LinkedIn',
        message = "",
        icon = icon("linkedin"),
        href = "http://www.linkedin.com/in/PawanRamaMali"
      )
    )
    
  )

header$children[[2]]$children[[2]] <-
  header$children[[2]]$children[[1]]
header$children[[2]]$children[[1]] <-
  tags$a(
    href = 'http://github.com/PawanRamaMali',
    tags$img(
      src = 'ai-logo.png',
      height = '67',
      width = '228.6',
      align = 'left'
    ),
    target = '_blank'
  )



## 2. Siderbar ----
siderbar <-
  dashboardSidebar(
    width = 200,
    sidebarMenu(
      id = 'sidebar',
      style = "position: relative; overflow: visible;",

      ## 1st tab show the Main dashboard ----
      menuItem(
        "Main Dashboard",
        tabName = 'dashboard',
        icon = icon('dashboard')#,
        #badgeLabel = maxYear_lb,
        #badgeColor = "green"
      ),
      
      
      ## 2nd Second tab shows Input ----
      menuItem(
        "Input",
        tabName = 'input_data_tab',
        icon = icon('database')
      ),
      div(id = 'sidebar_cr',),
      
      ## 3rd tab shows data ----
      menuItem(
        "View Data",
        tabName = "commodity_intel",
        icon = icon('barcode'),
        startExpanded = F,
        menuSubItem(
          'Exports',
          tabName = "ci_exports",
          icon = icon('export', lib = 'glyphicon')
        ),
        menuSubItem(
          'Imports',
          tabName = "ci_imports",
          icon = icon('import', lib = 'glyphicon')
        ),
        menuSubItem(
          'Data code',
          tabName = "ci_intel_by_hs",
          icon = icon("bolt")
        )
      ),
      
     
      useShinyjs(),
      
      
      
      
      ## 5th tab Data source, definition , i.e., help ----
      menuItem(
        "FAQs",
        tabName = 'help',
        icon = icon('question-circle')
      ),
      
      ## 6th tab Update ----
      menuItem(
        "Previous Releases",
        tabName = 'monthly_update',
        icon = icon('bell')#,
        # badgeLabel = "new",
        # badgeColor = "green"
      )
    )
  )

## 3. body --------------------------------
body <- dashboardBody(
  ## 3.0. CSS styles in header ----------------------------
  tags$head(
    #tags$script(src = "world.js" ),
    tags$script("document.title = 'AI Dashboard'"),
    
    ### Styles
    tags$style(HTML(".small-box {height: 65px}")),
    tags$style(HTML(".fa { font-size: 15px; }")),
    tags$style(HTML(".glyphicon { font-size: 33px; }")),
    ## use glyphicon package
    tags$style(HTML(".fa-dashboard { font-size: 20px; }")),
    tags$style(HTML(".fa-globe { font-size: 20px; }")),
    tags$style(HTML(".fa-barcode { font-size: 20px; }")),
    tags$style(
      HTML(".tab-content { padding-left: 20px; padding-right: 30px; }")
    ) ,
    tags$style(HTML(".fa-wrench { font-size: 15px; }")),
    tags$style(HTML(".fa-refresh { font-size: 15px; }")),
    tags$style(HTML(".fa-search { font-size: 15px; }")),
    tags$style(HTML(".fa-comment { font-size: 20px; }")),
    tags$style(HTML(".fa-share-alt { font-size: 20px; }")),
    tags$style(HTML(".fa-envelope { font-size: 20px; }")),
    tags$style(HTML(".fa-question-circle { font-size: 20px; }")),
    tags$style(HTML(
      ".fa-chevron-circle-down { font-size: 15px; }"
    )),
    tags$style(HTML(".fa-bell { font-size: 17px; }")),
    tags$style(HTML(".fa-check { font-size: 14px; }")),
    tags$style(HTML(".fa-times { font-size: 14px; }")),
    
    #tags$style(HTML(".fa-twitter { font-size: 10px; color:red;}")),
    #tags$style(HTML(".fa-facebook { font-size: 10px; color:red;}")),
    #tags$style(HTML(".fa-google-plus { font-size: 10px; color:red;}")),
    #tags$style(HTML(".fa-pinterest-p { font-size: 10px; color:red;}")),
    #tags$style(HTML(".fa-linkedin { font-size: 10px; color:red;}")),
    #tags$style(HTML(".fa-tumblr { font-size: 10px; color:red;}")),
    
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
    
    ## heand dropdown menu size
    #tags$style(HTML('.navbar-custom-menu>.navbar-nav>li>.dropdown-menu { width:100px;}'))
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
  
  ## 3.1 Dashboard body --------------
  tabItems(
    ## 3.1 Main dashboard ----------------------------------------------------------
    tabItem(
      tabName = 'dashboard',
      ## contents for the dashboard tab
      div(id = 'main_wait_message',
          h1() ,
          tags$hr()),
      
      fluidRow(),
      
      h2(paste0("Goods")),
      fluidRow(),
      
      h2(paste0("Services")),
      fluidRow() ,
      
      ## 1.2 Time serise plot ----------------------------------------
      h2(paste0("Products")),
      fluidRow(),
      
      
      
    ),
    
    ## 3.2.1 Export/import  ------------------------
    tabItem(
      tabName = 'ci_exports',
      ## 2.1 Help text first --------------
      div(id = 'ci_howto_ex'#,
         # howto_ci()
          ),
      
      ## 3... wait message ------
      hidden(div(
        id = 'wait_message_ci_ex',
        h2("I am preparing the report now and only for you .....")
      )),
      
      ## divs for pre-defined commodity groups -----------------
      tags$div(id = 'body_ex') ,
      tags$div(id = 'body_growth_ex') ,
      shinyjs::hidden(div(
        id = "body_ci_market_loading_message",
        tags$hr(),
        tags$h1("Generating reports...", align = "center")
      )),
      tags$div(id = 'body_ci_markets_ex'),
      
      
      ## divs for self-defined commodity groups -----------------
      tags$div(id = 'body_ex_self_defined') ,
      tags$div(id = 'body_growth_ex_self_defined') ,
      shinyjs::hidden(
        div(
          id = "body_ci_market_loading_message_self_define",
          tags$hr(),
          tags$h1("Generating reports...", align = "center")
        )
      ),
      tags$div(id = 'body_ci_markets_ex_self_defined')
      
    ),
    
    ## 3.2.2 Export/import commodities/services intelligence ------------------------
    tabItem(
      tabName = 'ci_imports',
      ## 3.1 Help text first ---------------------
      div(id = 'ci_howto_im'#,
         # howto_ci()
          ),
      
      ## 3... wait message ------
      hidden(div(
        id = 'wait_message_ci_im',
        h2("I am preparing the report now and only for you .....")
      )),
      
      ## 3.1 div for pre-defined HS group reports ----------------------
      tags$div(id = 'body_im') ,
      tags$div(id = 'body_growth_im') ,
      tags$div(id = 'body_ci_markets_im'),
      
      ## 3.x div for self-defined HS group reports ----------------------
      tags$div(id = 'body_im_self_defined') ,
      tags$div(id = 'body_growth_im_self_defined') ,
      tags$div(id = 'body_ci_markets_im_self_defined')
    ),
    
    
    ## 3.2.3 Quick Intel by HS codes ---------------
    tabItem(
      tabName = 'ci_intel_by_hs',
      tags$div(id = 'ci_intel_by_hs_hstable' ,
               fluidRow(
                 h1("Quick export/import by using HS codes"),
                 h3("")#,
                 # howto_hs_finder()
               ))#,
      ,
      div(
        id = 'clear_table'
        #tags$hr(),
        #tags$h3( "Click on the 'Show more details' button to display addtional information on free trade agreements, and imports/exports by commodities and markets." ),
        #actionButton()
      )
      ,
      shinyjs::hidden(div(
        id = "ci_intel_hs_loading_message",
        tags$hr(),
        tags$h1("Generating reports...", align = "center")
      ))
      ,
      tags$div(id = "ci_intel_by_hs_toadd")
      ,
      shinyjs::hidden(
        div(
          id = "ci_intel_hs_loading_message_intl",
          tags$hr(),
          tags$h1("Generating reports...", align = "center")
        )
      )
      ,
      tags$div(id = "ci_intel_by_hs_toadd_intl")
    ),
    
    ## 3.3 country intellgence -----------------------------------------------------
    tabItem(
      tabName = 'input_data_tab',
      ## 3.3.1 Help text first --------------
      div(id = 'country_howto'#,
      #    howto_country()
          ) ,
      
      
      
      ## 3... div to holder created UIs ------
      tags$div(id = 'country_name'),
      tags$div(id = 'country_info'),
      tags$div(id = 'country_trade_summary'),
      tags$div(id = 'country_appendix')
    ),
    
    
    
    ## 3.5 Help and info -------------------------------
    tabItem(
      tabName = 'help',
      ## 3.5.1 Data sources ---------------
      div(id = 'help_contact'#,
        #  contact()
          ),
      
      div(id = 'help_data_source',
          #data_source()
          )
      
    
    ),
    
    ## 3.6 Monthly update from Stats NZ --------------
    tabItem(tabName = 'monthly_update',
            div(id = 'monthly_update',
                fluidRow(
                  #htmlOutput('MonthlyUpdate')
                )))
  )
)



## put UI together --------------------
ui <-
  dashboardPage(header, siderbar, body)
