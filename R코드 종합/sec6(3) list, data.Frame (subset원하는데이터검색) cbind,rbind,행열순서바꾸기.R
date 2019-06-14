### list와 data.frame


###==================================================================
### list 만들기 삭제하기 (서로다른 데이터 유형 저장가능)=============
###==================================================================

list1 <- list(name='Ironman', address='Newyork', tel='010-2900-2344', age=28)

list1$name                                   # Key 검색
list1$Company  <- 'marvel'                   # key 추가
list1$position <- c('Attacker','Defender')   # Key 추가 + 값 2개
list1$position <- NULL                       # Key 삭제

###==================================================================
### Data.Frame 생성하기 (변수생성, matrix생성)=======================
###==================================================================

no    <- c(1,2,3,4)
no2    <- c(1,2,3,4)
name  <- c('Apple','Peach','Banana','Grape')
price <- c(500,200,100,50)
qty   <- c(5,2,4,7)
sales <- data.frame(NO=no,NAME=name, PRICE=price, QTY=qty)

ncol(sales)    # 열 개수
nrow(sales)    # 행 개수
sales[,c(4:1)] # 순서바꾸기

sales$NAME # levesls로 표현되며 즉, charater가 아닌 factor가 된다.
sales[1,3]
sales[c(1,3),]
sales[,c(1,3)]
sales[seq(1:2),]
sales[,seq(1:2)]

sales2 <- matrix(c(1,'Apple',500,5,
                   2,'Peach',200,2,
                   3,'Banana',100,4,
                   4,'Grape',50,7 ),nrow=4,byrow=T)
df1 <- data.frame(sales2)

names(df1) <- c('NO','NAME','PRICE','QTY') ;df1 # vector랑 같다.


###==================================================================
### Data.Frame 원하는 데이터 조회하기 [subset(x,select= )] ==========
###==================================================================

subset(sales, qty<5)         # qty<5 5이하의 것을 보여줘
subset(sales, PRICE==500)    # =를 2개 입력한다.
subset(sales, PRICE!=500)    # ! = 입력시 !=로 변환됨.(NOT의 의미)
subset(sales, NAME=='Grape') # 문자는 항상 '' 

subset(sales, select=c(NO,PRICE)) ;
subset(sales, select= -QTY)       ;

###==================================================================
### Data.Frame 합치기 (cbind, rbind) ================================
###==================================================================

no    <- c(1,2,3)
name  <- c('Apple','Peach','Banana')
price <- c(100,200,300)
df1   <- data.frame(NO=no,NAME=name, PRICE=price)
df1

no    <- c(10,20,30)
name  <- c('train','car','Airplane')
price <- c(1000,2000,3000)
df2   <- data.frame(NO=no,NAME=name, PRICE=price)
df2

df3   <- cbind(df1,df2) 
df4   <- rbind(df1,df2)

new <- data.frame(NO=4, NAME="mango",PRICE=400)
dff <- rbind(df1, new); dff
dff <- rbind(df1, data.frame(NO=4, NAME="mango",PRICE=400)); dff
dff <- cbind(dff, data.frame(quantity=c(10,20,30,40))) ; dff

###==================================================================
### Data.Frame 합치기, 열 이름변경하기 [merge(a,b,all=T),colnames] ==
###==================================================================

df5 <- data.frame(name=c('apple','banana','cherry'),price=c(300,200,100))
df6 <- data.frame(name=c('apple','cherry','berry'),qty=c(10,20,30))

merge(df5,df6)           # Inner Join 교집합 공통된 것만 
merge(df5,df6, all=T)    # Outer Join 합집합 전부 다 없는 값은 NA뜸

no      <- c(1,2,3,4,5)
name    <- c('김영진','임원기','김준호','김관중','홍수영')
address <- c("서울",'대전','포항','경주','경기')
tel     <- c(1111,2222,3333,4444,5555)
hobby   <- c('독서','미술','놀고먹기','먹고놀기','노는애감시하기')
member  <- data.frame(NO=no,NAME=name, ADDRESS=address, TEL=tel, HOBBY=hobby)

member2 <- subset(member, select=c(NO,NAME,TEL))    ; member2
member3 <- subset(member, select= -TEL)             ; member3

colnames(member3) <- c("번호",'이름','주소','취미') ; member3


###==================================================================
### Data.Frame의 내용확인하기 및 출력순서 지정하기 ==================
###==================================================================

ncol(member)          # 열의 개수
nrow(member)          # 행의 개수
names(member)         # 열 이름
rownames(member)      # 행 이름
colnames(member)      # 열 이름
member[c(1,3,2,4,5),] # 행의 출력순서를 바꾼다
member[,c(1,3,2,4,5)] # 열의 출력순서를 바꾼다.
