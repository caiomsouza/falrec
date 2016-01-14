meses <- structure(list(
  mes = c("Abril", "Agosto", "Dezembro", "Fevereiro", 
          "Janeiro", "Julho", "Junho", "Maio", "Março", "Novembro", "Outubro", 
          "Setembro"), 
  mes_num = c(4, 8, 12, 2, 1, 7, 6, 5, 3, 11, 10, 9)), 
  class = c("tbl_df", "tbl", "data.frame"), 
  row.names = c(NA, -12L), .Names = c("mes", "mes_num"))

pib_seade_total <- readxl::read_excel('data-raw/06-2015_Tabelas_Site.xlsx', 
                                sheet = 2, skip = 6) %>% 
  setNames(c('mes', 'ano', 'agropecuaria', 'industria', 'servicos', 'total', 
             'pib_tot')) %>% 
  filter(!is.na(pib_tot)) %>% 
  inner_join(meses, 'mes') %>% 
  mutate(data = as.Date(sprintf('%s-%02d-01', ano, mes_num))) %>% 
  select(data, pib_tot) %>% 
  slice(-(1:12))

pib_seade_var <- readxl::read_excel('data-raw/06-2015_Tabelas_Site.xlsx', 
                                      sheet = 4, skip = 6) %>% 
  setNames(c('mes', 'ano', 'agropecuaria', 'industria', 'servicos', 'total', 
             'pib_var')) %>% 
  filter(!is.na(pib_var)) %>% 
  inner_join(meses, 'mes') %>% 
  mutate(data = as.Date(sprintf('%s-%02d-01', ano, mes_num))) %>% 
  select(data, pib_var)

pib_seade <- bind_cols(pib_seade_total, select(pib_seade_var, -data))


