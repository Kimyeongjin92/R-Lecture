# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-05-(화) / 423page

###============================================================
### R에서 사용하는 MySQL (sqldf) ==============================
###============================================================

install.packages('sqldf')
library(sqldf)
library(googleVis)
Fruits

### 원하는 데이터 출력
sqldf('SELECT * FROM Fruits')
sqldf("SELECT * FROM Fruits WHERE Fruit='Apples'")   # " '' " 는 각각 인식 가능하지만
sqldf('SELECT * FROM Fruits WHERE Fruit=\'Apples\'') # ' '' ' 는 코드가 앞 뒤로 인식되기때문에 \을 붙여줘야한다.

sqldf('Select * FROM Fruits limit 3')                # LIMIT 0,3 과 똑같다. 
sqldf('Select * FROM Fruits limit 3,5')              # 출력 행수 3개 이후부터(4번째부터) 5개 보여줘라. (띄어쓰기 주의)

### 정렬하기.
sqldf('SELECT * FROM Fruits ORDER BY Year')          # 정렬해서 출력하기.
sqldf('SELECT * FROM Fruits ORDER BY Year DESC')     # 내림차순 (큰 숫자 순)

### 그룹별로 합계, 평균값 출력하기.
#sqldf('SELECT 기준변수, SUM(합칠변수) FROM 데이터파일 GROUP BY 그루핑할 변수') 
sqldf('SELECT Fruit, SUM(Sales), SUM(Expenses), SUM(Profit) 
      FROM Fruits GROUP BY Fruit') # 과일별 합계
sqldf('SELECT Year, AVG(Sales), AVG(Expenses), AVG(Profit) 
      FROM Fruits GROUP BY Year ') 
sqldf('SELECT Year, AVG(Sales), AVG(Expenses), AVG(Profit) 
      FROM Fruits GROUP BY Year ORDER BY AVG(Profit) DESC') # 년도별 평균

### Sub Query
# 1. 판매 최대 최저 금액을 찾아라.
# 2. 최저 판매인 81에 해당하는 과일을 찾아라.
sqldf('SELECT Fruit, MAX(Sales), MIN(Sales) FROM Fruits')
sqldf('SELECT * FROM Fruits WHERE Sales=81') 

# 3. 위의 과정을 한번에 할 수 있는 Sub Query사용하기
sqldf('SELECT * FROM Fruits WHERE Sales =
      (select min(sales) from Fruits)')
sqldf('SELECT * FROM Fruits WHERE Expenses =
      (select max(Expenses) from Fruits)')

# 4. 그렇다면 두개 이상 출력하려면?
sqldf("SELECT * FROM Fruits WHERE Sales IN =
      (select min(Sales), max(Sales) from Fruits)")

### JOIN 사용하기. (song$girl_group데이터사용.)
song <- read.csv('song.csv',header=F, fileEncoding = 'utf8') ; song
colnames(song) <- c('_id','title','lyrics','girl_group_id') ; song

girl <- read.csv('girl_group.csv',header=F, fileEncoding = 'utf8') ; girl
names(girl) <- c('_id','name','debut') ; girl

sqldf("select g._id, g.name, g.debut
      from girl AS g
      inner join song AS s
      on g._id = s.girl_group_id")

sqldf("select g._id, g.name, g.debut
      from girl AS g
      join song AS s
      on g._id = s.girl_group_id")


### UPDATE/ DELETE 사용하기
#1. UPDATE와 DELETE는 명령을 실행하는 순간에만 데이터를 바꿔주기 때문에 저장해야한다.
sqldf(c("UPDATE Fruits SET Profit=50 WHERE Fruit='Apples' AND Year=2008",
        'select * from Fruits'))
sqldf(c("UPDATE Fruits SET Profit=40 WHERE Fruit='Apples' AND Year=2008",
        'select * from Fruits'))

#2. DELETE
sqldf(c("DELETE FROM Fruits WHERE Fruit='Apples' AND Year=2008",
        'select * from Fruits'))
sqldf(c("DELETE FROM Fruits WHERE Fruit='Apples' AND Year=2009",
        'select * from Fruits'))



