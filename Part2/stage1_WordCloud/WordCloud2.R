# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-11-(화) / 71page

# Part 2-2
##============================================================================
## 예제 1-4 서울시 응답소 페이지 분석하기  ===================================
##============================================================================
setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage1_WordCloud/Ex06_Steve")
getwd()

install.packages('wordcloud')
install.packages('tm') # tm (text mining)의 약어
library(wordcloud)
library(tm)

data1 <- readLines('tm_test1.txt') ; classs(data1)
data1 <- iconv(data1, "WINDOWS-1252","UTF-8")

corp1 <- Corpus(VectorSource(data1)) ; corp1

inspect(corp1)

tdm <- TermDocumentMatrix(corp1) ; tdm

m   <- as.matrix(tdm)

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

tdm2   <- TermDocumentMatrix(corp2); tdm2

m2  <- as.matrix(tdm2) ; m2

class(m2)
