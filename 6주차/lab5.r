# week6.r
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

# �ǽ�1
# ��Ÿ���� �ڷ� �б�
  data <- read.csv("starbucks.csv")

# ���� ǥ�� ����
  nsmpl <- 1000
  set.seed <- 12345
  sloc <- sample(1:nrow(data))[1:nsmpl]
  sbdata <- data[sloc,]

# ���� �߰�
  sbdata$opened <- as.integer(sbdata$�������¸�=="����/����")
  sbdata$closed <- as.integer(sbdata$�������¸�=="���")

# �׷� �м�
  library(dplyr)
  sidodata <- sbdata %>% group_by(�õ�) %>%
      summarise(������=n(),�=sum(opened),���=sum(closed),�����=mean(closed)) %>%
      data.frame()

# �ǽ�2
  year <- 2021
  tourdata <- read.csv(paste("tourvisit",year,".csv",sep=""))
  tourdata$sigun <- paste(tourdata$signguCode, tourdata$signguNm)
  tourdata$������ <- as.integer(tourdata$touDivCd==1)*tourdata$touNum
  tourdata$������ <- as.integer(tourdata$touDivCd==2)*tourdata$touNum
  tourdata$�ܱ��� <- as.integer(tourdata$touDivCd==3)*tourdata$touNum

  sumdata <- tourdata %>% group_by(sigun) %>%
      summarise(������=sum(touNum),������=sum(������),������=sum(������),�ܱ���=sum(�ܱ���)) %>%
      data.frame()

# ������ ����1-5��
  sumdata[order(-sumdata$������)[1:5],]

# ������ ������ ���� 1-5��
  sumdata[order(-sumdata$������)[1:5],]

# �ܱ��� ������ ���� 1-5��
  sumdata[order(-sumdata$�ܱ���)[1:5],]
