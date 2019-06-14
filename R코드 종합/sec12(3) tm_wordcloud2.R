# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-12-(수) / 104page


# Part 2-1(2) tm 패키지를 이용한 워드 클라우드 만들기.

# https://m.blog.naver.com/PostView.nhn?blogId=hsj2864&logNo=220978317440&proxyReferer=https%3A%2F%2Fwww.google.com%2F
### ============================================================================
### 예제 1-6 영어 문서 분석 (Steve Jobs 연설문 ) ===============================
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex06_Steve")
getwd()

install.packages('wordcloud')
install.packages('wordcloud2')
install.packages('tm') 
install.packages('KoNLP')
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)
library(tm)    # tm_mpa(),stopwords() / tm (text mining)의 약어
library(KoNLP) # gsub() : 단어 나열 /단어 file...

## 1. 데이터 불러오기
data1 <- readLines('tm_test1.txt') ; class(data1)
# mac을 사용할 경우 : data1 <- iconv(data1, "WINDOWS-1252","UTF-8")

## 2. 데이터를 tm패키지가 처리할 수 있는 형태인 Corpus(말뭉치) 형태로 변환.

# 위 데이터가 벡터면 VectorSourc() , Dataframe의 경우 Dataframe() 함수 사용.
# documents :4 일반적으로 원본파일이 총 4줄이라는 뜻  
# documents란 tm 패키지가 작업할 수 잇는 특별한 형태를 의미한다.
corp1 <- Corpus(VectorSource(data1)) ; corp1

# corpus 안의 내용을 보여준다.
inspect(corp1)

## 3. tm패키지가 분석 할 수 있는 Term-Document 형식의 Matrix로 변환해야 한다. 
tdm <- TermDocumentMatrix(corp1) ; tdm

m   <- as.matrix(tdm)

# 불필요한 단어 제거
corp2  <- tm_map(corp1,stripWhitespace)        # 여러개의 공백을 하나의 공백으로 변환
corp2  <- tm_map(corp2,tolower)                # 대문자가 있을 경우 소문자로 변환
corp2  <- tm_map(corp2,removeNumbers)          # 숫자를 제거
corp2  <- tm_map(corp2,removePunctuation)      # 마침표,콤마,세미콜론,콜론 등의 문자 제거
sword2 <- c(stopwords('en'),'and','but','not') # 영어의 관사 대명사 접속사 등  불용어 제거
corp2  <- tm_map(corp2,removeWords,sword2)
#corp2  <- tm_map(corp2,removeWords,stopwords('en'))

stopwords('en')

tdm2   <- TermDocumentMatrix(corp2); tdm2

m2  <- as.matrix(tdm2) ; m2

class(m2)

colnames(m2) <- c(10,40,10) ; m2

freq1 <- sort(rowSums(m2),decreasing = T)
head(freq1,20)
freq2 <- sort(colSums(m2),decreasing = T)
head(freq2,20)

findFreqTerms(tdm2,2)
palete <- brewer.pal(7,"Set3")
windowsFonts(baedal=windowsFont("배달의민족 도현"))

par(bg="black")
wordcloud(names(freq1),
          freq=freq1,
          scale=c(5,1),
          min.freq=1,
          colors=palete,
          random.order=F,
          random.color=T,
          family="baedal")

barplot(freq1,main="tm package test #2", las=2, ylim=c(0,5))


# ====================================================
# ====================================================
# ====================================================


data1 <- readLines("steve.txt")

corp1 <- Corpus(VectorSource(data1)) ; corp1

inspect(corp1)

# 불필요한 단어 제거
corp2  <- tm_map(corp1,stripWhitespace)
corp2  <- tm_map(corp2,tolower)
corp2  <- tm_map(corp2,removeNumbers)
corp2  <- tm_map(corp2,removePunctuation)
# corp2  <- tm_map(corp2,PlainTextDocument)    # 현 버전에서는 에러발생.
sword2 <- c(stopwords('en'),'and','but','not') # 영어의 관사 대명사 접속사 등 
corp2  <- tm_map(corp2,removeWords,sword2)
#corp2  <- tm_map(corp2,removeWords,stopwords('en'))

stopwords('en')

corp3 <- TermDocumentMatrix(corp2,control=list(wordLengths=c(1,Inf))); corp3

findFreqTerms(corp3,10)

findAssocs(corp3,"apple",0.5)

corp4 <- as.matrix(corp3)

freq1 <- sort(rowSums(corp4),decreasing = T)
head(freq1,20)
freq2 <- sort(colSums(corp4),decreasing = T)
head(freq2,20)

dim(corp4)

colnames(corp4) <- c(1:59)
freq2 <- sort(colSums(corp4),decreasing = T)

palete <- brewer.pal(7,"Set3")
windowsFonts(baedal=windowsFont("배달의민족 도현"))

par(bg="black")
wordcloud(names(freq1),
          freq=freq1,
          scale=c(3,0.1),
          min.freq=1,
          colors=palete,
          random.order=F,
          random.color=F,
          family="baedal")
legend(0.1,0.9,
       "Steve Jobs 연설문",
       cex=1,
       fill=NA,
       border=NA,
       bg="white",
       text.col="red",
       text.font=2,
       box.col="red")


### ===========================================================================
### 예제 1-7 특정 키워드만 골라내서 분석하기. (정규식 활용)  ==================
### ===========================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex07_RegEx")
getwd()

alert <- readLines('oracle_alert_testdb.log')

error_1 <- gsub(" ","-",alert) # 로그 메세지들에 공백이 있어서 '-'로 변경
head(unlist(error_1),20)

error_2 <- unlist(error_1)
error_2 <- Filter(function(x){nchar(x) >= 5},error_2) # 5글자 이상인 것만

error_3 <- grep("^ORA-+", error_2, value=T) # 문장의 제일 처음이 ORA로 시작하는 것만 찾아라.
head(unlist(error_3),20)

write(unlist(error_3),"alert_testdb2.log")
rev <- read.table("alert_testdb2.log")
nrow(rev)

errorcount <- table(rev)
head(sort(errorcount,decreasing = T))

par(bg="black")
wordcloud(names(errorcount),
          freq=errorcount,
          scale=c(3,0.1),
          min.freq=1,
          colors=palete,
          random.order=F,
          random.color=T,
          family="baedal")
legend(0.3,0.1,
       "Oracle Alert Log File 분석결과",
       cex=0.8,
       fill=NA,
       border=NA,
       bg="white",
       text.col="red",
       text.font=2,
       box.col="red")


### ============================================================================
### 예제 1-6 영어 문서 분석 (Steve Jobs 연설문 ) ===============================
### ============================================================================
