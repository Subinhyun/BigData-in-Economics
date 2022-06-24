rm(list=ls())
options(warn=-1,width=80,scipen=10)
sdir <- "C:/Temp/bigdata"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)
#install.packages("wordcloud")
#install.packages("RmecabKo")
library(wordcloud)
library(RmecabKo)
install_mecab("C:/Temp/bigdata")

fname <- "빅데이터기사.txt"
addtxt <- readLines(fname)
set.seed(04135)
sloc <- sample(length(addtxt))[1:50]
dta <- addtxt[sloc]

#install.packages("RmecabKo")

words <- RmecabKo::nouns(dta)
words.all <- unlist(words,use.names=F)
words.all2 <- words.all[nchar(words.all)>=2]
words.freq <- table(words.all2)
wordsdf <- data.frame(words.freq,stringAsFactors=F)
wordsdf.sort <- wordsdf[order(-wordsdf$Freq),]

jpeg("빅데이터기사.jpg", quality=600, bg="white",
     res=600, width=5, height=5, units="in")
par(mar = c(0,0,0,0))
wordcloud(wordsdf.sort[,1],freq=wordsdf.sort[,2],
          min.freq=1,scale=c(3,0.7),rot.per=0.25,random.order=F,
          random.color=T,colors=rainbow(10))
dev.off()

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3c586f70-3e7c-4141-865f-aebf1cc9897b/Untitled.png)

# 1

rm(list=ls())
options(warn=-1,width=80,scipen=10)
sdir <- "C:/Temp/bigdata"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)
#install.packages("wordcloud")
#install.packages("RmecabKo")
library(wordcloud)
library(RmecabKo)
install_mecab("C:/Temp/bigdata")

fname <- "빅데이터기사.txt"
addtxt <- readLines(fname)
set.seed(04135)
sloc <- sample(length(addtxt))[1:50]
dta <- addtxt[sloc]

#install.packages("RmecabKo")

words <- RmecabKo::nouns(dta)
words.all <- unlist(words,use.names=F)
words.all2 <- words.all[nchar(words.all)>=2]
words.freq <- table(words.all2)
wordsdf <- data.frame(words.freq,stringAsFactors=F)
wordsdf.sort <- wordsdf[order(-wordsdf$Freq),]

jpeg("빅데이터기사.jpg", quality=600, bg="white",
     res=600, width=5, height=5, units="in")
par(mar = c(0,0,0,0))
wordcloud(wordsdf.sort[,1],freq=wordsdf.sort[,2],
          min.freq=1,scale=c(3,0.7),rot.per=0.25,random.order=F,
          random.color=T,colors=rainbow(10))
dev.off()

# 2

#install.packages("quantmod")
#install.packages("dplyr")
library(quantmod)
library(dplyr)

Agroup <- c("AAPL", "MSFT", "FB", "GOOG")
Bgroup <- c("AMZN", "WMT", "TGT")
set.seed(04135)
Aticker <- Agroup[sample(length(Agroup))[1]]
set.seed(04135)
Bticker <- Bgroup[sample(length(Bgroup))[1]]

retDaily <- function(ticker,begdate,enddate=Sys.Date()){
  x = getSymbols(ticker,src="yahoo",from=begdate,
                 to=enddate,auto.assign=FALSE)
  xaclose = matrix(x[,ncol(x)])
  ret = xaclose[-1]/xaclose[-nrow(x)]-1
  yymmdd = rownames(as.data.frame(x))
  result = data.frame(date=yymmdd[-1],ret)
  colnames(result)[2] = paste("ret",ticker,sep="")
  return(result)
}

begdate = as.Date("2010-01-01")
enddate = as.Date("2022-06-14")

last <- retDaily(Aticker, begdate, enddate)
last2 <- retDaily(Bticker, begdate, enddate)

#월별 수익률

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

MonthlyA <- retMonthly(Aticker, begdate, enddate)
MonthlyB <- retMonthly(Bticker, begdate, enddate)

# 로그수익률

logreturn <- function(ticker,begdate,enddate=Sys.Date()){
  x = getSymbols(ticker,src="yahoo",from=begdate,
                 to=enddate,auto.assign=FALSE)
  xaclose = matrix(x[,ncol(x)])
  ret = log(xaclose[-1]/xaclose[-nrow(x)])
  yymmdd = rownames(as.data.frame(x))
  result = data.frame(date=yymmdd[-1],ret)
  colnames(result)[2] = paste("logret",ticker,sep="")
  return(result)
}

begdate = as.Date("2022-06-01")
enddate = as.Date("2022-06-15")

logreturn(Aticker, begdate, enddate)
logreturn(Bticker, begdate, enddate)

#코로나 이전
cbegdate = as.Date("2017-01-01")
cenddate = as.Date("2019-12-31")

ca <- retDaily(Aticker, cbegdate, cenddate)
cb <- retDaily(Bticker, cbegdate, cenddate)

#코로나 이후
ncbegdate = as.Date("2020-01-01")
ncenddate = as.Date("2022-06-14")

nca <- retDaily(Aticker, ncbegdate, ncenddate)
ncb <- retDaily(Bticker, ncbegdate, ncenddate)

# 코로나 이전 베타계수

summary(lm(ca[,2]~cb[,2]))

# 코로나 이후 베타계수

summary(lm(nca[,2]~ncb[,2]))

# 2.1 기간 동안의 베타계수 추정

begdate = as.Date("2010-01-01")
enddate = as.Date("2022-06-14")
y0 = retDaily(Aticker,begdate,enddate)
x0 = retDaily(Bticker,begdate,enddate) # S&P500
ydate = as.Date(y0[,1]);
xdate = as.Date(x0[,1])
yyear = strftime(ydate,"%Y"); xyear = strftime(xdate,"%Y")
year = unique(xyear)
results <- {}
for (i in year){
  yloc = which(yyear==i); xloc = which(xyear==i)
  m <- summary(lm(y0[yloc,2]~x0[xloc,2]))
  results <- rbind(results, matrix(c(as.integer(i),
                                     round(m$coeff[1,1],8),round(m$coeff[2,1],3),
                                     round(m$r.squared,3), round(m$coeff[2,4],3)),nrow=1))
}
colnames(results) <- c("year","alpha","beta","r2","p-value")

summary(lm(y0[,2]~x0[,2]))

#############
summary(lm(ca[,2]~ca[,2]))
summary(lm(nca[,2]~nca[,2]))

summary(lm(cb[,2]~cb[,2]))
summary(lm(ncb[,2]~ncb[,2]))