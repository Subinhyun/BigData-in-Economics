# week6.r
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

# 실습1
# 스타벅스 자료 읽기
  data <- read.csv("starbucks.csv")

# 임의 표본 추출
  nsmpl <- 1000
  set.seed <- 12345
  sloc <- sample(1:nrow(data))[1:nsmpl]
  sbdata <- data[sloc,]

# 변수 추가
  sbdata$opened <- as.integer(sbdata$영업상태명=="영업/정상")
  sbdata$closed <- as.integer(sbdata$영업상태명=="폐업")

# 그룹 분석
  library(dplyr)
  sidodata <- sbdata %>% group_by(시도) %>%
      summarise(점포수=n(),운영=sum(opened),폐업=sum(closed),폐업률=mean(closed)) %>%
      data.frame()

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
