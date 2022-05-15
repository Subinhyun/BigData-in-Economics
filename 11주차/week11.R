rm(list=ls())
options(warn=-1,width=80,scipen=10) 
sdir <- "/Users/hsooovn/Downloads/"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)

install.packages("devtools", dependencies = TRUE)
library(devtools)

#install.packages("tidyverse")
#library(tidyverse)

install.packages("tbl2xts")
library(tbl2xts)

# https://github.com/mrchypark/tqk에서 다운로드
install.packages("/Users/hsooovn/Downloads/tqk-master", repos = NULL, type="source")
devtools::install_github("mrchypark/tqk")

#tqk 지원 KOSPI 상장기업 코드 가져오기

library(tqk)
code <- matrix(unlist(code_get()),ncol=3)
code[1:3,]
sscode <- code[which(substr(code[,2],1,4)=="삼성전자"),]
sscode

#삼성전자 주가자료 가져오기

library(tqk)
library(tbl2xts)
kospi <- function(firmcode,firmabbr,from,to=Sys.Date()) {
  x = tbl2xts::tbl_xts(tqk_get(firmcode, from=from, to=to))
  colnames(x) <- paste(toupper(firmabbr), c("Open","High","Low","Close","Volume","Adjusted"),sep=".")
  return(x)
}

start_date = "2018-06-01"
samsung <- kospi("005930","SS",start_date)
head(samsung)
tail(samsung)

#삼성전자 candleChart 그리기

candleChart(samsung,up.col="black",dn.col="red",theme="white")
addSMA(n = c(20, 60), col=c(’blue’,’red’))
legend("left", c("20","60"),lty=1,col=c(’blue’,’red’),bty="n")


