# tourvisit.r
# 한국관광공사_관광빅데이터정보서비스
# written by Heonsoo Park (geobiz@hanmail.net)
# R을 실행시 이전의 객체(object) 들을 모두 list에 저정한 다음 모두 삭제
  rm(list=ls())

# 환경설정: warning messages 보이지 않게, 한줄에 80개 문자까지, 숫자 표시 관련
  options(warn=-1,width=80,scipen=10) 

# 작업공간 지정: c:/bigdata 폴더가 작업공간 작업공간이 존재하지 않을 경우 생성
  sdir <- "c:/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

# JSON package
  library(jsonlite)

# set url
  vurl <- paste('http://api.visitkorea.or.kr/openapi/service/rest/',
      'DataLabService/locgoRegnVisitrDDList',sep="")
# service API key from www.data.go.kr
  svckey <- "xxxxx.....xxxxx"

  year <- 2021
  fname <- paste("data/tourvisit",year,".csv",sep="")
  nofRows <- 10000
  npages <- 10000
  for (p in 1:npages){
      durl <- paste(vurl,'?serviceKey=',svckey,'&pageNo=',p,
          '&numOfRows=',nofRows,'&MobileOS=IOS&MobileApp=AppTest',
          '&startYmd=',year,'0101&endYmd=',year,'1231',sep="")
    # 웹 문서 가져오기
    # 접속이 끊겨서 자료를 가져오지 못할 경우 재시도
      k <- 0
      repeat{
          tryCatch(vdta <- jsonlite::fromJSON(durl),
              error = function(e){k <- 1},
              finally={k <- 0}
          )
          if (k==0) break
      }

      if (vdta$response$body$items == "") npages <- 1

      if (vdta$response$body$items != ""){
        # p=1일 때 전체 pages 수를 가져옴
          if (p==1) npages <- ceiling(vdta$response$body$totalCount/nofRows)
          cat("year=",year,"page=",p,"/",npages,"\n")
          write.table(data.frame(vdta$response$body$items$item),
              file=fname,append=(p>1),quote=FALSE,sep=",",eol="\n",
              na="NA",dec=".",row.names=FALSE,col.names=(p==1),
              qmethod=c("escape","double"), fileEncoding="euc-kr")
      }
      if (p>npages) break
  }
