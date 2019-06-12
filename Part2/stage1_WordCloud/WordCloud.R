# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-11-(화) / 71page

###=======================================================================================
### 폰트 설치하기. =======================================================================
###=======================================================================================

install.packages("extrafont")
library(extrafont)
# 모든 글씨체는 제어판  →  글꼴 폴더에 설치가 되어 있어야 한다.
font_import()
y
loadfonts(device="win")

#원하는 글씨체 
font_import(pattern = "")

windowsFonts(malgun=windowsFont("맑은 고딕"))
windowsFonts(headline=windowsFont("HY헤드라인M"))
windowsFonts(baedal=windowsFont("배달의민족 도현"))

# Part 2-1(1) KoNLP(한글) 패키지로 워드 클라우드 만들기.

###=======================================================================================
### 비정형 데이터 분석 후 워드 클라우드 생성하기. ========================================
###=======================================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex01_Seoul_Response")
getwd()

install.packages('KoNLP')     # 한글 형태소 분석 
install.packages('wordcloud') # wordcloud 작업
install.packages('rJava')
library(KoNLP)
library(wordcloud)
library(rJava)
library(RColorBrewer)

useSejongDic()
# 한글에 저장되어 있는 세종사전 사용함을 알려줌.
# Console 창에 1을 눌러 모두 설치한다.

# mergeUserDic(data.frame('서진수','ncn'))
# 1 words were added to dic_user.txt. <- 이 파일이 사전파일.

## 1.
data1 <- readLines("seoul_new.txt")

# extractNoun 명사를 분류해 준다.
extractNoun('서울시 버스정책을 역행하는 행위를 고발합니다.')

## 2. list형태의 명사들만 있는 데이터
data2 <- sapply(data1,extractNoun, USE.NAMES = F)
data2

## 3. list 형태가 아닌 명사 데이터. array
head(unlist(data2),30)
data3 <- unlist(data2)
data3

## 4. 걸러내기
data3 <- gsub("\\d+","",data3)   # d 모든 숫자 없애기
data3 <- gsub("서울시","",data3)
data3 <- gsub("서울","",data3)
data3 <- gsub("요청","",data3)
data3 <- gsub("제안","",data3)
data3 <- gsub(" ","",data3)
data3 <- gsub("-","",data3)
data3

## 4. 걸러내기(2)
# gsubfile을 만들어서 for 함수로 돌리면 제거할 수 있다.
data3 <- gsub("ㅇㅇ","",data3) 
data3 <- gsub("00","",data3) 
data3 <- gsub("OO","",data3) 
data3 <- gsub("oo","",data3) 
data3 <- gsub("개선","",data3) 
data3 <- gsub("문제","",data3) 
data3 <- gsub("관리","",data3) 
data3 <- gsub("민원","",data3) 
data3 <- gsub("이용","",data3) 
data3 <- gsub("관련","",data3) 
data3 <- gsub("관리","",data3) 
data3 <- gsub("시장","",data3) 

## 4. 걸러내기(3)
data3 <- Filter(function(x){nchar(x) >= 2 & nchar(x) <= 6},data3)

## 5. 빈칸 제거하기(read.table로 불러 공백 제거.)

write(unlist(data3),"seoul_2.txt")
data4 <- read.table('seoul_2.txt') ; data4
nrow(data4) #제거 확인.
## 6. 명사의 개수와 추가적으로 제거할 명사 구분.
wordcount <- table(data4) ; wordcount
head(sort(wordcount, decreasing=T),20)


##============================================================================
## 예제 1-1 서울시 응답소 페이지 분석하기  ===================================
##============================================================================

# 색상 설정하기 
# 참고 https://www.r-graph-gallery.com/38-rcolorbrewers-palettes/
# 참고 https://steemit.com/wordcloud/@hironlee/r-wordcloud
# set.seed(1234) : 이 명령어와 함께 실행하면 그림이 고정된다.
library(RColorBrewer)
display.brewer.all()           # 색상참고.

palete <- brewer.pal(9,"Set3") # 9는 사용할 색상개수, 색상타입이름.
pal <- brewer.pal(5,"YlGn")
pal1<- brewer.pal(7,"YlOrRd")
green <- brewer.pal(6,"RdYlGn")
red <- brewer.pal(7,"YlOrRd")
blue <- brewer.pal(6,"Blues")
set <- brewer.pal(7, "Set3")
pp <- brewer.pal(7,"RdYlGn")


wordcloud(names(wordcount),
          freq=wordcount,   #
          scale=c(5,0.2),   # 빈도가 가장 큰 단어와 가장 빈도가 작은 단어 폰트 사이 크기
          rot.per=0.25,     # 90도 회정해서 보여줄 단어 비율.
          min.freq=1,       # 이 값 이상 언급된 단어만 출력.
          max.words=1000,    # 빈도 3이상 100미만 단어 표현.
          random.order=F,   # (F)빈도가 큰 단어를 중앙에 두도록 함.
          random.color=F,   # (T)색상랜덤/(F)빈도수순으로 색상표현.
          colors=palete,
          family="baedal") 
legend(0.3,1,"서울시 응답소 요청사항 분석",
       cex=0.8,
       fill=NA,
       border=NA,
       bg="white",
       text.col="red",
       text.font=2,
       box.col="red")

###

v1 <- ("봄이 지나면 여름이고 여름이 지나면 가을입니다. 그리고 겨울이죠.")
extractNoun(v1)

# 띄어쓰기(공백)를 기중으로 단어를 판단하기 때문에 이상해진다.
v2 <- ("봄이지나 면여름이고 여름이지나면가을 입니다.")
extractNoun(v2)

# 2줄 이상..
v3 <- c("봄이 지나면 여름이고 여름이 지나면 가을입니다",
        "그리고 겨울이죠")
extractNoun(v3)

v4 <- sapply(v3,extractNoun,USE.NAMES=F)

#
wordcloud(c(letters,LETTERS,0:9),seq(1,1000,len=62))
wordcloud(c(letters,LETTERS,0:9),seq(1,1000,len=62),colors=palete)




##============================================================================
## 예제 1-2 여고생은 어디를 가장 고치고 싶을까요?  ===========================
##============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex02_HS_Girls")
getwd()

data1 <- readLines("remake.txt")
data2 <- sapply(data1,extractNoun,USE.NAMES=F)
data3 <- unlist(data2)
data3 <- Filter(function(x){nchar(x) <= 10},data3)
head(unlist(data3),30)

data3 <- gsub("\\d+","",data3)
data3 <- gsub("쌍수","쌍꺼풀",data3)
data3 <- gsub("쌍커풀","매부리코",data3)
data3 <- gsub("메부리코","",data3)
data3 <- gsub("\\.","",data3)
data3 <- gsub("","",data3)
data3 <- gsub("\\'","",data3)

write(unlist(data3),"remake_2.txt")
data4 <- read.table("remake_2.txt")
nrow(data4)
wordcount <- table(data4)
wordcount

head(sort(wordcount,decreasing=T),20)
txt <- readLines("성형gsub.txt")
cnt_txt <- length(txt)
i <- 1
for(i in 1:cnt_txt){
  data3 <- gsub((txt[i]),"",data3)
}

data3 <- Filter(function(x){nchar(x)>=2},data3)
write(unlist(data3),"remake_2.txt")
data4 <- read.table('remake_2.txt')
nrow(data4)
wordcount <- table(data4)
wordcount
head(sort(wordcount, decreasing=T),30)

wordcloud(names(wordcount),
          freq=wordcount,   #
          scale=c(4,0.5),   # 빈도가 가장 큰 단어와 가장 빈도가 작은 단어 폰트 사이 크기
          rot.per=0.25,     # 90도 회정해서 보여줄 단어 비율.
          min.freq=1,       # 이 값 이상 언급된 단어만 출력.
          max.words=100,    # 빈도 3이상 100미만 단어 표현.
          random.order=F,   # (F)빈도가 큰 단어를 중앙에 두도록 함.
          random.color=T,   # (T)색상랜덤/(F)빈도수순으로 색상표현.
          colors=palete,
          family="headline") +
legend(0.2,1,"여고생들이 선호하는 성형수술 부위",
       cex=0.8,
       fill=NA,
       border=NA,
       bg="white",
       text.col="red",
       text.font=2,
       box.col="red")

##============================================================================
## 예제 1-3 제주도 추천 여행코스 찾기  =======================================
##============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex03_jeju")
getwd()

library(stringr)

mergeUserDic(data.frame(readLines("제주도여행지.txt"),"ncn"))

txt <- readLines("jeju.txt")
place   <- sapply(txt,extractNoun,USE.NAMES=F)
head(unlist(place),30)
cdata   <- unlist(place)

place   <- str_replace_all(cdata,"[^[:alpha:]]","") # --한글, 영어 외는 삭제.
place   <- gsub(" ","",place)
txt     <- readLines("제주도여행코스gsub.txt")
cnt_txt <- length(txt)
i <- 1
for(i in 1:cnt_txt){
  place <- gsub((txt[i]),"",place)
}
place
place <- Filter(function(x){nchar(x) >= 2},place)
write(unlist(place),"jeju_2.txt")
rev   <- read.table("jeju_2.txt")
nrow(rev)
wordcount <- table(rev)
head(sort(wordcount, decreasing=T),30)
library(plyr)

par(bg="black")
wordcloud(names(wordcount),
          freq=wordcount,   #
          scale=c(4,0.5),   # 빈도가 가장 큰 단어와 가장 빈도가 작은 단어 폰트 사이 크기
          rot.per=0.25,     # 90도 회정해서 보여줄 단어 비율.
          min.freq=1,       # 이 값 이상 언급된 단어만 출력.
          max.words=100,    # 빈도 3이상 100미만 단어 표현.
          random.order=F,   # (F)빈도가 큰 단어를 중앙에 두도록 함.
          random.color=T,   # (T)색상랜덤/(F)빈도수순으로 색상표현.
          colors=palete,
          family="baedal") +
  legend(0.3,0.9,"제주도 추천여행 코스 분석.",
         cex=0.8,
         fill='black',
         border=NA,
         bg="white",
         text.col="red",
         text.font=2,
         box.col="red")


