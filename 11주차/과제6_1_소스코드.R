#과제1
#install.packages('quantmod')
#install.packages('plyr')

library(quantmod)
library(plyr)

start_date= as.Date("2022-01-01")
end_date = as.Date("2022-05-08")

#Yahoo 금융에서 지원하는 자료 가져오기
getSymbols(c("AAPL","MSFT","DJI","FB","GOOG","^GSPC","^KS11"), src="yahoo", from=start_date)
head(AAPL,3)
head(MSFT,3)
head(FB, 3)
head(GOOG, 3)
head(GSPC, 3)
head(KS11, 3)

#Apple 주가동향 plot
plot(AAPL[,"AAPL.Close"],main="AAPL")

#Apple candleChart
candleChart(AAPL,up.col="black",dn.col="red",theme="white")

#xts Object
stocks <- as.xts(data.frame(AAPL=AAPL[,"AAPL.Close"], MSFT=MSFT[,"MSFT.Close"], GOOG=GOOG[,"GOOG.Close"]))
head(stocks)

plot(as.zoo(stocks), screens=1, xlab="Date", ylab="Price",lty=1:3, lwd=c(5,3,3),col=c('black','red','blue'))

legend("topleft", c("APPL","MSFT","GOOG"),lty=1:3,lwd=c(5,3,3),col=c('black','red','blue'))

sidx = as.xts(t(apply(stocks, 1, function(x){x/stocks[1,]})))
head(sidx)