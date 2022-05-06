# midterm.r
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) 
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)


# �����л� �й� �б�
  stdinfo <- read.csv("�����л��й�.csv")
  sidocode <- c("11","26","27","28","29","30","31","36",
      "41","42","43","44","45","46","47","48","50")
  sidoname <- c("����","�λ�","�뱸","��õ","����","����","���","����",
      "���","����","���","�泲","����","����","���","�泲","����")

  for (i in 1:nrow(stdinfo)){
      cat("\n\n�л���:", stdinfo$����[i], "�й�:", stdinfo$�й�[i],"\n")
      sid <- as.integer(substr(stdinfo$�й�[i],
          nchar(stdinfo$�й�[i])-4,nchar(stdinfo$�й�[i])))
    # 1. �ҵ� N(300,100)
      set.seed(sid)
      income <- rnorm(1000,mean=300,sd=100)
      cat("(1.1) �ҵ� ���:",mean(income), "ǥ������:", sd(income),"\n")
      cat("(1.2) 400���� �̻��� �����?", length(which(income>=400)),"��\n")
      cat("(1.3) �ҵ� 1������(���� 10%) �ҵ���?", quantile(income,0.1),"����\n")

    # 2. ������
      set.seed(sid)
      asset1 <- rnorm(100,mean=200,sd=50)
      set.seed(sid)
      asset2 <- rnorm(100,mean=100,sd=35)
      cat("\n(2) ������� ��\n")
      cat("  �ڻ�1�� �������:", sd(asset1)/mean(asset1),"\n")
      cat("  �ڻ�2�� �������:", sd(asset2)/mean(asset2),"\n")

    # 3. �����÷��̽�
      data <- read.csv("twosome.csv")
    # ���� �߰�
      data$opened <- as.integer(data$�������¸�=="����/����")
      data$closed <- as.integer(data$�������¸�=="���")
      data$pmtyear <- as.integer(substr(data$���㰡����,1,4))

      set.seed(sid)
      sloc <- sample(1:nrow(data))[1:1000]
      sdata <- data[sloc,]
    # 3.1
      nstore <- table(sdata$�õ�)
      nstore <- nstore[order(nstore)]
      nsido <- length(nstore)
      cat("\n(3.1) �����÷��̽��� ���� ���� �õ�:",names(nstore)[1],"����",nstore[1],"\n")
      cat("      �����÷��̽��� ���� ���� �õ�:",names(nstore)[nsido],
          "����",nstore[nsido],"\n")
    # 3.2 ������� ���� ���� ������ ���� ���� ����
      sidodata <- sdata %>% group_by(�õ�) %>%
          summarise(������=n(),�=sum(opened),���=sum(closed),
              �����=mean(closed)) %>% data.frame()
      maxloc <- which(sidodata$�����==max(sidodata$�����))
      cat("\n(3.2) �����÷��̽� ������� ���� ���� �õ�:",sidodata$�õ�[maxloc],
          "�����(%):",sidodata$�����[maxloc]*100,"\n")
    # 3.3 ���� ���� â���� ����
      nyear <- table(sdata$pmtyear)
      nyear <- nyear[which(nyear==max(nyear))]
      cat("\n(3.3) �����÷��̽� â���� ���� ���� ����:",names(nyear),"â��������:",nyear,"\n")

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
      cat("\n(4) �ܱ��ΰ�������(�õ�: ",sidoname[sidoloc],")\n",sep="")
      cat("    2018�� �ܱ��ΰ�������:",tour2018,"��\n")
      cat("    2021�� �ܱ��ΰ�������:",tour2021,"��\n")
      cat("    2018-2021�� �ܱ��ΰ������� ������(%):",(tour2021/tour2018-1)*100,"\n")
  }
