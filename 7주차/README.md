```R
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
```
스타벅스 실습에서 set.seed <- '학번 뒷자리 5개'로 했었다. 
알고보니 set.seed('학번') 인데 오류 표시가 나지 않아 
실행할 때마다 값이 바뀌어 나와 제대로된 답이 나오지 않았던 ..! 주의해야겠다.

```R
sumdata <- tourdata %>% group_by(sigun) %>%
      summarise(관광객=sum(touNum),현지인=sum(현지인),외지인=sum(외지인),외국인=sum(외국인)) %>%
      data.frame()
```
데이터를 출력할 때 데이터 프레임을 사용하면 훨씬 깔끔하게 보인다. 

### summarise()
- 평균, 빈도, 최대값 등 기본적인 통계치를 요약하고 싶을때 사용 

### group_by()
- group_by()를 사용하면 변수 항목별로 데이터를 분리

dplyr 패키지 사용

### %>% : 함수에 인수를 편하게 적용할 수 있게 해주는 operator
x %>% f(y) = f(x,y)
y %>% f(x, .) = f(x,y)
z %>% f(x, y, arg = .) = f(x,y,arg=z)

%>%을 기준으로 왼쪽을 lhs 오른쪽을 rhs
lhs에는 값을 주고 rhs에는 함수를 인수로!
