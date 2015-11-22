library(shiny)
library(ggplot2)

library(rCharts)

dataset <- AirPassengers


function(input, output, session) {
  values <- reactiveValues()
  
  dataset <- reactive({
    
    window(AirPassengers, start = c(input$year[1],1), end = c(input$year[2],12))
    
  })
  
  fore <- reactive({
    fit <- arima(dataset(), order=c(1,0,0), list(order=c(2,1,0), period=12), method="ML")
    predict(fit, n.ahead=input$forcast_months[1])
  })
  
  observeEvent( input$showerr, {
    values$err <- input$showerr
  })
  
  observeEvent( input$showlegend, {
    values$legend <- input$showlegend
  })
  
  output$dataset <- renderTable(dataset())
  output$forecast <- renderTable(fore()$pred)
  
  
  output$plot<- renderPlot({
    forecast <- fore()
    if(values$err) 
    {
      U <- forecast$pred + 2*forecast$se
      L <- forecast$pred - 2*forecast$se
      
      
      ts.plot(dataset(),forecast$pred,U, L,col=c(1,2,4,4),lty=c(1,1,2,2),  xlab = "Year",  ylab = "No. Of Passengers")
      if(input$showlegend)
        legend("topleft", c("Training", "Forecast", "Error Bounds"),col =c(1,2,4),lty=c(1,1,2))
    }
    else
    {
      ts.plot(dataset(),forecast$pred,col=c(1,2),lty=c(1,1),  xlab = "Year",  ylab = "No. Of Passengers")
      if(input$showlegend)
        legend("topleft", c("Training", "Forecast"),col =c(1,2),lty=c(1,1))
    }
  })
}
