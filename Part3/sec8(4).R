###===============================================================================
### reshape2() melt dcast 함수  ==========================================
###===============================================================================

install.packages("reshape2")
library(reshape2)
library(plyr)
fruits<-read.csv('fruits_10.csv')

melt(fruits,id='year') #id를 기준으로 (Wide 형태) -> (Long형태)
melt(fruits,id=c('year','name'))
melt(fruits,id=c('year','name'),variable.name='변수명',value.name='변수값')

mtest <-melt(fruits, id=c('year','name'),variable.name='변수명',value.name='변수값')
dcast(mtest,year+name~변수명) # 
dcast(mtest,name~변수명,sum)  # name을 기준으로 
dcast(mtest,name~변수명,sum,subset=.(name=='apple'))
     

###===============================================================================
### stringr함수 detect(), count(), c(), dup(), length(), locate(), replace() 등 =<
###===============================================================================

install.packages('stringr')
library(stringr)

fruits <- c('apple','Apple','banana','pineapple')
str_detect(fruits,'A')     # 대문자 A가 있는 단어
str_detect(fruits,'^a')    # 첫글자가 소문자 a
str_detect(fruits,'e$')    # 끝나는 글자가 소문자 e인 단어 찾기.
str_detect(fruits,'^[aA]') # 시작하는단어가 대문자 A나 소문자 a인 단어 찾기
str_detect(fruits,'[aA]')  # 단어에 소문자 a와 대문자 A가 들어 있는 단어 찾기.
str_detect(fruits,regex('a',ignore_case=T)) # 대소문자 구별 없이 

str_count(fruits,'a')      # 해당 글자가 몇 번 나오는지 알려준다.
str_count(fruits,regex('a',ignore_case=T)) #대소문자 구별 X

str_c("apple","banana")    # paste()처럼 문자열 합쳐서 출력.
str_c("Fruits: ",fruits)   # 기호를 추가할 수 있다.
str_c(fruits," name is ",fruits)
str_c(fruits,collapse="")  # 
str_c(fruits,collapse="-") # 문자열 사이에 넣기.

str_dup(fruits,3)          # 주어진 횟수만큼 반복출력

str_length('apple')        # 문자열의 길이를 출력.
str_length('과일')         # UTF8로 저장하면 한글자당 3bite이다. 
str_length(fruits)

str_locate('apple','a')    # a의 위치 : 1
str_locate('apple','app')  # start 1, end 3
str_locate(fruits,'a')     # 

str_replace('apple','p','*') #문자 바꾸기
str_replace('apple','p','++')
str_replace_all('apple','p','*')

fruits <- str_c('apple','/','banana','/','orange')
str_split(fruits,"/") # [[1]] split의 결과는 list로 저장된다.
str_split(fruits,"/") # 데이터셋을 지정된 기호로 분리하는 함수.

str_sub() 함수
fruits
str_sub(fruits,start=1,end=3)   # "app"
str_sub(fruits,start=6,end=9)   # "/ban"
str_sub(fruits,start=-5)        # -는 뒤에서부터 시작.
str_sub(fruits,start=-5,end=-2) #substr(a,1,3) 이것도 가능.

str_trim('  apple banana berry ')  # white space에 해당되는 앞 뒤의 공백을 제거.
str_trim('\t apple banana berry ')
str_trim('   apple banana berry  \n   apple banana berry  ')



