# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-11-(화) / 71page

# Part 2
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

useSejongDic()
# 한글에 저장되어 있는 세종사전 사용함을 알려줌.
# Console 창에 1을 눌러 모두 설치한다.

mergeUserDic(data.frame('서진수','ncn'))
# 1 words were added to dic_user.txt. <- 이 파일이 사전파일.

data1 <- read