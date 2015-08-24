library(shiny)

fluidPage(
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(inputId='corte_temporal', label='Corte temporal', 
                     min='2000-01-01', max='2014-10-01', 
                     start='2008-01-01', end='2014-10-01', 
                     format='mm/yyyy', separator='até', language='pt-BR'),
      checkboxGroupInput('porte', label='Porte', 
                         c('Micro'='micro', 'Médio'='med', 'Grande'='grande', 'Total'='total'),
                         c('Micro'='micro', 'Médio'='med', 'Grande'='grande', 'Total'='total'))),
  mainPanel(plotOutput('grafico'))
))