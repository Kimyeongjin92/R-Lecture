
# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-12-(금) / 104page

### 1. 다음의 문장을 좀더 효율적으로 개선하시오.
vec1 <- c(1:6)
vec2 <- c(10:5)
vec3 <- rep(1:3,each=2)
vec4 <- rep(1:3,2)
vec5 <- seq(1,11,2)

### 2. 다음과 같이 네명의 학생이 중간 시험과 기말 시험을 봤따.

# 1) 데이터 프레임으로 만드시오
이름 <- c('강경학','김태균','이성열','정은원')
중간 <- c(90,78,94,70)
기말 <- c(50,60,90,92)
df_score <- data.frame(이름=이름,중간=중간,기말=기말)

# 2) 평균이라는 필드를 추가하고 중간과 기말 시험의 평균을 구해서 할당하여라.
df_score$평균 <- apply(df_score[,-1],1,mean) 


### 3. 2번 문제에 학점이라는 필드를 만들고, 평균 성적에 따라 학점을 부여하시오.
df_score$학점 <- 
  ifelse(df_score$평균 >= 90, 'A',
  ifelse(df_score$평균 >= 80, 'B',
  ifelse(df_score$평균 >= 70, 'C',
  ifelse(df_score$평균 >= 60, 'D','F'))))
    

### 4. 양의 정수를 매개변수로 1에서부터 매개변수 값까지 홀수를 더해서 그 결과를 리턴하는 함수 oddSum을 작성 oddSum(100) for필수.
  oddSum <- function(limit){
    sum<-0
    for (i in 1:limit){
  # for (i in seq(1, limit, 2))
      if (i %% 2 == 1)
        sum <- sum +i
    }
    return(sum)
  }
oddSum(100)

### 5. R 내장 데이터인 IRIS를 이용

# 1) 'setosa' 종 Sepal.Width의 Box Plot
# setosa<-iris[(a<-iris[,5]=='setosa'),2]
# boxplot(setosa)$stat     # 2.9이하 4.4이상은 이상치

library(ggplot2)
library(dplyr)
setosa <- iris %>% filter(Species == 'setosa') %>% select(Sepal.Width)
ggplot(setosa,aes(y=Sepal.Width)) + geom_boxplot()
summary(setosa)
setosa$after <- ifelse(2.5 < setosa & setosa < 4.4 ,setosa, NA) 
#&&는 결과가 한가지만 나온다. 개별적으로 다 나오게 하기위해서는 &가 하나여야한다.
mean(setosa$Sepal.Width)   ; sd(setosa$Sepal.Width) 
mean(setosa$after,na.rm=T) ; sd(setosa$after,na.rm=T) 
          

# 2_1) 이상치 제거 전 평균, 표준편차
mean(setosa)  # 평균 3.428
sd(setosa)    # 표준편차 0.3790644

# 2_2) 이상치 제거 후 평균, 표준편차와 boxplot
setosa[(setosa < 2.9)]   # 이상치 2.3
setosa1<-setosa[(setosa != 2.3)]

mean(setosa1)  # 평균 3.45102
sd(setosa1)    # 표준편차 0.345882

boxplot(setosa1)$stat  


### 6. R 내장 데이터인 mpg를 이용 (toyota의 cty와 hwy 산술평균이 가장 좋은 3가지 모델과 평균연비)

library(ggplot2)
library(dplyr)
mpg %>% filter(manufacturer=='toyota') %>%
  group_by(model) %>% 
  summarise(avg=mean(cty+hwy)/2) %>%
  arrange(desc(avg)) %>% 
  head(3)

### 7. mpg 데이터를 이용하여 그래프를 그리시오.

# 1) suv자동차의 시내 연비(cty)가 높은 7개 회사와 시내 연비 
suv <- mpg %>% filter(class=='suv') %>%
  select('manufacturer','cty') %>% 
  group_by(manufacturer) %>%
  summarise_each(funs(mean),cty) %>%
  arrange(desc(cty)) %>% 
  head(7)
suv

# 2) 막대그래프 형식의 컬러그래프
windowsFonts(baedal=windowsFont("배달의민족 도현"))

ggplot(suv,aes(x=reorder(manufacturer,-cty),y=cty,fill=manufacturer))+
  geom_bar(stat="identity",color="black") +
  geom_hline(yintercept=seq(0,20,5),lty='dashed',size=0.1)+
  theme_bw(base_family="baedal",base_size = 15) +  
  theme(axis.text.x  = element_text(angle= 45, hjust=1))+
  theme(axis.title.x = element_blank())+
  ggtitle('시내 연비가 높은 7개 회사와 시내연비') +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 


### 8. R 내장 데이터인 'diamonds'를 이용하여 다음의 그래프를 그리시오.
diamonds
# 1) clarity의 돗수(n)을 보여주는 그래프
ggplot(diamonds,aes(x=clarity,fill=clarity)) +
  geom_bar(color="black") +
  theme_bw(base_family="baedal",base_size = 15) +  
  ggtitle("8번(1) clarity의 돗수 그래프") +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 


# 2) clarity에 따른 가격의 변화를 보여주는 그래프
clarity <- diamonds %>% 
  select(clarity,price) %>% 
  group_by(clarity) %>% 
  summarise(price_mean=mean(price,na.rm=T)) %>% 
  arrange(desc(price_mean))

ggplot(clarity,aes(x=clarity,y=price_mean,fill=clarity))+
  geom_bar(stat="identity",color="black")+
  theme_bw(base_family="baedal",base_size = 15) + 
  ggtitle("7번(2) clarity에 따른 가격의 변화 ")+
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 


### 9. 실습 데이터중 야구성적.csv 파일을 이용하여 다음의 그래프를 그리시오.

setwd("D:/dudwlsrla92/Assignment/[과제 7] 그래프 도전미션")
getwd()

library(dplyr)
library(ggplot2)
library(reshape2)

options(digits = 2)

# 1) OPS(출루율+장타율)와 연봉대비OPS(OPS/연봉*100)를 구하시오.

baseball <- read.csv('주요선수별성적-2013년.csv',stringsAsFactors=F)

baseball %>% 
  mutate(OPS=출루율+장타율) %>%
  mutate(연봉대비OPS율=round(OPS/연봉,1)) %>% 
  select(선수명,OPS,연봉대비OPS율)


# 2) 연봉대비 OPS를 선수별로 비교할 수 있는 막대그래프.
baseball %>% 
  mutate(OPS=출루율+장타율) %>%
  mutate(연봉대비OPS율=round(OPS/연봉,1)) %>% 
  select(선수명,연봉대비OPS율) %>%
  ggplot(aes(x=선수명,y=연봉대비OPS율,fill=선수명)) +
  geom_bar(stat="identity",position="dodge",color="black") +
  geom_text(aes(y=연봉대비OPS율+0.03, label=paste0(연봉대비OPS율,"%")), color='black',size=7) +
  geom_hline(yintercept=seq(0,1,0.125),lty='dashed',size=0.5) +
  theme_bw(base_family='baedal',base_size = 20) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.x  = element_text(angle=45, hjust=1)) +
  ggtitle('야구 선수별 연봉 대비 OPS율 분석') +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5,
                                  vjust = 2.5,
                                  size = 40, 
                                  color = "black")) 

