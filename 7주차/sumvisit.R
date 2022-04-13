# 실습2
year <- 2021
tourdata <- read.csv(paste("tourvisit",year,".csv",sep=""))
tourdata$sigun <- paste(tourdata$signguCode, tourdata$signguNm)
tourdata$현지인 <- as.integer(tourdata$touDivCd==1)*tourdata$touNum
tourdata$외지인 <- as.integer(tourdata$touDivCd==2)*tourdata$touNum
tourdata$외국인 <- as.integer(tourdata$touDivCd==3)*tourdata$touNum

sumdata <- tourdata %>% group_by(sigun) %>%
  summarise(관광객=sum(touNum),현지인=sum(현지인),외지인=sum(외지인),외국인=sum(외국인)) %>%
  data.frame()

# 관광객 상위1-5위
sumdata[order(-sumdata$관광객)[1:5],]

# 외지인 관광객 상위 1-5위
sumdata[order(-sumdata$외지인)[1:5],]

# 외국인 관광객 상위 1-5위
sumdata[order(-sumdata$외국인)[1:5],]



year <- 2021
tourdata <- read.csv(paste("tourvisit",year,".csv",sep=""))
tourdata$sigun <- paste(tourdata$signguCode, tourdata$signguNm)
tourdata$현지인 <- as.integer(tourdata$touDivCd==1)*tourdata$touNum
tourdata$외지인 <- as.integer(tourdata$touDivCd==2)*tourdata$touNum
tourdata$외국인 <- as.integer(tourdata$touDivCd==3)*tourdata$touNum

sumdata <- tourdata %>% group_by(sigun) %>%
  summarise(관광객=sum(touNum),현지인=sum(현지인),외지인=sum(외지인),외국인=sum(외국인)) %>%
  data.frame()

# 관광객 상위1-5위
cat("관광객 상위 1위-10위 (",year,")\n",sep="")
print(sumdata[order(-sumdata$관광객)[1:10],])

# 외지인 관광객 상위 1-10위
cat("외지인 관광객 상위 1위-5위 (",year,")\n",sep="")
print(sumdata[order(-sumdata$외지인)[1:10],])

# 외국인 관광객 상위 1-10위
cat("외국인 관광객 상위 1위-5위 (",year,")\n",sep="")
print(sumdata[order(-sumdata$외국인)[1:10],])