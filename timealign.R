# Matthias Haeni
# 2011-2015, extract of treegro
# last change August 9, 2015

tsalign <- 
  function(df, reso=10, wnd=reso*2.1, type="linear", year="asis") {
    wnd <- reso*2.1
    type <- "linear"
    year <- "asis"
    st <- df$ts[1]
    en <- df$ts[length(df$ts)]
    df <- generatets(df, reso, TRUE, year)
    df <- fillintergaps(df, reso, wnd, type, generate=TRUE)
    df <- generatets(df, reso, FALSE, year)
    ran <- which(df$ts<st)
    if(length(ran)!=0) {
      df <- df[-ran,]
    }
    ran <- which(df$ts>en)
    if(length(ran)!=0) {
      df <- df[-ran,]
    }
    return(df)
  }

generatets <- 
  function(df, reso=10, all=TRUE, year="asis") {
    if(all!=TRUE&all!=FALSE) {
      stop('provide all with either TRUE or FALSE')
    }
    if(year!="full"&year!="asis") {
      stop('provide year with either asis or full')
    }
    ch <- which(is.na(df$ts))
    if(length(ch)!=0) {
      df <- df[-ch, ]
    }
    df <- df[order(df$ts), ]
    le <- length(df$ts)
    if(year=="asis") {
      start <- format(df$ts[1], format="%m/%d/%Y")
      end <- format(df$ts[le], format="%m/%d/%Y")
    }
    if(year=="full") {
      start <- format(df$ts[1], format="01/01/%Y")
      end <- format(df$ts[le], format="12/31/%Y")
    }
    df$ts <- as.character(df$ts)
    dd <- as.character(seq.dates(start, end, by="days"))
    dd <- rep(dd, each=24*60/reso)
    t1 <- times("00:00:00")
    res <- formatC(60-reso, width=2, flag="0")
    t2 <- times(paste("23:", res, ":00", sep=""))
    res <- formatC(reso, width=2, flag="0")
    tt <- seq(t1, t2, by=times(paste("00:", res, ":00", sep="")))
    dd <- as.POSIXct(strptime(paste(dd, tt), format="%m/%d/%y %H:%M:%S"), tz="UTC")
    dd <- as.data.frame(dd); names(dd)[1] <- "ts"; de <- dd
    dd$ts <- as.character(dd$ts)
    if(all) {
      df <- merge(dd, df, by="ts", all=TRUE, sort=TRUE)
    } else {
      df <- merge(dd, df, by="ts", all.x=TRUE, sort=TRUE) 
    }
    df$ts <- as.POSIXct(strptime(df$ts, "%Y-%m-%d %H:%M:%S", tz="UTC"))
    df <- df[order(df$ts), ]
    if(sum(is.na(df$val))==le) {
      stop("we only have NAs in the dataframe")
    }
    return(df)
  }

fillintergaps  <- 
  function(df, reso=10, wnd=4*60/reso, type="linear", year="asis", generate=FALSE) {
    if(class(df)!="data.frame"|length(df[, 1])==0) {
      stop("provide a dataframe")
    }
    if(!generate) {
      df <- generatets(df, reso, FALSE, year)
    }
    uh <- FALSE
    if(is.na(df$val)[1]) {
      sim <- which(!is.na(df$val))[1]-1
      anf <- df[c(1:sim), ]
      df <- df[-c(1:sim), ]
      uh <- TRUE
    }
    le <- length(df$ts)
    ux <- FALSE
    if(is.na(df$val[le])) {
      hot <- which(!is.na(df$val))
      sim <- hot[length(hot)]+1
      sch <- df[c(sim:le), ]
      df <- df[-c(sim:le), ]
      ux <- TRUE
    }
    le <- length(df$ts)
    nc <- ncol(df)
    df$isgap <- is.na(df$val)
    df$gaps <- cumsum(df$isgap)
    df$y[1] <- 0
    df$y[2:le] <- diff(df$gaps, lag=1)
    df$z[1] <- 0
    df$z[2:le] <- diff(df$y, lag=1) > 0
    df$gapno <- cumsum(df$z)
    y <- as.numeric(tapply(df$isgap[df$isgap], df$gapno[df$isgap], sum))
    x <- 1:(length(y))
    Nwnd <- length(x[y<wnd])
    df$gfmode <- rep(0, le)
    df$gfmode[df$isgap] <- TRUE
    if(max(df$gapno[df$isgap])==(-Inf)) {
      gapcode <- 0
    } else {
      gapcode <- rep(0, max(df$gapno[df$isgap]))
    }
    gapcode[y<wnd&y>0] <- 2
    df$gfmode[df$isgap] <- gapcode[df$gapno[df$isgap]]
    if(type=="linear") {
      select <- df$gfmode==2&is.na(df$val)
      df$val[select] <- approx(df$ts, df$val, df$ts[select])$y
    }
    df <- df[,c(1:nc)]
    if(uh) {
      df <- rbind(anf, df[, c(1:nc)])
    }
    if(ux) {
      df <- rbind(df[, c(1:nc)], sch)
    }
    return(df)
  }