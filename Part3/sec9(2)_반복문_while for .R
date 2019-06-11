###==========================================
### 반복문 while  for  ===========
###==========================================

# 조건식이 참일 동안 반복
no <- 1
while (no<10){
  print(no)
  no<-no+1;
}

#break : 루프를 빠져나가라
no <- 0
while (no<10){
  print(no)
  if (no == 4){
    break
  }
  no<-no+1;
}

#짝수나 홀수만 찍어라.
no <- 0
while (no<=10){
  no<-no+1
  if (no %% 2 == 1)
    next
  print(no)
}


###==========================================
### for 반복문  ===========
###==========================================


for (i in 1:10) {
  print(i)
}

#1에서 100까지 더한 수
sum <- 0
for (i in 1:100){
  sum <- sum + i
}
print(sum)

#1에 100까지 3의 배수만 더하기
sum <- 0
for (i in 1:100){
  if(i%%3==0)
  sum <- sum + i
}
print(sum)

#number의 배수들의 합.
multiple <- function(limit, number){
  sum<-0
  for (i in 1:limit){
    if (i %% number == 0)
      sum <- sum +i
  }
  return(sum)
}
multiple(1000,4)

#
colors <- c()

### 연습문제 
채소 <- read.table('채소.txt')


# line을 비워준다.
library(stringr)

for (i in 5:1){
  line <- ''
  for(k in i:5){
    line <- str_c(line, ' ')
  }
  for(k in i:1){
    line <- str_c(line, '#')
  }
  print(line)
}

#
for (i in 1:5){
  line <- ''
  if (i != 1){
  for(k in 1:(i-1))
    line <- str_c(line, ' ')
  }
  for(k in i:5){
    line <- str_c(line, '#')
  }
  print(line)
}

### for 연습문제.===============================================

for3<- function(a){
  for(i in 1:3){
    if(i == i)
  a <- ''
  a <- str_c(a, '번 학생 손드세요.')
  }
}

for3(3)


for (i in seq(10,30,10)) {
  print(paste0(i,'번 학생 손드세요'))
} 

text <- NULL
for (i in 1:10) {
  text[i] <- paste0(i*10,'번 학생 손드세요')
  print(text[i])
} 

text

### 구구단 ====================================================
for (i in 2:9){
  line <- str_c(i, '단')
  print(line)
  for (k in 1:9) {
    line <- str_c(i, ' * ', k, ' = ', i*k)
    print(line)
  }
}

###다이아몬드 그리기
while (T) { # 마름모 모양 
  for (i in 1:4) {
    line <- ''
    if( i != 4) {
      for (k in 1:(4-i)) { 
        line <- paste0(line, " ")
      }
    }
    for (l in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 3:1) {
    line <- ''
    for (k in 1:(4-i)) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}

### 약수 구하는함수
getDenominator <- function(x){
  den <- c(1)
  if (x >= 2){
    for (i in 2:x){
      if (x %% i == 0)
        den <- c(den,i)
    }
  }
  return(den)
}
getDenominator(60)

########################
#  fo loop 추가
########################

#3의 배수 더하기
sum<-0
for(i in seq(3,10,3)){
  sum <- sum +i
}
print(sum)

#3의 배수
for(i in seq(3,100,3)){
  print(i)
}

for(i in seq(1,0,1)){
  print(i)
}
  

  
  
  