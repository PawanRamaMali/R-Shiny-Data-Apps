fluidPage(
  sliderInput("exponent",
              label = "Choose an exponent ",
              min = 1,
              max = 5,
              value = 2),
  plotOutput("curve_plot")
)
