library(shiny)
library(ggplot2)

require(markdown)

fluidPage(
  navbarPage("Airline Passengers Predictor",
             tabPanel("Predict",
                      #titlePanel("Airline Passengers Predictor"),
                      
                      sidebarPanel(
                        
                        sliderInput('year', 'Year Range of Training Set', min=1949, max=1960,
                                    value=c(1949, 1960), step=1, round=0, sep=""),
                        
                        sliderInput('forcast_months', 'Months to Forecast', min=0, max=36,
                                    value=5, step=1, round=0),
                        
                        checkboxInput('showerr', 'Display Error Bounds'),
                        checkboxInput('showlegend', 'Display Legend')
                        
                        #actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                        #actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                        
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel( p(icon("line-chart"), "Prediction Graph"),
                                    
                                    h3('Predicted Series for Airline Passengers', align = "left"),
                                    plotOutput('plot')),
                          
                          tabPanel(p(icon("table"), "Data Table"),
                                   h3('Training Dataset', align = "left"),
                                   tableOutput('dataset'),
                                   
                                   h3('Predicted Dataset', align = "left"),
                                   tableOutput('forecast'))
                          
                        )
                      )
             ),
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("include.md")
                      ))
  )
)