
loginpage <- div(id = "loginpage", style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
                 wellPanel(
                   style = "background-color: transparent;",
                   tags$h2("LOG IN", class = "text-center", style = "padding-top: 0;color:#333; font-weight:600;"),
                   textInput("login_username", placeholder="Username", label = tagList(icon("user"), "Username")),
                   passwordInput("login_password", placeholder="Password", label = tagList(icon("unlock-alt"), "Password")),
                   br(),
                   div(
                     style = "text-align: center;",
                     actionButton("login", "SIGN IN", style = "color: white; background-color:#3c8dbc;
                                  padding: 10px 15px; width: 150px; cursor: pointer;
                                  font-size: 18px; font-weight: 600;"),
                     shinyjs::hidden(
                       div(id = "nomatch",
                           tags$p("Oops! Incorrect username or password!",
                                  style = "color: red; font-weight: 600; 
                                  padding-top: 5px;font-size:16px;", 
                                  class = "text-center"))),
                     br(),
                     br(),
                     tags$code("Username: admin  Password: admin"),
                     br(),
                     tags$code("Username: guest  Password: guest")
                   ))
)

server <- function(input, output, session) {
  
  USER <- reactiveValues(login = FALSE)
  
  observe({ 
    if (USER$login == FALSE) {
      if (!is.null(input$login)) {
        if (input$login > 0) {
          username <- isolate(input$login_username)
          password <- isolate(input$login_password)
          user_list <- read_yaml("user_config.yaml")
          if (! is.null(user_list[[username]])) {
            pasmatch  <- user_list[[username]]$passwd
            pasverify <- password_verify(pasmatch, password)
            if (pasverify) {
              USER$login <- TRUE
              USER$username <- username
              USER$config  <- user_list[[username]]
              shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
            } else {
              shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
              shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
            }
          } else {
            shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
            shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
          }
        } 
      }
    }    
  })
  
  output$logoutbtn <- renderUI({
    req(USER$login)
    tags$li(a(icon("fa fa-sign-out"), "Logout", 
              href="javascript:window.location.reload(true)"),
            class = "dropdown", 
            style = "background-color: #eee !important; border: 0;
            font-weight: bold; margin:5px; padding: 10px;")
  })
  
  output$sidebarpanel <- renderUI({
    if (USER$login == TRUE ){ 
      sidebarMenu(
        menuItem("Main Page", tabName = "dashboard", icon = icon("dashboard")),
        if (USER$config$role %in% c('admin')) {
          menuItem("Admin Center", tabName = "photo_editor", icon = icon("dashboard"))
        }
      )
    }
  })
  
  output$body <- renderUI({
    if (USER$login == TRUE ) {
      tabItem(
        tabName ="dashboard", class = "active",
        fluidRow(
          box(width = 6,
              passwordInput("main_passwd1", "Enter Password"),
              passwordInput("main_passwd2", "Repeat Password"),
              actionButton("main_update_passwd", "Update Password")),
          box(width = 12, dataTableOutput('results'))
        )
      )
    } else {
      div(id = "main_frame",
          style = paste("width: 100%",
                        "height: 1080px",
                        "max-width: 100%",
                        "margin: 0",
                        "padding: 0px",
                       # "background-image: url('.jpg')",
                        "",
                        sep = ";"),
          loginpage
      )
    }
  })
  
  output$results <-  DT::renderDataTable({
    if (USER$config$role == "admin" | "all" %in% USER$config$iris) {
      iris_df <- iris
    } else {
      iris_df <- iris[iris$Species %in% USER$config$iris, ]
    }
    datatable(iris_df, options = list(autoWidth = TRUE,
                                      searching = FALSE))
  })
  

# Update Password -------------------------------------------------

  observeEvent(input$main_update_passwd, {
    if (input$main_passwd1 == "") {
      showNotification("Empty password Updated", type = "error")
    } else if (input$main_passwd1 != input$main_passwd2) {
      showNotification("Different passwords.", type = "error")
    } else if (input$main_passwd1 == input$main_passwd2) {
      USER$user$passwd <- password_store(input$main_passwd1)
      temp_list <- read_yaml("user_config.yaml")
      temp_list[[USER$username]]$passwd <- USER$user$passwd
      write_yaml(temp_list, "user_config.yaml")
      showNotification("Password Updated", type = "message")
    }
  })
  
  
}
