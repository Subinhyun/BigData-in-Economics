# textmining.r
# written by Heonsoo Park (geobiz@hanmail.net)
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) #suppress warning messages

# 현재 작업 위치 작업위치 설정
  sdir <- "c:/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)

# 작업공간 지정: c:/bigdata 폴더가 작업공간
  setwd(sdir)

  library(wordcloud)
  library(RmecabKo)
  install_mecab("c:/temp")

  namelist <- c("이재명","윤석열")
  for (name in namelist){
      fname <- paste(name,"후보연설문.txt",sep="")
      dta <- readLines(fname)
      words <- nouns(dta)
      words.all <- unlist(words,use.names=F)
      words.all2 <- words.all[nchar(words.all)>=2]
      words.freq <- table(words.all2)
      wordsdf <- data.frame(words.freq,stringAsFactors=F)
      wordsdf.sort <- wordsdf[order(-wordsdf$Freq),]

      jpeg(paste(name,".jpg",sep=""), quality=600, bg="white", 
          res=600, width=5, height=5, units="in")
          par(mar = c(0,0,0,0))
          wordcloud(wordsdf.sort[,1],freq=wordsdf.sort[,2],
              min.freq=1,scale=c(3,0.7),rot.per=0.25,random.order=F,
              random.color=T,colors=rainbow(10))
      dev.off()
  }
