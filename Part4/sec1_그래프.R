# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-07-(금) / 448page

###============================================================
### plot, barplot, pie ==============================
###============================================================

# 그래픽 기초
setwd("d:/dudwlsrla92/R_Data_Analysis/Part4")

#데이터가 하나만 있으면 y축 데이터이다.
var1 <- c(1,2,3,4,5)
plot(var1)

var2 <- c(2,2,2)
plot(var2)

x <- 1:3
y <- 3:1
plot(x,y)
plot(x,y,xlim=c(1,10),ylim=c(1,5))
plot(x,y,xlim=c(1,10),ylim=c(1,5),
     xlab="x축 값",ylab="y축 값",
     main="Plot Test")

v1 <- c(100,130,120,160,150)
plot(v1,type='o',col='red',ylim=c(0,200),axes=FALSE,ann=FALSE)

axis(1,at=1:5,lab=c("MON","TUE","WED","THU","FRI"))
axis(2,ylim=c(0,200))

title(main="FRUIT",col.main="red",font.main=4)
title(xlab="DAY",col.lab="black")
title(ylab="PRICE",col.lab="blue")

v1
par(mfrow=c(1,3),bg='yellow')
plot(v1,type='o')
plot(v1,type='s')
plot(v1,type='l')

par(mfrow=c(1,3))
pie(v1)
plot(v1,type='o')
barplot(v1)

a<- c(1,2,3)
plot(a,xlab='aaa')

# mgp=c(제목위치,지표값위치,지표선위치)
par(mgp=c(0,0,0))
plot(a,xlab='aaa')

par(mgp=c(2,0,0))
plot(a,xlab='aaa')

par(mgp=c(0,2,0))
plot(a,xlab='aaa')

par(mgp=c(0,0,2))
plot(a,xlab='aaa')

par(mgp=c(3,2,1))
plot(a,xlab='aaa')

# oma=c() : 그래프 전체의 여백 조정하기
# 숫자가 커질수록 여백이 늘어난다.
par(oma=c(2,0,0,0))
plot(a,xlab="aaa")

par(oma=c(0,2,0,0))
plot(a,xlab="aaa")

par(oma=c(0,0,2,0))
plot(a,xlab="aaa")

par(oma=c(0,0,0,2))
plot(a,xlab="aaa")

par(oma=c(0,0,0,0))
plot(a,xlab="aaa")


### 그래프 여러개 그리기
v1 <- c(1:5)
v2 <- c(5:1)
v3 <- c(3:7)

#1. 
par(mfrow=c(1,1))
plot(v1,type='s',col='red',ylim=c(1,5))
par(new=T)   # 중복을 허용하는 역할
plot(v2,type='o',col='blue',ylim=c(1,5))
par(new=T) 
plot(v3,type='l',col='green')

#2.
plot(v1,type='s',col='red',ylim=c(1,10))
lines(v2,type='o',col='blue',ylim=c(1,5))
lines(v3,type='l',col='green',ylim=c(1,15))


### 그래프에 범례 추가하기.
### legend(x축 위치, y축 위치, 내용, cex=글자크기, col, pch=크기, lty=선모양)
plot(v1,type='s',col='red',ylim=c(1,10))
lines(v2,type='o',col='blue',ylim=c(1,5))
lines(v3,type='l',col='green',ylim=c(1,15))

legend(4,10,c('v1','v2','v3'),cex=0.8,col=c('red','blue','green'),lty=1)

### barplot() : 막대 그래프 그리기
x <- c(1,2,3,4,5)
barplot(x)
barplot(x,horiz=T)

# 1. 그룹으로 묶어서 출력시키기
# *** : matrix(x,행의개수,열의개수)
x <- matrix(c(5:2),2,2) ; x
par(mfrow=c(1,4))
barplot(x,beside=T,names=c(5,3),col=c("green","yellow"))
barplot(x,beside=F,names=c(5,3),col=c("green","yellow"))
barplot(x,beside=T,names=c(5,3),col=c("green","yellow"),horiz=T)
barplot(x,beside=F,names=c(5,3),col=c("green","yellow"),horiz=T)

# 2. 여러막대 그래프를 묶어서 한꺼번에 출력하기.
v1 <- seq(100,180,20)
v2 <- seq(120,160,10)
v3 <- floor(runif(5,140,160)) #숫자 랜덤생성 5개, 140에서, 160까지
v4 <- sample(seq(from = 140, to = 160, by = 10), size = 5, replace = T)

qty <- data.frame(APPLE=v1, BANANA=v2, ORANGE=v3, CHERRY=v4)
class(qty) # : data.frame

# *** : 데이터가 벡터 또는 행렬이어야 한다. 
# *** : rainbow() 의 숫자가 커질수록 색이 세밀하게 나뉜다.
barplot(as.matrix(qty),main="Fruit's Sales QTY",
        beside=T,col=rainbow(nrow(qty)),ylim=c(0,400))
barplot(as.matrix(qty),main="Fruit's Sales QTY",
        beside=T,col=rainbow(80),ylim=c(0,400))

legend(14,400,c('MON','TUE','WED','THU','FRI'),cex=0.8,fill=rainbow(nrow(qty)))
# *** : but!!! 범례의 색과 막대그래프의 색을 일치시키려면 col과 fill을 같게 해야한다.

# *** : 행과 열을 바꿔주는 기능 t() :transpose
class(t(qty)) 
barplot(t(qty),main="Fruit's Sales QTY",ylim=c(0,900),
        col=rainbow(length(qty)),space=0.1,cex.axis=0.8,las=1,
        names.arg = c("MON","TUE","WED","THU","FRI"),cex=0.8)
legend(0.2,800,names(qty),cex=0.7,fill=rainbow(length(qty)))

colors <- c()
for (i in 1:length(v4)){
  if (v4[i] >= 200){
    colors <- c(colors,"red") }
  else if (v4[i] >= 180){
     colors <- c(colors, "yellow") }
  else {
    colors <- c(colors, "green") }
  }
barplot(v4,main="Peach Sales QTY",
        names.arg = c("MON","TUE","WED","THU","FRI"),col=colors)

height<- floor(runif(10,150,180))
par(mfrow=c(1,2),oma=c(2,2,0.1,0.1))
barplot(height)
hist(height,main="Plot")

### 파이모양의 차트 그리기
par(mfrow=c(1,1),oma=c(0.5,0.5,0.1,0.1))
p1 <- c(10,20,30,40)
pie(p1,radius=1)                  # radius : 원형의 크기
pie(p1,radius=1,init.angle = 90)  # init.angle 시작각도 90도

# 1. 
pie(p1,radius=1,init.angle = 90,
    col=rainbow(length(p1)),
    label=c("Week 1","Week 2","Week 3","Week"))

# 2. 
pct  <- round(p1/sum(p1)*100,1)
lab1 <- paste(pct," %")
pie(p1,radius=1,init.angle=90,col=rainbow(length(p1)),
    label=lab1)
legend(1,1.1,c("Week 1","Week 2","Week 3","Week 4"),
       cex=0.5,fill=rainbow(length(p1)))

# 3. 
pct  <- round(p1/sum(p1)*100,1)
lab1 <- c("Week 1","Week 2","Week 3","Week 4")
lab2 <- paste(lab1," \n",pct," %")
pie(p1,radius=1,init.angle=90,col=rainbow(length(p1)),label=lab2)


### 3D 파이모양의 차트 그리기
install.packages('plotrix')
library(plotrix)

p1 <- c(10,20,30,40,50)
f_day   <- round(p1/sum(p1)*100,1)
f_label <- paste(f_day, " %")
pie3D(p1, main="3D Pie Chart", col=rainbow(length(p1)),
      cex=0.5,labels=f_label,explode=0.05) # explode 간격조정
legend(0.5,1,c("MON","TUE","WED","THU","FRI"),cex=0.6,
       fill=rainbow(length(p1)))

### ==============================================================
### 상자차트 : boxplot()
# 박스 끝에서 수염까지의 길이는 기본 1.5배 위 아래 
# 시험문제 : iris라는 데이터에서 boxplot을 그려라. 
# 이상치(1.5배 밖) 제거 후 평균 표준편차도.

v1 <- c(10,12,15,11,20)
v2 <- c(5,7,15,8,9)
v3 <- c(11,20,15,18,13)
boxplot(v1,v2,v3,col=c("blue","yellow","pink"),
        names =c("blue","yellow","pink"),
        horizontal=T)


### =================================================================================
### 관계도 그리기 : igraph() 함수 
### 데이터가 주어지면 structure describe, head, tail, View, 산점도를 보고 시작해야한다
### ==================================================================================

install.packages("igraph")
library(igraph) 

g1 <- graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6))
plot(g1)
str(g1)  


name <- c('서진수 대표이사','일지매 부장','김유신 과장','손흥민 대리','노정호 대리',
          '이순신 부장','유관순 과장','신사임당 대리','강감찬 부장','광개토 과장','정몽주 대리')
pemp <- c('서진수 대표이사','서진수 대표이사','일지매 부장','김유신 과장','김유신 과장',
          '서진수 대표이사','이순신 부장','유관순 과장','서진수 대표이사','강감찬 부장','광개토 과장')
emp  <- data.frame(이름=name,상사이름=pemp) ;emp


# *** : 그림 그리기 전에 실행 후 dev.off()를 run해준다.
png("graph/network_1.png",width=600,height=600)

g    <- graph.data.frame(emp,directed = T)
plot(g,layout=layout.fruchterman.reingold,
     vertex.size=8,edge.arrow.size=0.5)
str(g)

dev.off()


# 화살표(directed=F)와 이름 제거(vertex.label=NA)
png("graph/network_2.png",width=600,height=600)

g3   <- graph.data.frame(emp,directed=F)
plot(g3,layout=layout.fruchterman.reingold,
     vertex.size=8,edge.arrow.size=0.5,vertex.label=NA)

dev.off()

# layout.random, layout.cicle, layout.fruchterman.reingold, layout.kamada.kawai,
# layout.sprint, layout.lgl, layout.mds, layout.svd


### =================================================================================
###  함수 
### ==================================================================================

install.packages('devtools') # d3Network 포함되어 있지만 따로 깔 수 있다. 
library(devtools)
install.packages("d3Network") # 2~3년 전의 책이기 때문에 이렇게 실행 가능함.
library(d3Network)
install.packages("RCurl")
library(RCurl)

name <- c('')
pemp <- c('')

emp  <- data.frame(이름=name,상사이름=pemp)
d3SimpleNetwork(emp,width=600,height=600,file="d:/dudwlsrla92/R_Data_Analysis/Part4/이름.html")

install_github("christophergandrud/d3Network")

### =================================================================================
###  군집분석
### ==================================================================================

setwd('d:/dudwlsrla92/R_Data_Analysis/Part4/data')
getwd()

# 1.
g <- read.csv('군집분석.csv',head=T)
graph <- data.frame(학생=g$학생,교수=g$교수)

g <- graph.data.frame(graph,directed=T)
plot(g,layout=layout.fruchterman.reingold,
     vertex.size=2,edge.arrow.size=0.05,
     vertex.color="green",vertex.label=NA)

plot(g,layout=layout.kamada.kawai,
     vertex.size=2,edge.arrow.size=0.05,
     vertex.label=NA)

# 2. 학생 S / 교수 T 구분하기
V(g)$name
gubun1 <- V(g)$name ;gubun1
gubun2 <- str_sub(gubun1,start=1,end=1)

# 3. 학생일 경우 red / 교수일 경우 green
colors <- c()
for (i in 1:length(gubun2)){
  if(gubun2[i]=='S'){
    colors <- c(colors,"red")}
  else {
    colors <- c(colors,"green")}
}

# 4. 학생 점크기 2 / 교수 점크기 6
sizes <- c()
for (i in 1:length(gubun2)){
  if(gubun2[i]=='S'){
    sizes <- c(sizes,2)}
  else {
    sizes <- c(sizes,6)}
}

# 5. 학생 circle / 교수 square
shapes <- c()
for (i in 1:length(gubun2)){
  if(gubun2[i]=='S'){
    shapes <- c(shapes,"circle")}
  else {
    shapes <- c(shapes,"square")}
}

# 6. 실행 ayout.fruchterman.reingold
plot(g,layout=layout.fruchterman.reingold,
     vertex.size=sizes,edge.arrow.size=0.05,
     vertex.color=colors,vertex.label=NA,
     vertex.shape=shapes)

# 6. 실행 layout.kamada.kawai
plot(g,layout=layout.kamada.kawai,
     vertex.size=sizes,edge.arrow.size=0.05,
     vertex.color=colors,vertex.label=NA,
     vertex.shape=shapes)


### ===============================================================
###  군집분석2
### ===============================================================
setwd("d:/dudwlsrla92/R_Data_Analysis/Part4/data")
getwd()
#1.
virus1 <- read.csv('메르스전염현황.csv',header=T)
d3SimpleNetwork(virus1,width=1000,height=1000,file="D:/dudwlsrla92/R_Data_Analysis/Part4/mers.html")

install.packages('d3Network')
library(d3Network)


### ===============================================================
###  treemap
### ===============================================================

install.packages('treemap')
library(treemap)

total <- read.csv('학생시험결과_전체점수.csv',sep=",")
treemap(total,vSize='점수',index=c('점수','이름'))
treemap(total,vSize='점수',index=c('조','이름'))
treemap(total,vSize='점수',index=c('점수','조','이름'))


### ===============================================================
###  stars()
### ===============================================================

total <- read.table('학생별전체성적_new.txt',header=T,sep=',') ;total
row.names(total)<-total$이름 ; total # 행 번호로 되어 잇는 것을 이름으로 변경
tatal <- total[,2:7]


# 1. star chart 기본형
stars(total,flip.labels=F,draw.segment=F,frame.plot=T,full=T,
      main='학생별 과목별 성적분석-STAR Chart')

lab   <- names(total) ; lab 
value <- table(lab)   ; value
pie(value,labels=lab,radius=0.1,cex=0.6,col=NA)


# 2. draw.segment = t 나이팅게일 그래프
stars(total,flip.labels=F,draw.segment=T,frame.plot=T,full=T,
      main='학생별 과목별 성적분석-나이팅게일 차트')

lab   <- names(total) ; lab 
value <- table(lab)   ; value
color <- c('black','red','green','blue','cyan','violet')
pie(value,labels=lab,radius=1,cex=1,col=color)

# 3. full = F  반원
stars(total,flip.labels=F,draw.segment=T,frame.plot=T,full=F,
      main='학생별 과목별 성적분석-나이팅게일 차트')


### ===============================================================
###  radarchart()
### ===============================================================

install.packages('fmsb')
library(fmsb)

layout <- data.frame(
  분석력=c(5,1),
  창의력=c(15,3),
  판단력=c(3,0),
  리더쉽=c(5,1),
  사교성=c(5,1))

set.seed(123) #seed라고해서 이것을 기준으로해서 임의의 데이터를 생성하는 것.

#runif 알 유니프(3개 1에서 5까지)
#rnorm 정규분포(3개, 평균이 10, 표준편차가 2)
#rnorm(10) 표준정규분포(평균이0 표준편차가 1인 10개)

data1 <- data.frame(
  분석력=runif(3,1,5),
  창의력=rnorm(3,10,2),
  판단력=c(0.5,NA,3),
  리더쉽=runif(3,1,5),
  사교성=c(5,2.5,4))

data2 <- rbind(layout,data1)

op <- par(mar=c(1,0.5,3,1),mfrow=c(2,2)) #여백과 배치를 조정.
radarchart(data2,axistype=1,seg=5,plty=1,title="첫번째 타입")
radarchart(data2,axistype=2,pcol=topo.colors(3),plty=1,title="두번째 타입")
radarchart(data2,axistype=3,pty=32,plty=1,axislabcol="grey",na.itp=F,title="첫번째 타입")
radarchart(data2,axistype=0,plwd=1:5,pcol=1,title="네번째 타입")


### ===============================================================
###  저 수준 작도 함수 사용하기
### ===============================================================

var1 <- 1:5
plot(var1)
segments(2,2,3,3)       # 선분 그리기
arrows(5,5,4,4)         # 화살표
text(2,4,"TEXT")        # 글자 쓰기
text(4,4,"TEXT",srt=45) # 45도 기울여서.
rect(2,2,3,3)           # 사각형
title("TEST","SUB")     # 제목, 밑 



