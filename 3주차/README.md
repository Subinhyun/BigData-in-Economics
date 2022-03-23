### 한글 인코딩 에러

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f9a79f57-2eac-4a7b-925b-8eca76c236c1/Untitled.png)

방법 1 

cars dataframe 만든 후, 

write.csv(cars,file=”usedcars.csv”)

cars <- read.delim("usedcars.csv",sep = ",",header = T)

방법 2

cars$price <- as.numeric(iconv(cars$price, to="CP949"))
