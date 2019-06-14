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

### 다이아몬드 그리기 ===========================================
uioj# R에서 별찍기 !!
# Nested for - loop 해보기


#
##
###
####
#####

for (i in 1:5) {
  line <- ''
  for (k in 1:i) {
    line <- paste0(line, '#')
  }
  print(line)
}

### =============================================================


#####
####
###
##
#

for (i in 5:1) {
  line <- ''
  for (k in i:1) {
    line <- paste0(line, "#")
  }
  print(line)
}


### =============================================================


#####
 ####
  ###
   ##
    #

for (i in 0:4) {
  line <- ''
  if (i != 0 ){ # 첫번쨰 라인 삭제 R에선 0:0까지도 1로 인식 
    for (k in i:1) {
      line <- paste0(line, " ")
    }
  }
  for (k in i:4) {
    line <- paste0(line, "#")
  }
  print(line)
}

### =============================================================


#      i   b      #
    #   4  4 4:1  1 4:4
   ##   3  3 3:1  2 3:4
  ###   2  2 2:1  3 2:4
 ####   1  1 1:1  4 1:4
#####   0  0  -   5 0:4
 ####   1  1 1:1  4 1:4
  ###   2  2 2:1  3 2:4
   ##   3  3 3:1  2 3:4
    #   4  4 4:1  1 4:4

while (T) {
  for (i in 4:0) {
    line <- ''
    if ( i != 0 ){
      for (k in i:1) {
        line <- paste0(line, " ")
      }
    }
    for (k in i:4) {
      line <- paste0(line, "#")
    }
    print(line) 
  }
  for (i in 1:4) {
    line <- ''
    for (k in i:1) {
      line <- paste0(line, " ")
    }
    for (k in i:4) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}
i <- 3:0
for (k in c(i,3:6)) {
  print(k)
}

### =============================================================



#          i    b수 (i:3)  #수 1:(i*2-1)
   #       1    3개 (1:3)  1개 1:(i*2-1) 1  
  ###      2    2개 (2:3)  3개 1:(i*2-1) 3
 #####     3    1개 (3:3)  5개 1:(i*2-1) 5
#######    4    0개 (i!=4) 7개 1:(i*2-1) 7
 #####     3    1개 (3:3)  5개 1:(i*2-1) 5
  ###      2    2개 (3:2)  3개 1:(i*2-1) 3
   #       1    3개 (3:1)  1개 1:(i*2-1) 1

while(T){
  for (i in 1:4) {
    line <- ''
    if(i != 4) {
      for (k in i:3) {
        line <- paste0(line, " ")
      }
    } 
    for (k in 1:(i*2-1)) {
      line <- paste0(line , "#")
    }
    print(line)
  }
  for (i in 3:1) {
    line <- ''
    for (k in 3:i) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}


### =============================================================


                             # i  b수(i:9)  #수 1:(i*2+1)  
length(1:21)                     
#####################         10  0 (i!=10) 21개          
 ###################           9  1 9:9     19개
  #################            8  2 8:9     17개
   ###############
    #############
     ###########
      #########
       #######
        #####
         ###                   1  9 i:9      3개         
          #                    0             1개   
         ###                   1  9 i:9      3개
        #####                  2  8          5개 1:(i*2+1)
       #######
      #########
     ###########
    #############
   ###############
  #################
 ###################
#####################         10  0 (i!=10)  21개

while (T) {
  for (i in 10:0) {
    line <- ''
    if (i != 10){
      for (k in i:9) {
        line <- paste0(line, ' ')
      }  
    } 
    for (k in 1:(i*2+1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 1:10) {
    line <- ''
    if (i != 10) {
      for (k in i:9) {
        line <- paste0(line, ' ')
      }
    }
    for (k in 1:(i*2+1)) {
      line <- paste0(line, '#')
    }
    print(line)
  }
  break
}


### =============================================================


#         #
###       ###
#####     ##### 
#######   #######
######### #########
#####################              
###################         
#################           
###############
#############
###########
#########
#######
#####
###                      
# 


#  i    b      #           b            #
#  1    5(i:5) 1 1:(i*2-1) 9(i*2-1):9   1 1:(i*2-1)
#  2    4      3           7            3
#  3    3      5           5            5
#  4    2      7           3            7 
#  5    1      9           1            9

while (T) {
  for (i in 1:5) {
    line <- ''
    for (k in i:5) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    for (k in (i*2-1):9) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 10:0) {
    line <- ''
    if (i != 10){
      for (k in i:9) {
        line <- paste0(line, ' ')
      }  
    } 
    for (k in 1:(i*2+1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}


### =============================================================


#         #
###       ###
#####     #####
#######   #######
######### #########
#
###
#####
#######
#########
###########
#############
###############
#################
###################
#####################

while (T) {
  for (i in 1:5) {
    line <- ''
    for (k in i:5) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    for (k in (i*2-1):9) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 0:10) {
    line <- ''
    if (i != 10) {
      for (k in i:9) {
        line <- paste0(line, ' ')
      }
    }
    for (k in 1:(i*2+1)) {
      line <- paste0(line, '#')
    }
    print(line)
  }
  break
}


### =============================================================


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
  

  
  
  