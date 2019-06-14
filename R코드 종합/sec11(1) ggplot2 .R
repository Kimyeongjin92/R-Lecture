# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-10-(월) / 504page

https://nittaku.tistory.com/445
https://plot.ly/ggplot2/
###=======================================================================================
###=======================================================================================
###=======================================================================================

install.packages('ggplot2')
library(ggplot2)

korean <- read.table('학생별국어성적_new.txt',header=T,sep=',') ; korean

ggplot(korean,aes(x=이름,y=점수))+
  geom_bar(stat="identity",fill="light green", color="black")+
  ggtitle("I am \n Iron man")+
  xlab('a')+
  ylab('b')+
  theme(
    plot.title =element_text(face="bold.italic", color="royal blue", size=10),
    axis.text.x=element_text(angle=45,hjust=1,vjust=1,color="royal blue",size=8),
    axis.text.y=element_text(angle=45,hjust=1,vjust=1,color="royal blue",size=8))
# angle:각도 / hjust:  / vjust : 
#labs(title="I am \n Iron man",x ="a", y = "b")


###=======================================================================================
###=======================================================================================
###=======================================================================================
  

score_kem <- read.csv('학생별과목별성적_국영수_new.csv',header=T)

library(plyr) # reshape2 long포맷일때 편하게 쓸수 있다.

sort_kem  <- arrange(score_kem,이름,과목) # 정렬 가나다순.
sort_kem2 <- ddply(sort_kem,"이름",transform,누적합계=cumsum(점수),label=cumsum(점수)-0.5*점수)
# sec_8(3) transform 각 행별로 결과값이 나온다. 
# 요약은 summarise 
# cumsum : 누적합계 (누적되는 과정을 보여준다)


# 그러나 되도록이면 전처리 과정에서는 dplyr을 사용하도록 한다.
library(dplyr)

sort_kem2 <- sort_kem %>%
  group_by(이름) %>%
  mutate(누적합계=cumsum(점수))

sort_kem3 <- sort_kem2 %>%
  group_by(이름) %>%
  mutate(label-cusum(점수)-0.5*점수)

sort_kem4 <- sort_kem %>%
  group_by(이름) %>%
  mutate(누적합계=cumsum(점수))%>%
  mutate(label=cumsum(점수)-0.5*점수)

sort_kem5 <- sort_kem %>%
  group_by(이름) %>%
  mutate(누적합계=cumsum(점수),label=cumsum(점수)-0.5*점수)

ggplot(sort_kem5,aes(x=이름,y=점수, fill=과목))+
  geom_bar(stat="identity")+
  geom_text(aes(y=label,label=paste(점수,'점')),color="black",size=4)+
  guides(fill=guide_legend(reverse=T))


score <- read.table('학생별전체성적_new.txt',header=T,sep=",")
score_eng <- score[,c('이름','영어')]

ggplot(score, aes(x=영어, y=reorder(이름,영어)))+
  geom_point(size=4)+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="red",linetype = "dashed"))


ggplot(score, aes(x=영어, y=reorder(이름,영어)))+
  geom_segment(aes(yend=이름),xend=0,color="blue")+
  geom_point(size=6, color="green")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank())


###=======================================================================================
### geom_point() 함수와 scatterplots =====================================================
###=======================================================================================

install.packages('gridExtra')
library(gridExtra)

mtcars

str(mtcars)
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point()

ggplot(mtcars,aes(x=hp,y=disp))+
  geom_point()

ggplot(mtcars,aes(x=hp,y=disp))+
  geom_point(color='blue')

 # am 종류에 따라 색상다르게.
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(am),size=5))

# 종류별로 크기 지정하기 (size=wt 값에 따른 크기)
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(am),size=wt)) 

# 종류별로 크기와 모양 지정하기.
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(wt),shape=factor(am),size=wt)) 

# 종류별로 크기와 모양 색상 지정하기.
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(am),shape=factor(am),size=wt))+
  scale_color_manual(values=c("red","green"))

# 선 추가하기.
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(am),shape=factor(am),size=wt))+
  scale_color_manual(values=c("red","green"))+
  geom_line(color='blue')

# 레이블 바꾸기 label
ggplot(mtcars,aes(x=hp,y=mpg))+
  geom_point(aes(color=factor(am),shape=factor(am),size=wt))+
  scale_color_manual(values=c("red","green"))+
  geom_line(color='blue')+
  labs(x='마력',y='연비(mile/gallon)')+
  theme(plot.margin = unit(c(1,1,1,1), "cm"))


###=======================================================================================
### geom_line()함수 ======================================================================
###=======================================================================================


three <- read.csv('학생별과목별성적_3기_3명.csv')

sort_score <- arrange(three, 이름,과목)

ggplot(sort_score,aes(x=과목,y=점수,color=이름,group=이름,fill=이름,)) +
  geom_line()+
  geom_point(size=6,shape=22)+
  ggtitle("I am Iron man")
# geom_line()에서 색상을 지정하면 일일이 하나하나 지정해줘야한다.
# 비교적 aes에서 group color를 하는 것이 편하다.


###=======================================================================================
### geom_area()함수 ======================================================================
###=======================================================================================


dis <- read.csv('1군전염병발병현황_년도별.csv',stringsAsFactors=F)
# stringsAsFactors = T 는 년도별 Factor화 시켜줌.
str(dis)

ggplot(dis,aes(x=년도별,y=장티푸스,group=1))+
  geom_line()

ggplot(dis,aes(x=년도별,y=장티푸스,group=1))+
  geom_area()

# area에 색 입히기(!)  alpha = 투명도(진하기)
ggplot(dis,aes(x=년도별,y=장티푸스,group=1))+
  geom_area(color="black",fill="cyan",alpha=0.2)

# area에 색 입히기(2) 
ggplot(dis,aes(x=년도별,y=장티푸스,group=1))+
  geom_area(fill="cyan",alpha=0.2)+
  geom_line(color="sky blue")


###=======================================================================================
### Anscombe's Quartet  ==================================================================
###=======================================================================================

#기술통계량(평균(x), 평균(y), 분산(x), 분산(y), 상관계수, 회귀식)이 동일한 4개의 데이터 셋
anscombe
str(anscombe)


ans_x_mean <- anscombe %>% 
  select(x1:x4) %>% summarise_each(list(mean),x1:x4) 

ans_y_mean <- anscombe %>% 
  select(y1:y4) %>% summarise_each(list(mean),y1:y4) 

ans_x_var <- anscombe %>% 
  select(x1:x4) %>% summarise_each(list(var),x1:x4) 

ans_y_var <- anscombe %>% 
  select(y1:y4) %>% summarise_each(list(var),y1:y4) 

ans_x_cor <- anscombe %>% 
  select(x1:y4) %>% summarise_each(list(cor),x1:y4) 

p1 <- ggplot(anscombe) +
  geom_point(aes(x1,y1),color="darkorange",size=3)+
  theme_bw()+
  scale_x_continuous(breaks=seq(0,20,2))+
  scale_y_continuous(breaks=seq(0,12,2))+
  geom_abline(intercept=3,slope=0.5,
              color="cornflowerblue")+
  expand_limits(x=0,y=0)+
  labs(title="dataset 1")

p2 <- ggplot(anscombe) +
  geom_point(aes(x2,y2),color="darkorange",size=3)+
  theme_bw()+
  scale_x_continuous(breaks=seq(0,20,2))+
  scale_y_continuous(breaks=seq(0,12,2))+
  geom_abline(intercept=3,slope=0.5,
              color="cornflowerblue")+
  expand_limits(x=0,y=0)+
  labs(title="dataset 2")

p3 <- ggplot(anscombe) +
  geom_point(aes(x3,y3),color="darkorange",size=3)+
  theme_bw()+
  scale_x_continuous(breaks=seq(0,20,2))+
  scale_y_continuous(breaks=seq(0,12,2))+
  geom_abline(intercept=3,slope=0.5,
              color="cornflowerblue")+
  expand_limits(x=0,y=0)+
  labs(title="dataset 3")

p4 <- ggplot(anscombe) +
  geom_point(aes(x4,y4),color="darkorange",size=3)+
  theme_bw()+
  scale_x_continuous(breaks=seq(0,20,2))+
  scale_y_continuous(breaks=seq(0,12,2))+
  geom_abline(intercept=3,slope=0.5,
              color="cornflowerblue")+
  expand_limits(x=0,y=0)+
  labs(title="dataset 4")

grid.arrange(p1,p2,p3,p4,ncol=2, top="Anscombe's Quarter")
# 스케일 같게 하는것을 해봐라.



       
       
