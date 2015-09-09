#' Le os dados de falencias e recuperacoes
#' 
#' @export
#' 
ler_dados <- function() {
  legenda <- dplyr::data_frame(
    tipo = c('fal_req', 'fal_dec', 'rec_req', 'rec_def'),
    labs = c('Falências requeridas', 'Falências decretadas', 
             'Recuperações requeridas', 'Recuperações deferidas')
  )
  link <- 'http://www.serasaexperian.com.br/release/indicadores/ftp/facons.zip'
  tmp <- tempfile()
  tmpd <- tempdir()
  download.file(link, tmp)
  unzip(tmp, exdir = tmpd)
  dados <- readxl::read_excel(paste(tmpd, 'FACONS.xls', sep = '/'),
                              col_names = FALSE,
                              col_types = c("date", rep('numeric', 20)),
                              skip = 5)
  aux <- file.remove(tmp, paste(tmpd, 'FACONS.xls', sep = '/'))
  names(dados) <- c('data',
                    'fal_req_micro', 'fal_req_med', 
                    'fal_req_grande', 'fal_req_total',
                    'fal_dec_micro', 'fal_dec_med', 
                    'fal_dec_grande', 'fal_dec_total',
                    'rec_req_micro', 'rec_req_med', 
                    'rec_req_grande', 'rec_req_total',
                    'rec_def_micro', 'rec_def_med', 
                    'rec_def_grande', 'rec_def_total',
                    'rec_concedidas_total','conc_req',
                    'conc_def', 'X21')
  dplyr::tbl_df(dados) %>% 
    dplyr::select(-21) %>%
    dplyr::mutate(data = as.character(as.Date(data))) %>%
    dplyr::select(-matches('conc')) %>%
    tidyr::gather(tipo, valor, -data) %>%
    dplyr::mutate(porte = gsub('[a-z]{3}_[a-z]{3}_', '', tipo), 
                  tipo = gsub('_[a-z]+$', '', tipo)) %>%
    dplyr::inner_join(legenda, 'tipo')
}

#' Pipe operator
#'
#' See \code{\link[magrittr]{\%>\%}} for more details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL


