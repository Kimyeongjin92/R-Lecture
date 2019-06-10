iris
View(iris)
library(plotly)
# 시험문제에서 이상치를 뺀 평균값으로 다시 그래프를 그릴 줄 알아야한다.

# 1. 
a<-iris[,5]=='setosa'
b<-iris[,5]=='versicolor'
c<-iris[,5]=='virginica'
setosa<-iris[a,]
versicolor<-iris[b,]
virginica<-iris[c,]

par(mfrow=c(2,3))
plot(setosa$Sepal.Length,setosa$Sepal.Width,main="(sepal)setosa 산점도",
     pch=10, cex=1.5, col="red", xlab='Length', ylab= 'Width',xlim=c(4,9),ylim=c(2,4.5))
plot(versicolor$Sepal.Length,versicolor$Sepal.Width,main="(sepal)versicolor 산점도",
     pch=10, cex=1.5, col="red", xlab='Length', ylab= 'Width',xlim=c(4,9),ylim=c(2,4.5))
plot(virginica$Sepal.Length,virginica$Sepal.Width,main="(sepal)virginica 산점도",
     pch=10, cex=1.5, col="red", xlab='Length', ylab= 'Width',xlim=c(4,9),ylim=c(2,4.5))

plot(setosa$Petal.Length,setosa$Petal.Width,main="(petal)setosa 산점도",
     pch=10, cex=1.5, col="blue", xlab='Length', ylab= 'Width',xlim=c(1,6.5),ylim=c(0.1,2.5))
plot(versicolor$Petal.Length,versicolor$Petal.Width,main="(petal)versicolor 산점도",
     pch=10, cex=1.5, col="blue", xlab='Length', ylab= 'Width',xlim=c(1,6.5),ylim=c(0.1,2.5))
plot(virginica$Petal.Length,virginica$Petal.Width,main="(petal)virginica 산점도",
     pch=10, cex=1.5, col="blue", xlab='Length', ylab= 'Width',xlim=c(1,6.5),ylim=c(0.1,2.5))

# 2. 품종별 평균치
a<-aggregate(iris$Sepal.Length~Species,iris,mean)
b<-aggregate(iris$Sepal.Width~Species,iris,mean)
c<-aggregate(iris$Petal.Length~Species,iris,mean)
d<-aggregate(iris$Petal.Width~Species,iris,mean)
e<-cbind(a,b,c,d)
e2<-e[,c(-1,-3,-5,-7)]
e2<-t(e2)
colnames(e2) <- c('setosa','versicolor','virginica') ; e2

par(mfrow=c(1,2))
barplot(as.matrix(e2),main="IRIS 품종별 평균차트(1)",
        beside=T,col=rainbow(nrow(e2)),ylim=c(0,10))
legend('topleft',c('S.Lenth','S.Width','P.Length','P.Width'),cex=0.6,fill=rainbow(nrow(e2)))

barplot(as.matrix(e2),main="IRIS 품종별 평균차트(2)",
        beside=F,col=rainbow(nrow(e2)),ylim=c(0,20))
legend('topleft',c('S.Lenth','S.Width','P.Length','P.Width'),cex=0.6,fill=rainbow(nrow(e2)))

# 3. boxplot 12개 그리기
a<-iris[,5]=='setosa'
b<-iris[,5]=='versicolor'
c<-iris[,5]=='virginica'
setosa<-iris[a,]
versicolor<-iris[b,]
virginica<-iris[c,]

par(mfrow=c(1,3))
boxplot(setosa[,1:4],col=rainbow(5),main='setosa',ylim=c(0,8))
boxplot(versicolor[,1:4],col=rainbow(5),main='versicolor',ylim=c(0,8))
boxplot(virginica[,1:4],col=rainbow(5),main='virginica',ylim=c(0,8))










