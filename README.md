<!-- README.md is generated from README.Rmd. Please edit that file -->
macrobonder
===========

The goal of macrobonder is to provide simple funtions to read data from the Macrobond.

The macrobonder depends on the MacrobondAPI. To install the MacrobondAPI

Get data from macrobond
-----------------------

There are two functions to get data from the Macrobond:

-   `get_md()`, simpler and faster method to get whole series with same frequency.
-   `get_convert_mb()`, a method with more options to get also series with different frequency. Series are converted to same frequancy.

Series are returned as a data.frame.

``` r
library(macrobonder)
#> Loading required package: MacrobondAPI
#> Loading required package: xts
#> Loading required package: zoo
#> 
#> Attaching package: 'zoo'
#> The following objects are masked from 'package:base':
#> 
#>     as.Date, as.Date.numeric
#> 
#> Attaching package: 'MacrobondAPI'
#> The following object is masked from 'package:xts':
#> 
#>     addSeries

x <- get_mb(series = c("usgdp", "figdp"))

str(x)
#> 'data.frame':    284 obs. of  3 variables:
#>  $ time : Date, format: "1947-01-01" "1947-04-01" ...
#>  $ usgdp: num  1.93e+12 1.93e+12 1.93e+12 1.96e+12 1.99e+12 ...
#>  $ figdp: num  NA NA NA NA NA NA NA NA NA NA ...
```

``` r

y <- get_convert_mb(series = c("usgdp", "uscpi"), frequency = "Annual")

str(y)
#> 'data.frame':    71 obs. of  3 variables:
#>  $ time : Date, format: "1947-01-01" "1948-01-01" ...
#>  $ usgdp: num  1.96e+12 2.04e+12 2.00e+12 2.27e+12 2.40e+12 ...
#>  $ uscpi: num  23.4 24.1 23.6 25 26.5 ...
```
