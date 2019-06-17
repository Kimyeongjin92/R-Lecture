# [빅데이터를 활용한 스마트 데이터 전문가 양성과정]
# 2019-06-17-(월) / 


setwd('D:/dudwlsrla92/R_Data_Analysis/Part2/stage6_Real/Ex04_welfare')
getwd()

install.packages('foreign')
library(foreign)            # spss파일 로드
library(dplyr)              # 전처리 
library(ggplot2)            # 시각화
library(readxl)             # 엑셀 파일 불러오기

### ====================================================================
###  0. 기본준비과정  =================================================
### ====================================================================

# 0). 데이터 불러오기
raw_welfare <- read.spss(file= "09-1.Koweps_hpc10_2015_beta1.sav",to.data.frame=T)

# 1). 복사본 만들기
welfare <- raw_welfare

# 2). 데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)     # spss를 보면, 레이블에 대한 설명도 볼 수 있다.
dim(welfare)      # dim row: 16664, col: 957
str(welfare)      # col명에 데이터 타입확인.
summary(welfare)  # 기초통계량 Min, 1st Qu, Median, Mean 3rd Qu, Max, (NA) 6가지 확인. 

# 3). 데이터의 변수 명 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,            # 성별
                  birth = h10_g4,          # 생일
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드


### ==========================================================================
###  1. 성별에 따른 월급 차이 (성별 변수 / 월급 변수 ) ======================
### ==========================================================================

# 1) 성별변수 검토하기.
class(welfare$sex)
table(welfare$sex)

# 2) 전처리

# 이상치 확인
table(welfare$sex)

# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, 'male','female')
table(welfare$sex)
qplot(welfare$sex)

# ==========================================================

# 1) 월급변수 검토하기.
class(welfare$income)
summary(welfare$income)   # NA's 
qplot(welfare$income)
qplot(welfare$income) + xlim(0,1000) 

# 2) 전처리.

# 이상치 확인
summary(welfare$income)

# 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0,9999),NA, welfare$income) 
# 0이나 9999는 결측치로 처리한다. 아니면 그대로.

# 결측치 확인
table(is.na(welfare$income)) # 12044개가 결측치.

# ==========================================================

# 1) 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
sex_income

# 2) ggplot으로 그래프 만들기.
ggplot(sex_income,aes(x=sex,y=mean_income,fill=sex))+
  geom_col()



### =======================================================================
###  2. 나이와 월급의 관계 (나이에 따른 월급 평균표.) ====================
### =======================================================================

# 1) 나이변수 검토하기
class(welfare$birth)
summary(welfare$birth) # 1907~2014년까지.
qplot(welfare$birth)

# 2) 전처리하기.

# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

# 3) 파생변수 만들기 - 나이.
welfare$age <- 2015 - welfare$birth +1 
summary(welfare$age)
qplot(welfare$age)

# ==========================================================

# 1) 나이 월급 평균표 만들기
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
age_income
summary(age_income)

# 2) ggplot으로 그래프 만들기.
ggplot(age_income,aes(x=age,y=mean_income,fill=age))+
  geom_line()


### ==============================================================================
###  3. 연령대에 따른 월급차이. (어떤 연령대의 월급이 가장 많을까.) =============
### ==============================================================================

# 1) 파생변수 만들기 - 연령대.
welfare<- welfare %>%
  mutate(연령대 = ifelse(age < 20, "10대",
                  ifelse(age < 30, "20대",
                  ifelse(age < 40, "30대",
                  ifelse(age < 50, "40대",
                  ifelse(age < 60, "50대",
                  ifelse(age < 70, "60대",
                  ifelse(age < 80, "70대",
                  ifelse(age < 90, "80대","90대이상")))))))))

table(welfare$연령대)
summary(welfare$연령대)

# 2) 연령대별 월급 평균표 만들기.
연령대_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(연령대) %>%
  summarise(mean_income = mean(income))
연령대_income

ggplot(연령대_income,aes(x=연령대,y=mean_income,fill=연령대))+
  geom_bar(stat="identity",color="black")
# scale_x_discrete(limits = c("young","middle","old")) # 그래프 순서.


### ==============================================================================
###  4. 연령대 및 성별에 따른 월급차이. group_by(ageg,sex) 두개를 넣는다 ========
### ==============================================================================

# 1) bar 그래프(연령대&성별)
연령대_sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(연령대, sex) %>%
  summarise(mean_income = mean(income))
연령대_sex_income

ggplot(연령대_sex_income,aes(x=연령대,y=mean_income,fill=sex))+
  geom_bar(stat="identity",color="black",position="dodge") # geom_col(position="dodge") 같다.
#  facet_wrap(~연령대,ncol=4) x를 sex로 바꿔야함.


# 2) line 그래프(나이&성별)
age_sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))
age_sex_income

ggplot(age_sex_income,aes(x=age,y=mean_income,col=sex))+
  geom_line(size=1) 


### ==============================================================================
###  5. 직업별 월급 차이. (어떤 직업이 월급을 가장 많이 받을까). ================
### ==============================================================================

# 1). 변수 검토하기
class(welfare$code_job)
table(welfare$code_job)

# 2). 직업분류코드 목록 불러오기
list_job <- read_excel("09-1.Koweps_Codebook.xlsx", col_names=T,sheet=2)
head(list_job)
dim(list_job)

# 3). 공통된 code_job을 기준으로 join하기
welfare <- left_join(welfare, list_job,id="code_job")
welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job,job) %>%
  head(10)

# 4). 직업별 월급 평균표 만들기
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>%
  tail(10)
job_income

# 5-1). (상위에서 10개) 그래프 그리기
ggplot(job_income,aes(x= reorder(job,mean_income),y=mean_income,fill=job))+
  geom_col(color="black") +
  coord_flip() # x의 job 이름이 너무 길기 때문에 가로로


# 5-2). (하위에서 10개) 그래프 그리기
job_income2 <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>%
  head(10)

ggplot(job_income2,aes(x= reorder(job,-mean_income),y=mean_income,fill=job))+
  geom_col(color="black") +
  coord_flip() # 가로로 만들어준다.


### ==============================================================================
###  6. 성별 직업 빈도 분석하기. (어떤 성별이 직업을 많이 갖을까)  ==============
### ==============================================================================

# 1-1) 남자
job_male<- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_male

# 1-2) 여자
job_female<- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_female

# 2-1) 남자 직업 빈도 상위 10개 직업.
ggplot(job_male,aes(x=reorder(job,n),y=n,fill=job))+
  geom_col(col="black")+
  coord_flip()

# 2-2) 여자 직업 빈도 상위 10개 직업.
ggplot(job_female,aes(x=reorder(job,n),y=n,fill=job))+
  geom_col(col="black")+
  coord_flip()


### ==============================================================================
###  7. 종교 유무에 따른 이혼률  (종교 변수 / 이혼률 변수)  =====================
### ==============================================================================

# 1-1) 종교변수 검토하기.
class(welfare$religion)
table(welfare$religion)

# 1-2) 전처리.
# 종교 유무에 따른 이름부여
welfare$religion <- ifelse(welfare$religion == 1, "yes","no")
table(welfare$religion)
qplot(welfare$religion)

# 2-1) 이혼률 변수 검토하기.
class(welfare$marriage)
table(welfare$marriage)

# 2-2) 전처리
#혼인 상태에 따른 이름부여.
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                          ifelse(welfare$marriage == 3, "divorce",NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

# 3) 종교 유무에 따른 이혼률 표 
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>%      # NA제거
  group_by(religion, group_marriage) %>% 
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))
religion_marriage

# 이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>%
  select(religion,pct)
divorce

# 그래프 만들기
ggplot(divorce,aes(x=religion,y=pct,fill=religion))+
  geom_col(col='black') +
  theme_bw(base_family="baedal",base_size=10) +
  ggtitle('종교 유무에 따른 이혼률')


### ==============================================================================
###  8. 연령대별 이혼율 표 만들기 (연령대 변수 / 이혼율 변수)  ==================
### ==============================================================================

# 1)
연령대_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>%      # NA제거
  group_by(연령대, group_marriage) %>% 
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))
연령대_marriage

# 2) 초년 제외, 이혼 추출
연령대_divorce <- 연령대_marriage %>%
  filter(연령대 != "10대" & group_marriage == "divorce") %>%
  select(연령대,pct)
연령대_divorce

# 3) 그래프 만들기
ggplot(연령대_divorce, aes(x= 연령대, y=pct, fill=연령대)) +
  geom_col(col='black')


### ==============================================================================
###  9. 연령대, 종교유무, 결혼상태별 비교  ======================================
### ==============================================================================

# 1) 연령대, 종교유무, 결혼상태별 비율표 만들기 
연령대_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & 연령대 != "10대") %>%
  group_by(연령대, religion, group_marriage)  %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))
연령대_religion_marriage

# 2) 연령대 및 종교 유무별 이혼율 표 만들기.
df_divorce <- 연령대_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(연령대, religion, pct)
df_divorce

# 3) 연령대 및 종교 유무에 따른 이혼율 그래프.
ggplot(df_divorce,aes(x=연령대, y=pct, fill=religion))+
  geom_col(position="dodge",col="black") +
  theme_bw(base_family="baedal",base_size=10) +
  ggtitle('')


### ==============================================================================
###  10. 지역별 연령대 비율 (노년층이 가장 많은 지역) ===========================
### ==============================================================================

# 1) 지역변수 검토하기
class(welfare$code_region)
table(welfare$code_region)

# 2) 전처리

# 지역코드 목록 만들기.
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region

# 3) welfare에 지역명 변수 추가.
welfare <- left_join(welfare, list_region, id = "code_region")
welfare %>% 
  select(code_region,region) %>% 
  head

# 4) 지역별로 연령대 비율표 만들기
region_연령대 <- welfare %>% 
  group_by(region, 연령대) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,2))
head(region_연령대)


# 5-1) 지역별로 연령대 비율 그래프.
ggplot(region_연령대,aes(x=region,y=pct,fill=연령대))+
  geom_col(col="black",position="dodge") +
#  facet_wrap(~region,ncol=3) + 이걸 쓰려면 x = 연령대
  coord_flip()
# scale_x_discrete(limits = c("young","middle","old")) # 그래프 순서.



# 5-2) 노년층 비율 내림차순 정렬 ( 원래는 여기에 연령대가 아니라 ageg라서 제대로 실행이 안됨.)
list_order_old <- region_연령대 %>%
  filter(연령대 == '60대' & '70대' & '80대' & '90대이상') %>%
  arrange(desc(pct))
list_order_old

#지역명 순서 변수 만들기
order <- list_order_old$region

#그래프 
ggplot(list_order_old,aes(x=region,y=pct,fill=연령대))+
  geom_col(col="black",position="dodge") +
  coord_flip() +
  scale_x_discrete(limits=order)
# scale_x_discrete(limits = c("young","middle","old")) # 그래프 순서.



#연령대 순으로 막대색깔 나열하기 (알파벳 순으로 말고 연령순으로 고치기위한 코드)
class(region_ageg$ageg)
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old","middle","young"))

class(region_ageg$ageg)
levels(region_ageg$ageg)

# 그래프 그리기
ggplot(region_ageg,aes(x=region,y=pct,fill=ageg))+
  geom_col() + 
  coord_flip() +
  scale_x_discrete(limits=order)
