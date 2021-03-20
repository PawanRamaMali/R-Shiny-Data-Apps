#### vb style -----------------
VB_style <- function(msg = 'Hello', style = "font-size: 100%;") {
  tags$p(msg , style = style)
}

## rgb to hex function---------------
GetColorHexAndDecimal <- function(color)
{
  c <- col2rgb(color)
  sprintf("#%02X%02X%02X %3d %3d %3d", c[1], c[2], c[3], c[1], c[2], c[3])
}


# Function to call in place of dropdownMenu --------------
customSentence <- function(numItems, type) {
  paste("Feedback & suggestions")
}

customSentence_share <- function(numItems, type) {
  paste("Love it? Share it!")
}

##
dropdownMenuCustom <-
  function (...,
            type = c("messages", "notifications", "tasks"),
            badgeStatus = "primary",
            icon = NULL,
            .list = NULL,
            customSentence = customSentence)
  {
    type <- match.arg(type)
    if (!is.null(badgeStatus))
      shinydashboard:::validateStatus(badgeStatus)
    items <- c(list(...), .list)
    lapply(items, shinydashboard:::tagAssert, type = "li")
    dropdownClass <- paste0("dropdown ", type, "-menu")
    if (is.null(icon)) {
      icon <- switch(
        type,
        messages = shiny::icon("envelope"),
        notifications = shiny::icon("warning"),
        tasks = shiny::icon("tasks")
      )
    }
    numItems <- length(items)
    if (is.null(badgeStatus)) {
      badge <- NULL
    }
    else {
      badge <- tags$span(class = paste0("label label-", badgeStatus),
                         numItems)
    }
    tags$li(
      class = dropdownClass,
      a(
        href = "#",
        class = "dropdown-toggle",
        `data-toggle` = "dropdown",
        icon,
        badge
      ),
      tags$ul(
        class = "dropdown-menu",
        tags$li(class = "header",
                customSentence(numItems, type)),
        tags$li(tags$ul(class = "menu", items))
      )
    )
  }