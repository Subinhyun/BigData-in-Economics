# midterm.r
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)


# 수강학생 학번 읽기
  stdinfo <- read.csv("수강학생학번.csv")
  sidocode <- c("11","26","27","28","29","30","31","36",
      "41","42","43","44","45","46","47","48","50")
  sidoname <- c("서울","부산","대구","인천","광주","대전","울산","세종",
      "경기","강원","충북","충남","전북","전남","경북","경남","제주")

  for (i in 1:nrow(stdinfo)){
      cat("\n\n학생명:", stdinfo$성명[i], "학번:", stdinfo$학번[i],"\n")
      sid <- as.integer(substr(stdinfo$학번[i],
          nchar(stdinfo$학번[i])-4,nchar(stdinfo$학번[i])))
    # 1. 소득 N(300,100)
      set.seed(sid)
      income <- rnorm(1000,mean=300,sd=100)
      cat("(1.1) 소득 평균:",mean(income), "표준편차:", sd(income),"\n")
      cat("(1.2) 400만원 이상인 사람은?", length(which(income>=400)),"명\n")
      cat("(1.3) 소득 1분위수(하위 10%) 소득은?", quantile(income,0.1),"만원\n")

    # 2. 변동성
      set.seed(sid)
      asset1 <- rnorm(100,mean=200,sd=50)
      set.seed(sid)
      asset2 <- rnorm(100,mean=100,sd=35)
      cat("\n(2) 변동계수 비교\n")
      cat("  자산1의 변동계수:", sd(asset1)/mean(asset1),"\n")
      cat("  자산2의 변동계수:", sd(asset2)/mean(asset2),"\n")

    # 3. 투썸플레이스
      data <- read.csv("twosome.csv")
    # 변수 추가
      data$opened <- as.integer(data$영업상태명=="영업/정상")
      data$closed <- as.integer(data$영업상태명=="폐업")
      data$pmtyear <- as.integer(substr(data$인허가일자,1,4))

      set.seed(sid)
      sloc <- sample(1:nrow(data))[1:1000]
      sdata <- data[sloc,]
    # 3.1
      nstore <- table(sdata$시도)
      nstore <- nstore[order(nstore)]
      nsido <- length(nstore)
      cat("\n(3.1) 투썸플레이스가 가장 적은 시도:",names(nstore)[1],"개수",nstore[1],"\n")
      cat("      투썸플레이스가 가장 많은 시도:",names(nstore)[nsido],
          "개수",nstore[nsido],"\n")
    # 3.2 폐업률이 가장 높은 지역과 가장 낮은 지역
      sidodata <- sdata %>% group_by(시도) %>%
          summarise(점포수=n(),운영=sum(opened),폐업=sum(closed),
              폐업률=mean(closed)) %>% data.frame()
      maxloc <- which(sidodata$폐업률==max(sidodata$폐업률))
      cat("\n(3.2) 투썸플레이스 폐업률이 가장 높은 시도:",sidodata$시도[maxloc],
          "폐업률(%):",sidodata$폐업률[maxloc]*100,"\n")
    # 3.3 가장 많이 창업한 연도
      nyear <- table(sdata$pmtyear)
      nyear <- nyear[which(nyear==max(nyear))]
      cat("\n(3.3) 투썸플레이스 창업이 가장 많은 연도:",names(nyear),"창업점포수:",nyear,"\n")

    # 4
      year <- 2018
      set.seed(sid)
      sidoloc <- sample(1:length(sidocode))[1]

      year <- 2018
      tdata <- read.csv(paste("tour",year,".csv",sep=""))
      sloc <- which(substr(tdata$signguCode,1,2)==sidocode[sidoloc] &
          tdata$touDivCd==3)
      tour2018 <- sum(tdata$touNum[sloc])

      year <- 2021
      tdata <- read.csv(paste("tour",year,".csv",sep=""))
      sloc <- which(substr(tdata$signguCode,1,2)==sidocode[sidoloc] &
          tdata$touDivCd==3)
      tour2021 <- sum(tdata$touNum[sloc])
      cat("\n(4) 외국인관광객수(시도: ",sidoname[sidoloc],")\n",sep="")
      cat("    2018년 외국인관광객수:",tour2018,"명\n")
      cat("    2021년 외국인관광객수:",tour2021,"명\n")
      cat("    2018-2021년 외국인관광객수 증감율(%):",(tour2021/tour2018-1)*100,"\n")
  }
