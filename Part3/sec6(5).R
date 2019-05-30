###==================================================================
### Data.Frame 생성하기 (변수생성, matrix생성)=======================
###==================================================================

no    <- c(1,2,3,4)
name  <- c('Apple','Peach','Banana','Grape')
price <- c(500,200,100,50)
qty   <- c(5,2,4,7)
sales <- data.frame(NO=no,NAME=name, PRICE=price, QTY=qty)
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

