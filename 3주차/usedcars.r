# usedcars.r
  rm(list=ls())
  options(warn=-1,width=80,scipen=10) #suppress warning messages

# 현재 작업 위치 작업위치 설정
  sdir <- "c:/temp/bigdata/"
  if (!file.exists(sdir)) dir.create(sdir)
  setwd(sdir)

# 관련 패키지 설치 및 불러오기
# install.packages("rvest" )	 #웹 스크래핑 패키지
# install.packages("stringr") 	# 문자열 처리 패키지
  library(rvest)
  library(stringr)

# 보배드림 사이트에서 중고차 정보 가져오기 
# 웹 스크래핑 대상 URL 할당
  url <- "http://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K"
  usedCar <- read_html(paste(url,"&page=",1,sep="")) # 웹 문서 가져오기

# 특정 태그의 데이터 추출
# 가져온 usedCar에서 css가 ".product-item"인 것을 찾음
  carInfos <- html_nodes(usedCar, css=".product-item")

# 차량 명칭 추출
  title_tmp <- html_nodes(carInfos, css=".tit.ellipsis")	
  title <- str_trim(html_text(title_tmp)) # 문자열에서 공백,특수문자 제거

# 차량 연식 추출
  year_tmp <- html_nodes(carInfos, css=".mode-cell.year")
  year <- str_trim(html_text(year_tmp))

# 연료 구분
  fuel_tmp <- html_nodes(carInfos, css=".mode-cell.fuel")
  fuel <- str_trim(html_text(fuel_tmp))

# 주행거리 추출
  km_tmp <- html_nodes(carInfos, css=".mode-cell.km")
  km <- str_trim(html_text(km_tmp))

# 판매가격 추출
  price_tmp <- html_nodes(carInfos, css=".mode-cell.price")
  price <- str_trim(html_text(price_tmp))
  price <- gsub('\n','', price) # 문자열 변경(\n을 blank로 변경)

# 차량 명칭으로부터 제조사 추출
  maker <- sapply(str_split(title,' '), function(x) x[1])

# 데이터프레임 만들기
  cars <- data.frame(title, year, fuel, km, price, maker)

# 데이터 정제
# price 자료 숫자로 변경, 가격이 없는 자료는 삭제
  cars$price <- gsub("만원","",cars$price)
  cars$price <- gsub(",","",cars$price)
  cars$price <- as.numeric(iconv(cars$price,to="UTF-8"))
  cars <- cars[which(!is.na(cars$price)),]

# km 자료 숫자로 변경
  cars$km <- gsub("만km", "0000", cars$km)	 # 문자열 변환("만m"−>"0000")
  cars$km <- gsub("천km", "000", cars$km)
  cars$km <- gsub("km", "", cars$km)
  cars$km <- as.numeric(gsub(",","",cars$km))	 	 # 숫자형으로 변경
  cars <- cars[which(!is.na(cars$km)),]

  write.csv(cars,file="usedcars.csv")
