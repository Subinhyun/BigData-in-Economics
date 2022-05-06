rm(list=ls())
options(warn=-1,width=80,scipen=10) 
sdir <- "/Users/d0dduck/Downloads/"
if (!file.exists(sdir)) dir.create(sdir)
setwd(sdir)

install.packages("dplyr")
library(dplyr)

data <- read.csv("twosome.csv", fileEncoding = "euc-kr")

data$opened <- as.integer(data$영업상태명=="영업/정상")
data$closed <- as.integer(data$영업상태명=="폐업")

nsmpl <- 1000
set.seed(04135)
sloc <- sample(1:nrow(data))[1:nsmpl]
sbdata <- data[sloc,]

sidodata <- sbdata %>% group_by(시도) %>%
  summarise(점포수=n(),운영=sum(opened),폐업=sum(closed),
               폐업률=mean(closed)) %>% data.frame()

sidodata

