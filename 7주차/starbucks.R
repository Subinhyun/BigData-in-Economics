rm(list=ls())
options(warn=-1,width=80,scipen=10) 
sdir <- "C:/Temp/bigdata/week7/"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)

# 실습1
# 스타벅스 자료 읽기
data <- read.csv("starbucks.csv")

data$opened <- as.integer(data$영업상태명=="영업/정상")
data$closed <- as.integer(data$영업상태명=="폐업")

# 임의 표본 추출
nsmpl <- 1000
set.seed(04135)

sloc <- sample(1:nrow(data))[1:nsmpl]
sbdata <- data[sloc,]
sidodata <- sbdata %>% group_by(시도) %>%
  summarise(점포수=n(),운영=sum(opened),폐업=sum(closed),
               폐업률=mean(closed)) %>% data.frame()

sidodata