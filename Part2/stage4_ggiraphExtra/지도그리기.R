# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-14-(금) / 책에 없음

# Part 2-4 지도 데이터 활용하기(1)

### ============================================================================
###  =============
### ============================================================================
setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage4_ggiraphExtra")
getwd()

install.packages("ggiraphExtra")
install.packages("tibble")   # rownames_to_column()
install.packages("maps")     # map_data
install.packages("mapproj")  # ggChoropleth
library(gridExtra)
library(mapproj)
library(maps)
library(ggiraphExtra)
library(tibble)
library(ggplot2)
library(dplyr)
library(reshape2)
library(extrafont)

windowsFonts(baedal="배달의민족 도현")
theme_update(text=element_text(family="baedal"))

str(USArrests)
head(USArrests)
tail(USArrests)
summary(USArrests)

# 기존의 rowname을 변수로 끌고 나오기위해 tibble이 필요함
crime <- rownames_to_column(USArrests, var="state")

crime$state <- tolower(crime$state)

# 미국 주 지도 데이터 준비하기
states_map <- map_data('state')
str(states_map)

# 단계 구분도 만들기
ggChoropleth(data=crime,
             aes(fill=Murder,       # 색으로 표현할 변수
                 map_id=state),     # 지역 기준 변수
             map=states_map)    # 지도 데이터

# 인터랙티브 단계 구분도
ggChoropleth(data=crime,
             aes(fill=Rape,         # 색으로 표현할 변
                 map_id=state),     # 지역 기준 변수
             map=states_map,        # 지도 데이터
             interactive = T)       # 인터랙티브


# 지도 4개 그리기.
a <- ggChoropleth(data=crime,
             aes(fill=Rape,         # 색으로 표현할 변수
                 map_id=state),     # 지역 기준 변수
             map=states_map)+       # 지도 데이터
  ggtitle("미국 주별 범죄 분포","(단위: 인구 10만명당 건수)") +
  xlab('경도') +
  ylab('위도') +
  theme(plot.title = element_text(family="baedal",
                                  face ="bold",
                                  hjust= 0.5,
                                  size = 20,
                                  color= 'skyblue'))


b <- ggChoropleth(data=crime,
                  aes(fill=Rape,         # 색으로 표현할 변수
                      map_id=state),     # 지역 기준 변수
                  map=states_map)+       # 지도 데이터
  ggtitle("미국 주별 강간범죄 분포","(단위: 인구 10만명당 건수)") +
  xlab('경도') +
  ylab('위도') +
  theme(plot.title = element_text(family="baedal",
                                  face ="bold",
                                  hjust= 0.5,
                                  size = 20,
                                  color= 'skyblue'),
        plot.subtitle = element_text(hjust = 1.0))

c <- ggChoropleth(data=crime,
                 aes(fill=Rape,         # 색으로 표현할 변수
                     map_id=state),     # 지역 기준 변수
                 map=states_map)+       # 지도 데이터
  ggtitle("미국 주별 강도범죄 분포","(단위: 인구 10만명당 건수)") +
  xlab('경도') +
  ylab('위도') +
  theme(plot.title = element_text(family="baedal",
                                  face ="bold",
                                  hjust= 0.5,
                                  size = 20,
                                  color= 'skyblue'),
        plot.subtitle = element_text(hjust = 1.0))

d <- ggChoropleth(data=crime,
                  aes(fill=Rape,         # 색으로 표현할 변수
                      map_id=state),     # 지역 기준 변수
                  map=states_map)+       # 지도 데이터
  ggtitle("미국 주별 도시비율 분포") +
  xlab('경도') +
  ylab('위도') +
  theme(plot.title = element_text(family="baedal",
                                  face ="bold",
                                  hjust= 0.5,
                                  size = 20,
                                  color= 'skyblue'))


windows()
grid.arrange(a,b,c,d,ncol=2, top="미국 강력범죄")


### ============================================================================
###  대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기.,
### ============================================================================

# 1) 대한민국 시도별 인구 단계 구분도 만들기
install.packages('stringi')
install.packages('devtools')
library(stringi)
library(devtools)
library(dplyr)

# 이 패키지에 있는 깃 허브("cardiomoon/kormaps2014")를 인스톨 하겠다.
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

# rename(데이터, 바꿀이름 = 기존이름)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동,)


korpop1 <- rename(korpop1, 남자_명 = 한글)

str(changeCode(korpop1))
head(changeCode(korpop1))

# 단계 구분도 만들기
ggChoropleth(data=korpop1,
             aes(fill=총인구_명,              # 색으로 표현할 변수
                 map_id=code,                 # 지역 기준 변수
                 tooltip=행정구역별_읍면동),  # 지도 위에 표시할 지역명
             map=kormap1,                     # 지도 데이터
             interactive=T)    # 지도 데이터

# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기.
str(changeCode(tbc))
ggChoropleth(data=tbc,
             aes(fill=NewPts,             
                 map_id=code,
                 tooltip=name),     
             map=kormap1,
             interactive=T)
