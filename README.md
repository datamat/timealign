# R package: "timealign"
## Description
This `timealign` package is an extract of R functions which can be sourced and used to align the timestamp of any kind of data. This R package is only one of many developed within the TreeNet project to process tree growth, eddy covariance, soil moisture, meteorological and other auxilary data.

## Version
The current version is 0.6.

## Dependencies
`timealign` is based on one function from the `chron` library [https://cran.r-project.org/web/packages/chron/index.html](https://cran.r-project.org/web/packages/chron/index.html). thank you David James, Kurt Hornik, and Gabor Grothendieck for your awesome package. Before using `timealign` please install `chron` first with:

`install.packages("chron")`

## Installation
### From github
The `devtools` package contains functions that allow you to install R packages directly from bitbucket or github. If you've installed and loaded the `devtools` package, the installation command is

`install_github("timealign","datamat")`

### From CRAN (work in progress)
The easiest way to use any of the functions in the `timealign` package would be to install the CRAN version. However, this options does not exist yet. 

## Package contents
Each function can be found in the complete R script called `timealgin.R`. 

### Descriptivion of functions
- `tsalign`	 This is main function, where a data.frame is filled into a complete and perfectly aligned timestamp at the given resolution.
- `generatets`	This function generates a timestamp which is then used by tsalign.
- `fillintergaps`  This function fill all the gaps within a given time span in a linear way. 

Please feel free to contribute to this package, or contact me if you have any other comments or suggestions: matthias.haeni-AT-wsl.ch.
