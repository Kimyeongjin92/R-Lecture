###==========================================
### 정규식 : 검색해서 써봅시다. ===========
###==========================================

# https://118k.tistory.com/249
# https://regexr.com/
# https://regex101.com/
  
# 정규 표현식 443page
char  <- c('apple','Apple','APPLE','banana','grape')
grep('apple',char)
char2 <- c('apple','banana')
grep(paste(char2,collapse='|'),char,value=T)

grep('pp',char)
grep('pp',char,value=T)
grep('^A',char,value=T)
grep('e$',char,value=T)

char3 <- c('grape1','apple1','apple','orange','Apple')
grep('ap',char3,value=T)           # 'ap' 포함 단어
grep('[1-9]',char3,value=T)        # 숫자 포함 단어
grep('\\d',char3,value=T)          # 숫자 포함 단어(2)
grep('[[:upper:]]',char3,value=T)  # 대문자가 포함된 단어
grep('[A-Z]',char3,value=T)        # 대문자가 포함된 단어(2)

nchar(char)
nchar('Young Jin Kim')  # 띄어쓰기 포함.
nchar('서진수')

paste("a","b","c")         # a b c 값들 사이에 공백이 생김
paste("a","b","c",sep='')  # abc   공백을 지움
paste("a","b","c",sep=',') # a,b,c
paste('I','\'m','Hungry')  # 특수문자가 있는경우 (\)를 써야한다.

substr('abc123',3,3)
substr('abc123',3,4)

strsplit('2019/06/05',split='/') # 지정글자 기준으로 분리

grep('-','010-2900-2344')    # grep으로는 위치를 찾을 수 없음
regexpr('-','010-2900-2344') # 처음 나오는 '-'문자 위치 찾기
