library(shiny)
library(dplyr)
library(ggplot2)
library(falrec)

dados <- ler_dados()

shinyServer(function(input, output, session) {
  
  d <- reactive({
    dados %>%
      filter(data >= as.Date(input$corte_temporal[1]),
             data <= as.Date(input$corte_temporal[2])) %>%
      filter(porte %in% input$porte)
  })
  
  output$grafico <- renderPlot({
    d() %>%
      filter(data >= as.Date('2005-01-01')) %>%
      mutate(data = as.Date(data)) %>% 
      ggplot(aes(x = data, y = valor, colour = porte)) +
      facet_wrap(~labs, scale = 'free_y') +
      geom_line() +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })  
  
})