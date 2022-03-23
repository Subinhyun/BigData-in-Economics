### 한글 인코딩 에러

<img width="688" alt="스크린샷 2022-03-23 오후 8 30 26" src="https://user-images.githubusercontent.com/48265714/159689788-5788dcf8-5787-4743-b4c8-d7bb53dbdd0b.png">

- 방법 1 

cars dataframe 만든 후, 

write.csv(cars,file=”usedcars.csv”)

cars <- read.delim("usedcars.csv",sep = ",",header = T)

- 방법 2

cars$price <- as.numeric(iconv(cars$price, to="CP949"))
