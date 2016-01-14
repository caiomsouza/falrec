library(shiny)

fluidPage(
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(inputId = 'corte_temporal', 
                     label = 'Corte temporal', 
                     min = '2000-01-01', 
                     max = lubridate::ceiling_date(lubridate::today(), 'month'), 
                     start = '2008-01-01', 
                     end = lubridate::ceiling_date(lubridate::today(), 'month'), 
                     format = 'mm/yyyy', 
                     separator = 'até', 
                     language = 'pt-BR'),
      checkboxGroupInput('porte', 
                         label = 'Porte', 
                         c('Micro' = 'micro', 'Médio' = 'med', 
                           'Grande' = 'grande', 'Total' = 'total'),
                         c('Micro' = 'micro', 'Médio' = 'med', 
                           'Grande' = 'grande', 'Total' = 'total'))),
  mainPanel(plotOutput('grafico'))
))