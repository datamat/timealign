# Matthias Haeni
# 2011-2015, extract of treegro
# last change August 9, 2015

require(RCurl)
source_https <- function(url, ...) {
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u,
                             followlocation = TRUE,
                             cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))),
         envir = .GlobalEnv)
  })
}

source_https("https://raw.githubusercontent.com/datamat/timealign/master/timealign.R")
