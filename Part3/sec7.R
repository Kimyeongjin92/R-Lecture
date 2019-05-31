# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-05-29(수) / 345page

# Tools - Global Options - Default working directory설정하기 (Data폴더에)

###===============================================================================
### 파일 이름 확인하기 [list.files()] ============================================
###===============================================================================

list.files()            # 현재 활용가능한 데이터 목록
list.files(recursive=T) # 현재디렉토리말고 하위디렉토리까지 전부 보여줘라
list.files(all.files=T) # 숨김파일까지 전부 보여줌 ex) .prorile


###===============================================================================
### 텍스트 파일 읽기 [ scan() 함수, input() ] ====================================
###===============================================================================

scan1 <- scan('scan_1.txt')         ; scan1 #
scan2 <- scan('scan_2.txt')         ; scan2 # 1.00과 같은 소수점을 지워버림
scan2 <- scan('scan_2.txt',what='') ; scan2 # what='' 소수점까지 읽어줌.
scan3 <- scan('scan_3.txt',what='') ; scan3 
scan4 <- scan('scan_4.txt',what='') ; scan4 # 문자, 숫자가 섞여있을 경우 문자로 출력.

input  <- scan()                            # Console 창에 직접입력해서 데이터를 만듦.
input
input2 <- scan(what="")                     # 
input2

input3 <- readline()                        #consol창에 입력 : a quick brown fox
input3

input4 <- readline("a quick brown fox")

input5 <- readLines('scan_4.txt')
input5


###===============================================================================
### 텍스트 파일 읽기 [read.table( , Skip / nrows )] ==============================
###===============================================================================

fruits  <- read.table('fruits.txt')            ; fruits
fruits  <- read.table('fruits.txt',header=T)   ; fruits  # header=T: 열 이름으로 설정
fruits2 <- read.table('fruits_2.txt')          ; fruits2 # #과 같은 주석은 빼고 읽는다.
fruits3 <- read.table('fruits_2.txt',skip=2)   ; fruits3 # SKIP은 #과 같은 주석이 포함되어 제거된다.
fruits4 <- read.table('fruits_2.txt',nrows=2)  ; fruits4

f2top   <- read.table('fruits_2.txt',nrows=2)  ; f2top    
f2bottom<- read.table('fruits_2.txt',skip=3)   ; f2bottom #이런 방식으로 
# 큰 데이터를 1~100(nrows=100), 101~200(skip=100, nrows=100), 201~300(skip=200)로 나눌 수 있다.


###===============================================================================
### csv 파일 읽기 read.csv(파일명.csv) ===========================================
###===============================================================================

fruits5 <- read.csv('fruits_3.csv') ; fruits5 #데이터사이에 쉼표(,)가 있으면 편하다.
fruits6 <- read.csv('fruits_4.csv') ; fruits6 #txt와 다르게 csv는 header=T가 default 되어있음.
fruits6 <- read.csv('fruits_4.csv',header=F) ; fruits6



