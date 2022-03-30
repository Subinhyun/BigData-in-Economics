### 한글 인코딩 에러 (Window)

<img width="688" alt="스크린샷 2022-03-23 오후 8 30 26" src="https://user-images.githubusercontent.com/48265714/159689788-5788dcf8-5787-4743-b4c8-d7bb53dbdd0b.png">

- 방법 1 

cars dataframe 만든 후, 

write.csv(cars,file=”usedcars.csv”)

cars <- read.delim("usedcars.csv",sep = ",",header = T)

- 방법 2

cars$price <- as.numeric(iconv(cars$price, to="CP949"))

### 한글 인코딩 에러 (Mac)

<img width="355" alt="스크린샷 2022-03-25 오후 3 48 42" src="https://user-images.githubusercontent.com/48265714/160069203-c1a2d441-85a4-4175-9d43-56a5df65a81f.png">

맥이나 리눅스에서는 UTF-8을 사용하기 때문에 발생하는 에러 ?!

코드에 
, header = T, fileEncoding = "euc-kr" 추가!

<img width="585" alt="스크린샷 2022-03-25 오후 3 50 09" src="https://user-images.githubusercontent.com/48265714/160069334-657b5684-3e27-4a0b-99db-36434fd8be8b.png">

warning을 없애려면 quote="" 해주기.
