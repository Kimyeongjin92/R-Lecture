# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-13-(목) / 148page

# 2번째 프로젝트 때 kaggle 

# Part 2-3 정형 데이터

### ============================================================================
### 예제 3-1  =============
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage3_StructuredData/Ex01_SeoulClinic")
getwd()

install.packages('plotly')
library(plotly)
library(reshape2)

data1 <- read.csv("2013년_서울_주요구별_병원현황.csv") ; data1

barplot(as.matrix(data1[1:9,2:11]),beside=T)
abline(h=seq(0,350,10),lty=3,lwd=0.2)

### ggplot으로 그리기.

data2 <- melt(data1,id=c('표시과목'),variable.name='지역명',value.name='병원수') 

a<- ggplot(data2,aes(x=지역명,y=병원수 ,fill=표시과목)) + 
  geom_bar(width=0.9, stat='identity',position="dodge",color="black") +
  geom_hline(yintercept=seq(0,330,10),lty='dashed',size=0.1)+
  theme_bw(base_family="baedal",base_size = 12) +  
  theme(axis.text.x  = element_text(angle= 45, hjust=1))+
  theme(axis.title.x = element_blank())+
  ggtitle('2013년_서울 주요구별 병원현황') +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 
ggplotly(a)


### ============================================================================
### 예제 3-3 구글차트로 그래프 실행하기. page. =================
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage3_StructuredData/Ex03_Google")
getwd()

library(googleVis)

data <- read.csv('2013년_서울_구별_주요과목별병원현황_구글용.csv')

hos <- gvisColumnChart(data, options=list(title="지역별 병원현황",height=400,weight=500))

plot(hos)

# 페이지 소스에서 utf-8을 확인하고 바꿔준다.
header <- hos$html$header

header <- gsub('charset=utf-8','charset=euc-kf',header)

hos$html$header <- header

plot(hos)


### ============================================================================
### 예제 3-4 =============
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage3_StructuredData/Ex04_Insurance")
getwd()

count <- read.csv('연도별요양기관별보험청구건수_2001_2013_세로.csv',stringsAsFactors=F)

count2 <-melt(count,id=c('년도'),variable.name='병원종류',value.name='건수')
count2 $건수 <- count2 $건수/1000000
options(digits = 2)

windowsFonts(baedal=windowsFont("배달의민족 도현")) # 글씨체

count3 <- ggplot(count2,aes(x=년도,y=건수,fill=병원종류, color=병원종류))+
  geom_line(linetype=1,size=1) +
  geom_point(size=3)+
  geom_hline(yintercept=seq(0,5000,500),lty='dashed',size=0.1)+
  theme_bw(base_family="baedal",base_size = 12)+
  ggtitle('연도별 요양기관별 보험청구건수 2001~2013') +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 
count3
ggplotly(count3)

### ============================================================================
### 예제 3-5 년도별 기관별 보험청구 금액 현황 분석후 그래프로 보여주기. ========
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage3_StructuredData/Ex05_Insurance2")
getwd()

count <- read.csv('연도별요양기관별보험청구금액_2004_2013_세로.csv',stringsAsFactors=F)
str(count)

count2 <-melt(count,id=c('년도'),variable.name='병원종류',value.name='금액')
#count2$년도 <- gsub("X","",count2$년도)
#count2$건수 <- gsub(",","",count2$건수)
#count2$건수 <- as.numeric(count2$건수)
count2$금액 <- count2$금액/1000000
options(digits = 2)


count3 <- ggplot(count2,aes(x=년도 ,y=금액,fill=병원종류, color=병원종류))+
  geom_line(linetype=1,size=1) +
  geom_point(size=3)+
  geom_hline(yintercept=seq(0,8000,1000),lty='dashed',size=0.1)+
  theme_bw(base_family="baedal",base_size = 12)+
  ggtitle('연도별요양기관별보험청구금액_2004~2013') +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "black")) 
count3
ggplotly(count3)


### ============================================================================
### 예제 3-5 연습문제. 프로야구 선수들이 밥값 하나유? 165page. =================
### ============================================================================

library(dplyr)

baseball <- read.csv('주요선수별성적-2013년.csv',stringsAsFactors=F)

options(digits = 2)

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


