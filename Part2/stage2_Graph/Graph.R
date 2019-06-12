# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-12-(수)2 / 135page


# Part 2-2 비정형 데이터를 분석 후 다양한 그래프 그리기.

### ============================================================================
### 예제 2-1 '제주도 여행코스 추천' 검색어 결과 그래프로 표시하기. =============
### ============================================================================

setwd("D:/dudwlsrla92/R_Data_Analysis/Part2/stage2_Graph/Ex01_jeju")
getwd()

install.packages('KoNLP')
install.packages('wordcloud')
install.packages('stringr')
library(KoNLP)
library(wordcloud)
library(stringr)
library(ggplot2)
library(plotrix)  # 3d 파이차트

useSejongDic()

mergeUserDic(data.frame(readLines("제주도여행지.txt"),"ncn"))

txt <- readLines("jeju.txt")
place   <- sapply(txt,extractNoun,USE.NAMES=F)
head(unlist(place),30)
cdata   <- unlist(place)

place   <- str_replace_all(cdata,"[^[:alpha:]]","") # --한글, 영어 외는 삭제.
place   <- gsub(" ","",place)
txt     <- readLines("제주도여행코스gsub.txt")

for(i in 1:length(txt)){
  place <- gsub((txt[i]),"",place)
}

place <- Filter(function(x){nchar(x) >= 2},place)
write(unlist(place),"jeju_2.txt")
rev   <- read.table("jeju_2.txt")
nrow(rev)
wordcount <- table(rev)
head(sort(wordcount, decreasing=T),30)
top10 <- head(sort(wordcount,decreasing = T),10)

# pie graph 그리기 =======================================================

pct <- round(top10/sum(top10)*100,1)

lab <- paste(names(top10),"\n",pct,"%")
lab <- paste(names(top10),"\n",pct,"%",sep='') # sep 는 빈칸 없애기.

palete <- brewer.pal(10,"Set3")
palete2 <- brewer.pal(7,"Reds")
windowsFonts(baedal=windowsFont("배달의민족 도현"))
  
pie(top10,
    col=palete,
    radius=0.9,
    main="제주도 추천 여행 코스 TOP10",
    cex=1.5,
    labels=lab,
    family="baedal")

# 3D pie graph 그리기 =======================================================

library(plotrix)

th_pct    <- round(top10/sum(top10)*100,1)
th_names  <- names(top10) # 변수 이름만 가져오기.
th_labels <- paste0(th_names,"\n","(",th_pct,")")

pie3D(top10,
      main="제주도 추천 여행 코스 Top 10",
      col=palete,
      cex=0.3,
      labels=th_labels,
      explode=0.05,
      family="baedal")


# barchart 그리기(1) 세로 =========================================================

bp <- barplot(top10,
        main="제주도 추천 여행 코스 TOP 10",
        col=palete,
        cex.names=0.7,
        las=2,
        ylim=c(0,25),
        family="baedal")
text(x = bp, y = top10*1.05, labels =paste("(",pct,"%",")"), col="black",cex=0.7)
text(x = bp, y = top10*0.95, labels =paste(top10,"건"), col="black",cex=0.7)


# barchart 그리기(2) 가로 =========================================================

bp <- barplot(top10,
              main="제주도 추천 여행 코스 TOP 10",
              col=palete,
              cex.names=0.7,
              las=2,
              xlim=c(0,25),
              family="baedal",
              horiz=T)
text(y = bp, x = top10*0.9, labels =paste0(top10,"건"), col="black",cex=0.7)
text(y = bp, x = top10*1.10, labels =paste0("(",pct,"%",")"), col="black",cex=0.7)



### ============================================================================
### ggplot으로 bar, pie graph 그리기. ==========================================
### ============================================================================

str(top10)
df_top10 <- as.data.frame(top10)

ggplot(df_top10,aes(x='',y=Freq,fill=rev,labes=lab)) + 
  geom_bar(width=1, stat='identity') 

ggplot(df_top10,aes(x=rev,y=Freq,fill=rev)) + 
  geom_bar(width=1, stat='identity') +
  coord_polar("y",start=0) 


library(dplyr)
options(digits = 2) # 알 프로그램 전체에 영향. 소수점하고 그 다음숫자 포함 2개만 쓰겠다. 0.0

df_top10 <- df_top10 %>% 
#  mutate(pct= Freq / sum(Freq)*100) %>% 
  mutate(pct= round(Freq / sum(Freq)*100,1)) %>% 
  mutate(ylabel = paste0(rev,pct, '%')) %>%  # paste에 0d이 붙으면 sep=''가 필요없다.
#  mutate(ylabel = paste(sprintf("%4.1f", pct), '%', sep='')) %>%
  arrange(desc(rev)) %>% # 그래프는 1에서부터 밑에서부터 깔아지기 때문에
  mutate(ypos = cumsum(pct) - 0.5*pct)
df_top10

ggplot(df_top10,aes(x='',y=Freq,fill=rev)) + 
  geom_bar(width=1, stat='identity') +
  geom_text(aes(y=ypos, label=ylabel), color='black')

ggplot(df_top10,aes(x='',y=Freq,fill=rev, family='baedal')) + 
  geom_bar(width=1, stat='identity') +
  geom_text(aes(y=ypos, label=ylabel), color='black') +
  coord_polar("y",start=0) +
  ggtitle('제주도 추천 여행 코스 TOP10') +
  theme_bw(base_family="baedal",base_size = 10) +
  theme(plot.title = element_text(family="baedal",
                                  face = "bold",
                                  hjust = 0.5, 
                                  size = 20, 
                                  color = "darkblue"))




