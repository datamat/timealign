# timealign (R package)
## Description
This `timealign` package is an extract of R functions which can be sourced and used to align the timestamp of any kind of data. This R package is only one of many developed within the TreeNet project to process tree growth, eddy covariance, soil moisture, meteorological and other auxilary data.

## Version
The current version is 0.6.

## Dependencies
`timealign` is based on one function (`seq.dates`) from the `chron` library [https://cran.r-project.org/web/packages/chron/index.html](https://cran.r-project.org/web/packages/chron/index.html). Thank you David James, Kurt Hornik, and Gabor Grothendieck for your awesome package. Before using `timealign` please install `chron` first with:

`install.packages("chron")`
and
`library(chron)`

## Installation
### From gihub source
You may source the function package on github with:

`source("https://raw.githubusercontent.com/datamat/timealign/master/timealign.R")`

### From CRAN (work in progress)
The easiest way to use any of the functions in the `timealign` package would be to install the CRAN version. However, this options does not exist yet. 

## Package contents
Each function can be found in the complete R script called `timealgin.R`. 

### Descriptivion of functions
- `tsalign`	 This is main function, where a data.frame is filled into a complete and perfectly aligned timestamp at the given resolution.
- `generatets`	This function generates a timestamp which is then used by tsalign.
- `fillintergaps`  This function fill all the gaps within a given time span in a linear way. 

### Example
`source("https://raw.githubusercontent.com/datamat/timealign/master/timealign.R")
library(chron)

load("exampledata.RData")
head(df)
tail(df)

foo <- tsalign(df,reso=10)

head(foo)
tail(foo)`

Please feel free to contribute to this package, or contact me if you have any other comments or suggestions: matthias.haeni-AT-wsl.ch.
