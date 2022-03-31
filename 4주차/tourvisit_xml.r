# tourvisit_xml.r
# 한국관광공사_관광빅데이터정보서비스
# R을 실행시 이전의 객체(object) 들을 모두 list에 저정한 다음 모두 삭제
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

  library(XML) # XML package

# service API key from www.data.go.kr
  svckey <- "set your key"

# set url
  url <- paste('http://api.visitkorea.or.kr/openapi/service/rest/',
      'DataLabService/locgoRegnVisitrDDList',sep="")

  year <- 2021
  fname <- paste("tourxml",year,".csv",sep="")
  nofRows <- 10000
  durl <- paste(url,"?serviceKey=",svckey,"&pageNo=",1,
      "&numOfRows=",nofRows,"&MobileOS=IOS&MobileApp=AppTest",
      "&startYmd=",year,"0101&endYmd=",year,"1231",sep="")

# 오픈 API 통하여 XML 형식으로 자료 가져오기
  rdata <- xmlTreeParse(durl, useInternalNodes = TRUE, encoding = "utf-8")

# XML형식의 자료를 테이터프레임으로 변경하기 
  dta <- xmlToDataFrame(getNodeSet(rdata,"//item"))

  write.table(dta,
      file=fname,append=FALSE,quote=FALSE,sep=",",eol="\n",
      na="NA",dec=".",row.names=FALSE,col.names=TRUE,
      qmethod=c("escape","double"), fileEncoding="euc-kr")
  
  vdta2021 <- read.csv("tourxml2021.csv")
  head(vdta2021)
  vdata2020 <- read.csv("tourxml2020.csv")
  head(vdta2020)
  sigunCode <- sort(unique(paste(vdata2020$signguCode, vdata2020$signguNm)))
  sigunCode
  sidocode <- "36"
  sloc <- which(substr(vdta2020$sigunguCode,1,2))
  sum(vdta2020$touNum)
  sum(vdta2021$touNum)
