# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-05-29(수) / 345page

# Tools - Global Options - Default working directory설정하기 (Data폴더에)
###===============================================================================
### read.csv(), readLines(), read.table()의 차이점 381Page =======================
###===============================================================================

# 1. read.csv()  메모장에서 csv로 불러들일 경우 각 컬럼의 구분이 ,(콤마)로 되어 있어야 한다.
# 2. readLines() 파일의 여러줄을 한줄로 쭉 불러온다.
# 3. read.table() 컬럼 구분을 하지 못하고 v1이라고 한다. 이럴떄는 
#    read.table("데이터.txt,sep=",",header=T")
#    sep로 구분 하고 header=T로 컬럼 이름을 자동으로 붙인다.

###===============================================================================
### 파일 이름 확인하기 list.files() ============================================
###===============================================================================

list.files()            # 현재 활용가능한 데이터 목록
list.files(recursive=T) # 현재디렉토리말고 하위디렉토리까지 전부 보여줘라
list.files(all.files=T) # 숨김파일까지 전부 보여줌 ex) .prorile


###===============================================================================
### 텍스트 파일 읽기 scan() 함수, input()  =======================================
###===============================================================================

scan1 <- scan('scan_1.txt')         ; scan1 #
scan2 <- scan('scan_2.txt')         ; scan2 # 1.00과 같은 소수점을 지워버림
scan2 <- scan('scan_2.txt',what='') ; scan2 # what='' 소수점까지 읽어줌.
scan3 <- scan('scan_3.txt',what='') ; scan3 # 문자는 what을 해주지 않으면 읽지 못한다.
scan4 <- scan('scan_4.txt',what='') ; scan4 # 문자, 숫자가 섞여있을 경우 문자로 출력.

input  <- scan()                            # Console 창에 직접입력해서 데이터를 만듦.
input                                       # 숫자
input2 <- scan(what="")                     # 문자는 what='' 띄어쓰기 = items를 따로따로 분류
input2

input3 <- readline()                        # 한줄 길게 입력시 consol창에 입력 : a quick brown fox 
input3

input4 <- readline("a quick brown fox")     # 이렇게도 입력 가능

input5 <- readLines('scan_4.txt')           
input5


###===============================================================================
### 텍스트 파일 읽기  read.table( , Skip / nrows )  ==============================
###===============================================================================

fruits  <- read.table('fruits.txt')            ; fruits
fruits  <- read.table('fruits.txt',header=T)   ; fruits  # header=T: 열 이름으로 설정
fruits2 <- read.table('fruits_2.txt')          ; fruits2 # 내용의 #과 같은 주석은 빼고 읽는다.
fruits3 <- read.table('fruits_2.txt',skip=2)   ; fruits3 # SKIP은 #과 같은 주석이 포함되어 제거된다.
fruits4 <- read.table('fruits_2.txt',nrows=2)  ; fruits4 # 원하는 행만 가져온다 주석은 생략.

f2top   <- read.table('fruits_2.txt',nrows=2)  ; f2top    
f2bottom<- read.table('fruits_2.txt',skip=3)   ; f2bottom #이런 방식으로 
# 큰 데이터를 1~100(nrows=100), 101~200(skip=100, nrows=200), 201~300(skip=200)로 나눌 수 있다.


###===============================================================================
### csv 파일 읽기  read.csv(파일명.csv)  =========================================
###===============================================================================

fruits5 <- read.csv('fruits_3.csv') ; fruits5 #csv를 txt로 보면 사이사이에 쉼표(,)로 구분됨.
fruits6 <- read.csv('fruits_4.csv') ; fruits6 #txt와 다르게 csv는 header=T가 default 되어있음.
fruits6 <- read.csv('fruits_4.csv',header=F) ; fruits6
label  <- c('NO','NAME','PRICE','QTY')
fruit7 <- read.csv('fruits_4.csv',header=F,col.names=label)


###===============================================================================
### 원하는 데이터를 SQL쿼리로 불러오기  read.csv.sql() ===========================
###===============================================================================

install.packages('googleVis')
install.packages("sqldf")
library(googleVis)
library(sqldf)

Fruits
write.csv(Fruits, 'Fruits_sql.csv',quote=F,row.names=F) #quote:문자열 표시 생략/ row 행 번호 제거. 
fruits_2 <- read.csv.sql('Fruits_sql.csv',sql='SELECT * FROM file WHERE Year = 2008') ; fruits_2

fruits_2 <- subset(Fruits, Fruits$Year=2008)
fruits_2
###===============================================================================
### 엑셀 읽기 1. loadWorkbook, readWorksheet, read.delim =========================
###===============================================================================

install.packages("XLConnect")
library(XLConnect)

data1 <- loadWorkbook('fruits_6.xls',create=T)
data2 <- readWorksheet(data1,sheet="sheet1",startRow=1,endRow=8,startCol=1,endCol=5) ;data2
#startRow : endRow : startCol : endCol : 엑셀의 원하는 부분을 읽기위한 명령어

fruits6 <- read.delim("clipboard",header=T) # 엑셀의 원하는 셀을 클립보드에 복사후 
fruits6


###===============================================================================
### 엑셀 읽기 2.  read_excel()  ==================================================
###===============================================================================

#https://rfriend.tistory.com/313 참고
install.packages("readxl")
library(readxl)

fruits7 <- read_excel('fruits_6.xls',        # path
                       sheet     = "Sheet1", # sheet name to read from
                       range     = "A2:D6",  # cell range to read from
                       col_names = TRUE,     # TRUE to use the first row as column names
                       col_types = "guess",  # guess the types of columns
                       na = "NA")            # Character vector of strings to use for missing values




