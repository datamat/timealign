# Matthias Haeni
# 2011-2015, extract of treegro
# last change August 9, 2015

library(chron)
source("https://raw.githubusercontent.com/datamat/timealign/master/timealign.R")
x <- "https://raw.githubusercontent.com/datamat/timealign/master/exampledata.RData"
load(url(x))

head(df)
tail(df)

# First column has to be a POSIXct-class and the name has to be "ts"
# the second column has to be "val"
foo <- tsalign(df,reso=10)

head(foo)
tail(foo)

# See that foo has now a perfect 10 minute time stamp, df didn't
# Any questions? Please let me know at matthias.haeni-AT-wsl.ch