# stockprice.r
# 네이버 오픈 API
# written by Heonsoo Park (geobiz@hanmail.net)
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) #suppress warning messages

  sdir <- 'c:/temp/bigdata/'
  setwd(sdir)

  library(rvest)    		# web scrapping package
  library(stringr)    # string
  library(xts)        # xts object

# get stock price from naver
# require rvest,springr,xts packages
# return xts object
  naver_sprice <- function(ticker,begdate,enddate=Sys.Date()){
      url <- "https://api.finance.naver.com/siseJson.naver"
      vname <- c("Open","High","Low","Close","Volume","Foreign")
      vname <- paste(vname,ticker,sep=".")
      surl <- paste(url,"?symbol=",ticker,"&requestType=1&startTime=",
          begdate,"&endTime=",enddate,"&timeframe=day",sep="")
      dta <- read_html(surl)
      dta <- substr(dta,str_locate(dta, "외국인소진율")[2]+5,
          str_locate(dta,fixed('</html>'))[1])
      sloc <- str_locate_all(dta,fixed('['))[[1]][,1]+1
      eloc <- str_locate_all(dta,fixed('],'))[[1]][,1]-1
      spdta <- NULL
      for (i in 1:length(sloc)){
          a <- substr(dta,sloc[i],eloc[i])
          if (!is.na(a)){
              a <- gsub(fixed('\"'),"",a)
              a <- unlist(str_split(a,","))
              mydates <- as.Date(paste(substr(a[1],1,4),
                  substr(a[1],5,6),substr(a[1],7,8),sep="-"))
              vdta <- data.frame(matrix(as.integer(a[2:6]),nrow=1),
                  as.numeric(a[7]))
              colnames(vdta) <- vname
              spdta <- rbind(spdta,xts(x=vdta,order.by=mydates))
          }
      }
      return(spdta)
  }

  ticker <- "005930" # samsung electrics co.
  ticker <- "035720" # kakao
  begdate <- as.Date("2021-01-01")
  enddate <- Sys.Date() 

  x <- naver_sprice(ticker,begdate)
