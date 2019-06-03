# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-03-(월) / 402page


###===============================================================================
### 데이터 정렬하기 sort(,decreasing=T) ==========================================
###===============================================================================

library(googleVis)

sort1 <- Fruits$Sales
sort(sort1)               # Ascending  오름차순
sort(sort1,decreasing=T)  # Descending 내림차순


###===============================================================================
### plyr()  : (apply의 ply) apply와 다르게 dataframe으로 입출력가능  =============
###                                                                  =============
###       d : data frame / a : array(matrix포함) / l : list          =============
###===============================================================================

install.packages("plyr")
library(plyr)

fruits <- read.csv("fruits_10.csv") ;fruits

ddply(fruits,'name',summarise,sum_qty=sum(qty),sum_price=sum(price))
#furits의 이름으로 그룹을 해서 qty와 price를 더해서 요약해라

ddply(fruits,'name',summarise,max_qty=max(qty),min_price=min(price))
ddply(fruits,c('year','name'),summarise,max_qty=max(qty),min_price=min(price)) 
#year에 따라 name이 하나씩밖에 없기 때문에 그룹핑 NONO 그대로 출력된다.  

ddply(fruits,'name',transform,sum_qty=sum(qty),pct_qty=(100*qty)/sum(qty))


###===============================================================================
###        [ dplyr()패키지 : 데이터 전처리과정에서 많이 사용된다. ]     ==========
###                                                                     ==========
### filter  : 조건을 주어서 필터링을 한다.                              ==========
### select  : 여러 컬럼(변수)에서 특정 컬럼(변수)를 선택해 사용.        ==========
### arrange : 추출한 다음에 sort(순서)를 하는 것.                       ==========
### mutate  : 새로운 컬럼을 추가(기존의 변수 활용하여 새로운 변수 생성) ==========
### summarise(with group_by) : 그룹핑                                   ==========
###===============================================================================

install.packages('dplyr')
library(dplyr)
mtcars #dplyr에서 갖고있는 데이터셋

data1 <- read.csv("2013년_프로야구선수_성적.csv")      ; data1
data2 <- filter(data1,경기>120)                        ; data2
data3 <- filter(data1,경기>120&득점>80)                ; data3
data4 <- filter(data1,포지션 %in% c('1루수','3루수'))  ; data4 # %in%(~에 속한다) 1,3루수 선수만
data4 <- filter(data1,포지션=='1루수'|포지션=='3루수') ; data4 # == | ==

select(data1,선수명,포지션,팀)
select(data1,포지션:타수)
select(data1,-포지션,-타수)
select(data1,-홈런,-타점,-도루) # - 특정컬럼 제외

data1 %>% select(선수명,팀,경기,타수) %>% filter(타수>400)
data1 %>% select(선수명,팀,경기,타수) %>% filter(타수>400) %>% arrange(desc(타수),desc(경기))
data1 %>% select(선수명,팀,경기,타수) %>% filter(타수>400) %>% mutate(경기x타수= 경기*타수) %>% arrange(경기x타수)
data1 %>% select(선수명,팀,출루율,장타율) %>% mutate(OPS=출루율+장타율) %>% arrange(desc(OPS))

aggregate(경기~팀,data1,mean)                                       # 팀별 경기평균(1개 구할때 유효)
data1 %>% group_by(팀) %>% summarise(avarage = mean(경기,na.rm=T))  # 팀별 경기평균 na.rm=T
data1 %>% group_by(팀) %>% summarise_each(funs(mean),경기,타수)     # 팀별 경기,타수 평균 
data1 %>% group_by(팀) %>% summarise_each(funs(mean,n()),경기,타수) # n()은 mean을 구하기위한 /n의 갯수.
# funs = deprecated : 지금은 사용할 수 잇지만 앞으로 우리 함수는 제외할거다. 
# 그러니까 funs 사용을 자제 해주세요 대신 list를 사용해주세요 (version up)
data1 %>% group_by(팀) %>% summarise_each(list(mean),경기,타수)


###===============================================================================
###                            연습문제                                  =========
###===============================================================================

library(googleVis)
attach(Fruits)

Fruits %>% filter(Expenses>80)
Fruits %>% filter(Expenses>90,Sales>90)
Fruits %>% filter(Expenses>90 | Sales>80)
Fruits %>% filter(Expenses==79 | Expenses==91)
Fruits %>% select(Fruit:Sales,-Location)
Fruits %>% group_by(Fruit) %>% summarise(avarage=sum(Sales,na.rm=T))
Fruits %>% group_by(Fruit) %>% summarise_each(funs(sum,n()),Sales,Profit)
