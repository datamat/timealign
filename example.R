# Matthias Haeni
# 2011-2015, extract of treegro
# last change August 9, 2015

source("https://raw.githubusercontent.com/datamat/timealign/master/timealign.R")
library(chron)

load("exampledata.RData")
head(df)
tail(df)

# First column has to be a POSIXct-class
foo <- tsalign(df,reso=10)

head(foo)
tail(foo)

# See that foo has now a perfect 10 minute time stamp, df didn't
# Any questions? Please let me know at matthias.haeni-AT-wsl.ch