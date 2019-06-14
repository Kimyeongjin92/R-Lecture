###================================================================
### 다양한 함수 사용법 386page.     Sigma(Xi-u)^2         =========
###                                 -------------         =========
### max min sum mean prod sd  var =  N (or N-1)  분산공식 =========
###================================================================

?subset() # help기능
??ggplot2

vec1 <- c(1:5)
vec2 <- c('a','b','c','d','e')
max(vec1); min(vec1); sum(vec1)
mean(vec1); sd(vec1); var(vec1)
max(vec2)  # 사전 순서로 뒤의 것(e)이 나옴


###===============================================================
### aggregate(계산될컬럼~기준될컬럼,데이터,함수) =================
###===============================================================

library(googleVis)
Fruits
aggregate(Sales~Year,Fruits,sum) #년도별 판매 총액
aggregate(Sales~Year,Fruits,max)
aggregate(Sales~Year,Fruits,mean)

aggregate(Sales~Fruit,Fruits,sum)
aggregate(Sales~Fruit+Year,Fruits,sum) # 중요하다.


###===============================================================
### apply(대상,행1/열2,적용함수) =================================
###===============================================================

mat1 <- matrix(c(1,2,3,4,5,6),nrow=2,byrow=T) ; mat1
apply(mat1,1,sum)          # 1 - 행 단위 계산 
apply(mat1,2,sum)          # 2 - 열 단위 계산
apply(mat1,1,prod)         # prod 곱하기

apply(mat1[,c(2,3)],1,sum) # 응용

apply(data1[,c(2:15)],2,sum)


###===============================================================
### lapply() sapply() list형태의 데이터에 사용한다. ==============
###===============================================================

list1 <- list(Fruits$Sales)  ; list1
list2 <- list(Fruits$Profit) ; list2

lapply(c(list1,list2),max)  # matrix
sapply(c(list1,list2),max)  # Vector의 형태로 출력.

lapply(Fruits[,c(4,5)],max)
sapply(Fruits[,c(4,5)],max)


###===============================================================
### tapply(출력값,기준컬럼,적용함수) mapply(함수,벡터1,벡터2,..) =
###===============================================================

tapply(Sales, Fruit, sum) #attach를 먼저 해야한다.

#attach는 데이터 프레임에서 각 컬럼 이름을 변수 명처럼 처리해서 데이터를 쉽게 관리하게 하는 기능
attach(Fruits) 
tapply(Sales, Fruit, sum) #과일 이름별로 합계 판매량 구하기.

vec1 <- c(1:5)
vec2 <- seq(10,50,10)
vec3 <- seq(100,500,100)
mapply(sum,vec1,vec2,vec3)


###===============================================================
###==================  294page 연습문제  =========================
###===============================================================

data1 <- read.csv('data1.csv')

# 년도별 합계
mapply(sum,data1[,-1])
apply(data1[,-1],2,sum)

# 연령별 합계
apply(data1[,-1],1,sum)

data2 <- read.csv('1-4호선승하차승객수.csv')

# 노선 번호별 승차인원수 합계
attach(data2)
tapply(승차,노선번호,sum)
tapply(하차,노선번호,sum)

# 노선 번호 상관없이 승차 하차 인원수 합계
apply(data2[,c(3,4)],2,sum)
sapply(data2[,c(3,4)],sum)

# 노선 번호별 승차/하차 인원수 합계
aggregate(승차+하차~노선번호,data2,sum)
aggregate(승차~노선번호,data2,sum)
aggregate(하차~노선번호,data2,sum)
