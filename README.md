
<!-- README.md is generated from README.Rmd. Please edit that file -->

# summary.target

<!-- badges: start -->
<!-- badges: end -->

The goal of summary.target is to provide a convenient function for
computing the summary statistics for a specific numeric column in a data
frame, grouped by one or more specified categorical columns.

The specific summary statistics calculated are as follows:

-   Mean

-   Minimum

-   Maximum

-   Standard deviation

## Installation

You can install the development version of summary.target like so:

``` r
# If you haven't install the devtools package, please install it
install.packages("devtools")

# Then you can install the summary.target package from github
devtools::install_github("stat545ubc-2024/summary.target")
```

## Examples

### This is a basic example which shows you how to solve a common problem:

``` r
library(summary.target)
library(datateachr) #To ensure be able to use the dataset steam_games

# The code there summarize the 'discount_price' variable grouped by 'types' in the steam_games dataset.
summarize_target(datateachr::steam_games, "types", "discount_price")
#> # A tibble: 4 × 5
#>   types   mean   min   max     sd
#>   <chr>  <dbl> <dbl> <dbl>  <dbl>
#> 1 app     51.9  0    963.  102.  
#> 2 bundle  26.9  0.58 708.   35.9 
#> 3 sub     11.4  0.49  60.0   9.08
#> 4 <NA>    24.0 24.0   24.0  NA
```

### Handling Errors

This function including error handling to check for invalid inputs. For
example, if a grouping variable does not exist in the dataset,
summary.target will return an informative error message.

``` r
# Since "color" is not a column in steam_games, it will return an informative error message.
summarize_target(datateachr::steam_games, "color", "discount_price")
#> Error in summarize_target(datateachr::steam_games, "color", "discount_price"): Sorry, all color should be columns inside of your 'data'.
```
