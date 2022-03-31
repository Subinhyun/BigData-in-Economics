# tourvisit.r
# 한국관광공사_관광빅데이터정보서비스
# R을 실행시 이전의 객체(object) 들을 모두 list에 저정한 다음 모두 삭제
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

  library(jsonlite) # JSON package

# set url
  url <- paste('http://api.visitkorea.or.kr/openapi/service/rest/',
      'DataLabService/locgoRegnVisitrDDList',sep="")
# service API key from www.data.go.kr
  svckey <- "set your key"

  year <- 2021
  fname <- paste("tourjson",year,".csv",sep="")
  nofRows <- 10000
  durl <- paste(url,"?serviceKey=",svckey,"&pageNo=",1,
      "&numOfRows=",nofRows,"&MobileOS=IOS&MobileApp=AppTest",
      "&startYmd=",year,"0101&endYmd=",year,"1231",sep="")
  vdta <- jsonlite::fromJSON(durl) # 웹 문서 가져오기

  write.table(data.frame(vdta$response$body$items$item),
      file=fname,append=FALSE,quote=FALSE,sep=",",eol="\n",
      na="NA",dec=".",row.names=FALSE,col.names=TRUE,
      qmethod=c("escape","double"), fileEncoding="euc-kr")
