# [빅데이터를 활용한 스마트 데이터 전문가 양성과정] 
# 2019-05-30(목) / 306page

###============================================================================
### 날짜와 시간 [Sys.Date(), as.Date(,format=)] ===============================
###============================================================================

Sys.Date()+10     # 현재날짜와 몇일뒤의 날짜도 알 수 있다.
Sys.time()        # 날짜 + 시간
date()            # 미국식 날짜와 시간
class(Sys.Date()) # Data type = Date / 

as.Date()           #문자형태를 날짜로 지정(YYYY-MM-DD)
as.Date()-as.Date() # Date타입일 때(or Sys.Date를 빼서) D-day 계산가능
as.Date('2019-05-30') - as.Date('2019-11-07') # 161day
as.Date('30-05-2019',format='%d-%m-%Y') #' " 둘다가능
as.Date('19-05-30',format='%y-%m-%d') # %y(년도숫자2자리로 인식)
as.Date('190530',format='%y%m%d') #날짜로 표현하려는 숫자와 format을 맞춰야한다
as.Date('300519',format='%d%m%y')
as.Date('2019년 5월 30일',format='%Y년 %m월 %d일')
as.Date(10, origin=Sys.Date())    #현재날짜 기준 며칠 전후를 알 수 있다.
as.Date(10, origin='2019-05-30')  #특정날짜 기준 며칠 후를 알 수 있다.
as.Date(-10, origin='2019-05-30') #특정날짜 이전 날짜확인 가능
as.Date('2019-05-30') +10 
as.Date('2019-05-30') -10 

as.Date('2014-11-01 20:00:00') - as.Date('2014-11-01 18:30:00') #POSIXlt
as.POSIXct('2014-11-01 20:00:00') - as.POSIXct('2014-11-01 18:30:30') #POSIXct
0.491667 * 60 # 29분
0.50002 * 60  # 30초
## 시간단위로 계산하기 위한 함수 as.POSIXct()


###===========================================================================
### lubridate 날짜와 시간 제어하기============================================
###===========================================================================

install.packages("lubridate")
library(lubridate)

now()         #현재날짜와 시간
date <- now() #변수 date에 입력

year(date)
month(date)
day(date)
wday(date)    #일요일 = 1
wday(date, label=T) #label=T 글자로 표시

month(date) <- 2; date
day(date) <- 3; date
date <- date - days(2); date

date+years(1)
date+months(1)
date+days(1)
date+hours(1)
date+minutes(1)
date+seconds(1)
date <- hm("22:30") ; date #시간 분 지정하기
date <- hms("22:30:15") ; date # 시간 분 초 지정하기

###===================================================================================
### 원하는 날짜 구하기 [seq(from=as.Date(),to=as.Date(),by='year')] ==================
###===================================================================================

seq1  <- 1:5     ; seq1 #숫자 가능
seq2  <- 'a':'f' ; seq2 #문자 불가능
date1 <- seq(from=as.Date('1992-01-28'),to=as.Date('2019-11-07'),by='year')  ;date1
date2 <- seq(from=as.Date('2019-05-30'),to=as.Date('2019-11-07'),by='month') ;date2
date3 <- seq(from=as.Date('2019-05-30'),to=as.Date('2019-11-07'),by=1)       ;date3
class(date1)
