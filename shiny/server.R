library(shiny)
library(dplyr)
library(ggplot2)
library(gdata)
library(tidyr)

link <- 'http://www.serasaexperian.com.br/release/indicadores/ftp/facons.zip'
tmp <- tempfile()
tmpd <- tempdir()
download.file(link, tmp)
unzip(tmp, exdir=tmpd)
dados <- read.xls(paste(tmpd, 'FACONS.xls', sep='/'), sheet=1, encoding='latin1', as.is=T)
file.remove(tmp, paste(tmpd, 'FACONS.xls', sep='/'))

dados <- dados[-c(1,2,3,4),-length(dados)]
names(dados) <- c('data',
                  'fal_req_micro','fal_req_med','fal_req_grande','fal_req_total',
                  'fal_dec_micro','fal_dec_med','fal_dec_grande','fal_dec_total',
                  'rec_req_micro','rec_req_med','rec_req_grande','rec_req_total',
                  'rec_def_micro','rec_def_med','rec_def_grande','rec_def_total',
                  'rec_concedidas_total','conc_req','conc_def')

legenda <- data_frame(tipo=c('fal_req', 'fal_dec', 'rec_req', 'rec_def'),
                      labs=c('Falências requeridas', 'Falências decretadas', 'Recuperações requeridas', 'Recuperações deferidas'))

shinyServer(function(input, output, session) {
  
  d <- reactive({
    tbl_df(dados) %>% 
      mutate_each(funs(as.numeric(gsub('[^0-9]', '', .))), -data) %>%
      mutate(data=as.Date(paste0(data,'-01'), format="%B-%y-%d")) %>%
      select(-matches('conc')) %>%
      gather(tipo, valor, -data) %>%
      mutate(porte=gsub('[a-z]{3}_[a-z]{3}_', '', tipo), tipo=gsub('_[a-z]+$', '', tipo)) %>%
      inner_join(legenda, 'tipo') %>%
      filter(data >= as.Date(input$corte_temporal[1]),
             data <= as.Date(input$corte_temporal[2])) %>%
      filter(porte %in% input$porte)
  })
  
  output$grafico <- renderPlot({
    d() %>%
      filter(data >= as.Date('2005-01-01')) %>%
      ggplot(aes(x=data, y=valor, colour=porte)) +
      facet_wrap(~labs, scale='free_y') +
      geom_line() +
      theme_bw()
  })  
  
})