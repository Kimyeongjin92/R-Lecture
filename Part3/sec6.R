### Vector = 1차원 (동일한 형태의 데이터를 모아서 함께 저장하는 것)
### Matrix = 2차원
### Array  = 3차원

### Vector 다루기. (입력, 전환, 생략, 색인)
### CRUD (Create Retrieve Update Delete의 과정을 할 수 있어야한다.)

c(1,2,3,4,5)
c(1,2,3,4,'5')
vec1<-c(12,23,34,45,56); vec1

vec1[3]        # 3번째 
vec1[-3]       # 3번째를 제외한 모든값.
vec1[3]  <- 6  # 변수값을 바꿀 때
vec1[10] <-10  # 6~9까지의 값은 NA(결측값)으로 생성된다.
vec1[1:3]
vec1[-1:-3]
vec1[-(1:3)]
vec1 <- c(vec1, 7, 6, 9, 8, 9) ;vec1

append(vec1,10,after=5)       # after의 5는 index의 5(즉, 다섯번째 뒤에 10을 입력)
append(vec1,c(10,11),after=0) # after 0은 제일 앞 위치함.
vec1 <- append(vec1,c(10,11),after=5) ; vec1

length(vec1)  #변수의 길이 ex)5
vec1[length(vec1)]
vec1[1:(length(vec1)-2)] 

