rm(list=ls())
options(warn=-1,width=80,scipen=10) 
sdir <- "/Users/hsooovn/Downloads/"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)

library(quantmod)
library(plyr)
start_date = as.Date("2021-01-01")
end_date = as.Date("2022-05-08")
getSymbols("MSFT",src="yahoo",from=start_date,to=end_date)
head(MSFT,3)
summary(MSFT)
