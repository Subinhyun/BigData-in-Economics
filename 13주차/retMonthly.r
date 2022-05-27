# retMonthly 
#install.packages("quantmod")
#install.packages("dplyr")
library(quantmod)
library(dplyr)
retMonthly = function(ticker,begdate,enddate){
    x = getSymbols(ticker, src="yahoo", from=begdate,
        to=enddate, auto.assign=FALSE)
    xaclose = matrix(x[,ncol(x)])
    logret = log(xaclose[-1]/xaclose[-nrow(x)])
    yymmdd = rownames(as.data.frame(x))
    yymm = strftime(yymmdd,"%Y%m")
    df = data.frame(date=yymm[-1],logret)
    result = df %>% group_by(date) %>% 
	     summarize(ret=exp(sum(logret))-1) %>% data.frame()
    colnames(result)[2] = paste("ret",ticker,sep="")
    return(result)
}
