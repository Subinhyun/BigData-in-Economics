rm(list=ls())
options(warn=-1,width=80,scipen=10) 

sdir <- "c:/Temp/bigdata/"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)

install.packages("stringr")
library(stringr)

data <- read.csv("fulldata_07_24_05.csv")

chkchar <- str_locate(data$사업장명,"스타벅스")
sbloc <- which(!is.na(chkchar[,1]))
sbdata <- data[sbloc,]

sbdata$주소? <- sbdata$도로명전체주소
mloc <- which(is.na(sbdata$주소))
if (length(mloc)>0) sbdata$주소[mloc] <- sbdata$소재지전체주소[mloc]

addrlist <- str_split(sbdata$주소, " ") 

#sbdata$시도 <- sapply(addrlist,function(x) x[1])

sido <- sapply(addrlist,function(x) x[1])
sigun <- sapply(addrlist,function(x) x[2])

vname <- c("번호","개방서비스명","개방자치단체코드","인허가일자","영업상태명","폐업일자",
      "소재지면적","사업장명","업태구분명","시설총규모","주소","시도")
write.csv(sbdata[,vname], file="starbucks.csv",row.names=FALSE)

# 5: 대전광역시, 울산광역시, 세종특별시 중 택일
# 선택된 지역 각 시군구별로 스타벅스 개수를 구하시오.

x <- paste(sido, sigun)
table(x)
table(sigun)