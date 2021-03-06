---
title: "Falências e Recuperações"
author: "Julio Trecenti"
date: "2015-08-24"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Falências e recuperações}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


```r
library(dplyr)
library(tidyr)
library(ggplot2)
library(falrec)
library(scales)
library(lubridate)
d <- ler_dados()
```

-----

## Falências requeridas

### Entre 1991 até agora


```r
d %>%
  filter(porte == 'total', tipo == 'fal_req') %>%
  ggplot(aes(x = data, y = valor)) +
  geom_line(colour = 'red') +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("1991-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 500) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

### Entre 2005 até agora


```r
d %>%
  filter(tipo == 'fal_req', 
         data >= as.Date('2005-01-01')) %>%
  ggplot(aes(x = data, y = valor, colour = porte)) +
  geom_line() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("2005-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 100) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

-----

## Falências decretadas

### Entre 1991 até agora


```r
d %>%
  filter(porte == 'total', tipo == 'fal_dec') %>%
  ggplot(aes(x = data, y = valor)) +
  geom_line(colour = 'red') +
  theme_bw() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("1991-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 50) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

### Entre 2005 até agora


```r
d %>%
  filter(tipo == 'fal_dec', 
         data >= as.Date('2005-01-01')) %>%
  ggplot(aes(x = data, y = valor, colour = porte)) +
  geom_line() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("2005-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 50) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

-----

## Falências decretadas

### Entre 1991 até agora


```r
d %>%
  filter(porte == 'total', tipo == 'fal_dec') %>%
  ggplot(aes(x = data, y = valor)) +
  geom_line(colour = 'red') +
  theme_bw() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("1991-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 50) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

### Entre 2005 até agora


```r
d %>%
  filter(tipo == 'fal_dec', 
         data >= as.Date('2005-01-01')) %>%
  ggplot(aes(x = data, y = valor, colour = porte)) +
  geom_line() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("2005-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 50) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

-----

## Recuperações requeridas


```r
d %>%
  filter(tipo == 'rec_req', 
         data >= as.Date('2005-01-01')) %>%
  ggplot(aes(x = data, y = valor, colour = porte)) +
  geom_line() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("2005-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 10) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

### RollPeriod com dygraphs


```r
ts <- d %>% 
  filter(tipo == 'rec_req', data >= as.Date('2005-01-01'),
         data <= as.Date(today())) %>%
  spread(porte, valor) %>%
  select(data, grande:total) %>%
  {xts::xts(select(., -data), .$data)}

dygraphs::dygraph(ts) %>%
  dygraphs::dyRoller(rollPeriod = 12)
```

![plot of chunk unnamed-chun](figure/dygraph-1.png) 

## Recuperações deferidas


```r
d %>%
  filter(tipo == 'rec_def', 
         data >= as.Date('2005-01-01')) %>%
  ggplot(aes(x = data, y = valor, colour = porte)) +
  geom_line() +
  scale_x_date(breaks = date_breaks('1 year'), 
               minor_breaks = "3 months",
               labels = date_format("%Y"),
               limits = c(as.Date("2005-01-01"), 
                          as.Date('2016-01-01'))) +
  scale_y_continuous(breaks = 0:100 * 10) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position="bottom")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 

### RollPeriod com dygraphs


```r
ts <- d %>% 
  filter(tipo == 'rec_def', data >= as.Date('2005-01-01'),
         data <= as.Date(today())) %>%
  spread(porte, valor) %>%
  select(data, grande:total) %>%
  {xts::xts(select(., -data), .$data)}

dygraphs::dygraph(ts) %>%
  dygraphs::dyRoller(rollPeriod = 12)
```

![plot of chunk unnamed-chunk](figure/dygraph-2.png) 

-----

