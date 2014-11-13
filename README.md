falrec
======

### Falências e recuperacões judiciais no Brasil!

Os dados do Serasa Experian contêm informações mensais de número de falências requeridas, falências decretadas, recuperações requeridas e recuperações concedidas.

O repositório contém um shiny app minimal com os dados baseados nas informações do Serasa. Os dados são atualizados a cada nova sessão (~500 kB), então pode demorar um pouco para rodar. Para rodar o app no seu computador, rode no RStudio:

```
shiny::runGitHub('jtrecenti/falrec', subdir='shiny')
```

### Pacotes

Antes de rodar, instale os pacotes `shiny`, `dplyr`, `gdata`, `ggplot2` e `tidyr`.

### Licensa

GNU GPLv2. 
