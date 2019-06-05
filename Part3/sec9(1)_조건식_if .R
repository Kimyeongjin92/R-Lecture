###==========================================
### 조건문 if else ifelse else if ===========
###==========================================

### 1. 비교 조건에 사용되는 연산자.
### == \ != \ >= \ <= \ > \ <

### 2. if else else if
###  myabs <- function(x) {
###    if   (조건식) { 조건에 맞을 때TRUE  }
###    else          { 조건이 아닐 때FALSE }}
  

myabs <- function(x) {
  if(x>=0) {
    return(x) 
  } else {
    return(-x)
  }
}

myabs(-3.2)
myabs(4.5)

# else가 없어도 실행됨.
myabs2 <- function(x) {
  if(x>=0) {
    return(x)
  }
  return(-x)
}

myabs2(-3.2)
myabs2(4.5)

# 연습 1
myF1 <- function(x) {
  if (x>0){
    return(x*x)
  } else {
    return(0)
  }
}
myF1(4.6)
myF1(-2.4)

# 연습 2
myF2 <- function(x) {
  if (x>0){
    return(2 * x)
  } else if (x == 0 ) {
    return(0)
  } else {
    return(-2 * x)
  }
}
myF2(4.6)
myF2(0)
myF2(-2.4)

### 3. ifelse 문
no     <- scan()
result <- ifelse(no%%2==0,'짝수','홀수') ;result

### 연습문제 =========================================

#1. 
myf1 <- function(x) {
  if (x>5){
    return(1)
  } else {
    return(0)
  }
}


#2.
myf2 <- function(x){
  if (x>0){
    return(1)
  } else {
    return(0)
  }
}
myf2(1)
myf2(-1)

#3. 
myf3 <- function(x,y){
  if (x>y){
    return(x - y)
  } else{
    return(y - x)
  }
}
myf3(1,3)
myf3(3,1)

#4.
myf4 <- function(x){
  if (x<0){
    return(1)
  } else if(x>=1&&x<=5){
    return(0)
  } else{
    return(10)
  }
}
myf4(6)

xx<-c(T,T,F)
yy<-c(F,T,F)
xx & yy
xx && yy #대표값 한개만 나온다.

#5.
myf5 <- function(x){
  if (x=='Y' || x=='y'){
    return('Yes')
  } else{
    return('Not Yes')
  }
}
myf5('A')
; 

#6
myIntD <- function(a,b,c){
  D=b*b - 4*a*c
  if(D>0){
    return(2)
  } else if (D == 0) {
    return(1)
  } else {
    return(0)
  }
}
myRealID <- function(a,b,c){
  D=b*b - 4*a*c
  print(D)
  if(abs(D) < 1e-5){
    return(1)
  } else if (D>0) {
    return(2)
  } else {
    return(0)
  }
}

a<- 1.0000000001
b<- -2.00000000001
c<- 1.0000000002
myRealID(a,b,c)

#실수값 A 와 실수값 B를 비교하려면
# if(x==y) 이렇게 하지말고
# if(abs(A-B)< 0.00000000000 ) 이런식으로 비교해야한다.
