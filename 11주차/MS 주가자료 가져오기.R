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

#Yahoo 금융에서 지원하는 자료 가져오기
start_date = as.Date("2010-01-01")
getSymbols(c("AAPL","MSFT","DJI","FB","GOOG","^GSPC","^KS11"), src="yahoo", from=start_date)

#Apple 주가동향 plot
plot(AAPL[,"AAPL.Close"],main="AAPL")

#Facebook candleChart
candleChart(FB,up.col="black",dn.col="red",theme="white")

#xts Object
stocks <- as.xts(data.frame(AAPL=AAPL[,"AAPL.Close"], MSFT=MSFT[,"MSFT.Close"], GOOG=GOOG[,"GOOG.Close"]))
head(stocks)

#여러 기업 주가동향 plot1
plot(as.zoo(stocks), screens=1, xlab="Date", ylab="Price", lty=1:3, lwd=c(5,3,3), col=c("black", "red", "blue"))
legend("topleft", c("AAPL","MSFT","GOOG"),lty=1:3, lwd=c(5,3,3),col=c("black","red","blue"))

#여러 기업 주가동향 plot2
plot(as.zoo(stocks[,c("AAPL.Close","MSFT.Close")]),screens=1, xlab="Date",ylab="Price",lty=1:2,lwd=3,col=c("black","blue"))
par(new = TRUE)
plot(as.zoo(stocks[,"GOOG.Close"]),screens=1,lty=3, lwd=3,xaxt="n",yaxt="n",xlab="",ylab="",col="red")
axis(4)
legend("topleft", c("AAPL(left)", "MSFT(left)","GOOG"), lty=1:3, lwd=3, col=c("black","blue","red"))
