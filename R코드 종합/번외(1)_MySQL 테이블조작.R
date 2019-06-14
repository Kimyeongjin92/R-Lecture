
# 실전에서는 table이 보통 회사에서 전문가가 만든다.
# ()안에서는 데이터 베이스에서 사용할 필드를 정리한다.
# 항상 끝날때는 ; 으로 끝낸다.
# 필드명만이 아니라 필드명에 데이터 타입이 무엇인지도 알아야한다.
# 데이터 타입이 데이터베이스마다 좀 다르다.

## =================================================================
## =================================================================

use ezen;
create table if not exists address_book ( 
  no int unsigned not null auto_increment, . 
  name varchar(10) not null,                
  tel varchar(14),
  nickname varchar(20) default ‘별명’,
  primary key(no)
) auto_increment=10001 default charseT=utf8; 


no int unsigend not null auto_increment,
# int unsigned   : 음수를 허용하지 않겠다. 
# not null       : 반드시 데이터가 채워져야한다.
# auto_increment : DB에 접속한 많은사람들이 있어도 하나씩 순서대로 증가시킨다. 
# 만약 없으면 순서가 엉키게 된다. 중복과 빵구방지.

name varchar(10) not null,  
#

tel varchar(14),
# not null이 없으니까 입력해도되고 안해도 되고

nickname varchar(20) default ‘별명’,
# 데이터를 채우지 않으면 '별명'으로 입력된다.

primary key(no)
# key 는 유니크(unique)하다. 자연적/인위적 두개가 있다. 지금은 인위적
# 이름같은건 안된다.

) auto_increment=10001 default charseT=utf8;
# 설계가 다 끝나고 no가 10001부터 시작한다.
# 데이터 베이스는 대소문자 구별 안한다.
# but 내용물은 대소문자 구별한다.
# utf8 한글을 처리하라~ 
# 국내 표준은 EUC-KR 프로그램은 utf-8


# MySQL에서 사용할 수 있는 데이터 타입
# 문자형, 숫자형, 날짜형, 이진 데이터 타입
# (문자) VARCHAR(n) : 가변길이 데이터 타입 :늘렸다 줄였다 
# (숫자) INT(n)     : 정수형 데이터 타입 
# (날짜) DATETIME   : 날짜와 시간
# (이진) 잘 사용 안함. 

## ===================================================================
## ===================================================================


# key 는 유니크(unique)하다. 자연적/인위적 두개가 있다. 지금은 인위적
# 


USE ezen ;

CREATE TABLE if NOT EXISTS address_book (
  NO INT UNSIGNED NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(10) NOT NULL,
  tel VARCHAR(14),
  nickname VARCHAR(20) DEFAULT '별명',
  PRIMARY KEY(NO)
) AUTO_INCREMENT=10001 DEFAULT CHARSET=UTF8;

SHOW TABLES;

DESC address_book

create table

CREATE TABLE tmp (
  id INT PRIMARY KEY,
  NAME VARCHAR(10)
); 

DESC tmp

DROP TABLE tmp;
SHOW TABLES;

RENAME TABLE address_book TO addr_book;

SHOW TABLES;

ALTER TABLE addr_book ADD gender CHAR(2) NOT NULL;

ALTER TABLE addr_book ADD email VARCHAR(20) NOT NULL AFTER tel;
DESC addr_book;

ALTER TABLE addr_book DROP nickname;
DESC addr_book;

ALTER TABLE addr_book CHANGE NO abid INT(8);
DESC addr_book;
# 새로운 이름에 해당되는 데이터 타입도 써줘야한다.

ALTER TABLE addr_book CHANGE abid abid INT UNSIGNED NOT NULL auto_increment;
DESC addr_book;
# 원위치로 

ALTER TABLE addr_book MODIFY gender CHAR(2) AFTER name;
DESC addr_book;
# 위치를 바꿀때도 타입과 같이 적는다.

USE world;
# 작업은 ezen폴더. 

SELECT * FROM city;
#5개의 칼럼에 4,079개

SELECT * FROM city WHERE CountryCode='KOR';
#COUNTRY CODE와 같은 필드명은 대소문자 상관없다.
#'=' 이것을 이용하면 하수 =대신에 LIKE를 넣어서 찾는다.

SELECT * FROM city WHERE CountryCode LIKE 'KOR';

SELECT * FROM city WHERE DISTRICT LIKE 'kyonggi' AND population > 500000 ;

SELECT district FROM city WHERE countrycode='kor';

SELECT distinct district FROM city WHERE countrycode='kor';
#distinct 유니크하게 구별되는 것만 골라내 달라.(중복 없애줌!)

DESC ezen.addr_book;
#데이터 베이스 테이블 불러오기.

DESC ezen.addr_book;/*dddd*/
# #이것과 같은 주석(comment)달기 /*  */
  
SELECT * FROM city WHERE district LIKE 'taejon' OR 
district LIKE 'Chungchongbuk' OR district LIKE 'chungchongnam' ;

SELECT * FROM city WHERE district LIKE 'taejon' OR 
district LIKE 'Chungchong%' ;
# %를 뒤에 붙이면 해당 데이터를 가져온다.

SELECT * FROM city WHERE countrycode LIKE 'kor' and population > 1000000;

SELECT * FROM city WHERE countrycode LIKE 'kor' AND 
population > 1000000 AND id%2=1 ;
#홀수인 id로 가져오기. (%하나.)

SELECT * FROM city WHERE countrycode LIKE 'kor' AND 
population BETWEEN 1000000 AND 2000000 ;

SELECT * FROM city WHERE countrycode LIKE 'kor' AND 
NAME LIKE 'Tae%' ;

SELECT * FROM city WHERE district LIKE 'kyonggi' 
ORDER BY NAME;
#id가 아닌 name 순서대로.

SELECT * FROM city WHERE diStrict LIKE 'kyonggi' 
ORDER BY population DESC;
#내림차순

SELECT * FROM city WHERE countrycode='kor' ORDER BY district;

SELECT * FROM city WHERE countrycode='kor'ORDER BY district, population desc;
#district를 기준으로 인구가 많은 곳에서 줄어드는 순으로

### =========================================================================
### 데이터 조회 - 함수 이용, 그룹핑.
### =========================================================================


SELECT COUNT(*) FROM city WHERE countrycode='kor' ;        # 한국국가코드 count는 숫자.
SELECT MAX(population) FROM city WHERE countrycode='kor' ; # 서울인구
SELECT AVG(population) FROM city WHERE countrycode='kor' ;
SELECT sum(population) FROM city WHERE countrycode='kor'  ; # 우리나라 인구중에 도시에사는 인구수
SELECT min(population), max(population), avg(population),
sum(population) FROM city WHERE countrycode='kor';

SELECT GROUP_CONCAT(NAME) FROM city WHERE district='chungchongnam';

SELECT GROUP_CONCAT(DISTINCT district) FROM city WHERE countrycode='kor';

SELECT district, COUNT(*) FROM city WHERE countrycode='kor'; #count(*) 한국의 도시 수.

# group by 묶어주기.
select * FROM city WHERE countrycode='kor' GROUP BY district;
SELECT district, COUNT(*) FROM city WHERE countrycode='kor' GROUP BY district;

# district에서 도시가 6개인 district
SELECT district, COUNT(*) FROM city WHERE countrycode='kor'
GROUP BY district HAVING COUNT(*)>=6;

#count(*)기준 내림차순으로
SELECT district, COUNT(*) FROM city WHERE countrycode='kor'
GROUP BY district HAVING COUNT(*)>=6 order by COUNT(*) desc;

#도시코드를 기준으로 도시가 50개 이상인 나라.
SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode HAVING COUNT(*)>=50;

#도시코드를 기준으로 도시가 50개 이상이면서 내림차순.
SELECT countrycode, COUNT(*) FROM city 
GROUP BY countrycode HAVING COUNT(*)>=50 
ORDER BY COUNT(*) desc;

# 현업에서는 여러개의 테이블을 만들어서 가져온다.

### 밑에 복습하기.
### join 하기

SELECT City.NAME, city.population, country.Name FROM city
INNER JOIN country ON city.CountryCode = country.CODE;
# inner join 흠 on 흠 =흠 ;...

SELECT City.NAME, city.population, country.Name FROM city
INNER JOIN country ON city.CountryCode = country.CODE
WHERE city.population>7000000;

# 인구수가 가장많은 도시 top 5를 골라내라.
SELECT City.NAME, city.population, country.Name FROM city
INNER JOIN country ON city.CountryCode = country.CODE
WHERE city.population>7000000
ORDER BY city.population desc LIMIT 5;

# 조건,       # filter
# grouping,   # group_by
# column 선택 # select
# 순서        # arrange
# 갯수        # head
# 함수        # summarise
# join 를 엮어서 쓴다.

CREATE TABLE eagles (
  backNo INT UNSIGNED NOT NULL PRIMARY KEY,
  NAME VARCHAR(10) NOT NULL,
  POSITION VARCHAR(4) NOT NULL,
  highschool VARCHAR(10),
  hand VARCHAR(10)
) DEFAULT CHARSET=UTF8;

DESC eagles ;

INSERT INTO eagles VALUES
(29,'김경태','투수','동산고','좌투좌타'),
(104,'김민석','투수','라온고','우투우타'),
(108,'김관호','포수','건국대','우투우타'),
(47,'김종민','포수','단국대','우투우타'),
(14,'강경학','내야수','동성고','우투좌타'),
(5,'김민기','내야수','덕수고','우투우타'),
(39,'김민하','외야수','경남고','우투우타'),
(56,'백창수','외야수','경기고','우투우타'),
(9,'이동훈','외야수','상원고','좌투좌타'),
(51,'장진혁','외야수','단국대','우투좌타');

SELECT * FROM eagles ;

UPDATE eagles SET highschool='광주제일고' WHERE backNo=36;
UPDATE eagles SET POSITION='외야수' WHERE backNo=50;
SELECT * FROM eagles;

DELETE FROM eagles WHERE backNo=29 OR backNo=104;
SELECT * FROM eagles;

INSERT INTO eagles VALUES
(29, '김경태', '투수', '동산고', '좌투좌타'),
(104, '김민석', '투수', '라온고', '우투우타');
SELECT * FROM eagles;

CREATE VIEW pitcher AS SELECT * FROM eagles
WHERE POSITION LIKE '투수' ;
SELECT * FROM pitcher ;

CREATE VIEW infielder AS SELECT * FROM eagles
WHERE POSITION LIKE '내야수';
SELECT * FROM infielder; 

CREATE VIEW outfielder AS SELECT * FROM eagles
WHERE POSITION LIKE '외야수';
SELECT * FROM outfielder; 

DROP VIEW infielder;

CREATE VIEW infielder 
AS SELECT backNo, NAME, highschool, hand FROM eagles
WHERE POSITION LIKE '내야수';

SELECT * FROM infielder;

ALTER TABLE eagles ADD birthday DATE;
DESC eagles;

UPDATE eagles SET birthday='1991-05-18' WHERE backNo=29;
SELECT * FROM eagles;

UPDATE eagles SET birthday='1991-02-28' WHERE backNo=29;
UPDATE eagles SET birthday='1999-07-30' WHERE backNo=104;
UPDATE eagles SET birthday='1995-10-11' WHERE backNo=108;
UPDATE eagles SET birthday='1986-03-30' WHERE backNo=47;
UPDATE eagles SET birthday='1992-08-11' WHERE backNo=14;
UPDATE eagles SET birthday='1991-05-18' WHERE backNo=5;
UPDATE eagles SET birthday='1989-02-25' WHERE backNo=39;
UPDATE eagles SET birthday='1988-05-28' WHERE backNo=56;
UPDATE eagles SET birthday='1979-03-14' WHERE backNo=9;
UPDATE eagles SET birthday='1993-07-15' WHERE backNo=51;
SELECT * FROM eagles;

#현재 날짜 시간.
SELECT NOW(),CURDATE(),CURTIME();

#나이가 제일 많은 사람 순으로.
SELECT * FROM EAGLES ORDER BY BIRTHDAY;

#양쪽에 데이터가 나오는걸 inner join 한쪽에만 있는것 outer join

SELECT NAME, DATE_FORMAT(BIRTHDAY,"%y%m%d") FROM EAGLES ORDER BY BIRTHDAY;
SELECT NAME, DATE_FORMAT(BIRTHDAY,"%Y%M%D") FROM EAGLES ORDER BY BIRTHDAY;



CREATE TABLE girl_group (
  _id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(32) NOT NULL,
  debut DATE NOT NULL,
  hit_song_id INT
) DEFAULT CHARSET=UTF8;
SELECT * FROM girl_group ;

INSERT INTO girl_group (name, debut, hit_song_id) 
VALUES ('원더걸스', '2007-02-10', 101),
('소녀시대', '2007-08-02', 102), ('카라', '2009-07-30', 103),
('브라운아이드걸스', '2008-01-17', 104), ('다비치', '2009-02-27', 105),
('2NE1', '2009-07-08', 107), ('f(x)', '2011-04-20', 109),
('시크릿', '2011-01-06', 110), ('레인보우', '2010-08-12', 111);
SELECT * FROM girl_group ;

INSERT INTO girl_group (name, debut) VALUES
('애프터 스쿨', '2009-11-25'), ('포미닛', '2009-08-28');
SELECT * FROM girl_group ;



CREATE TABLE song (
  _id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(32) NOT NULL,
  lyrics VARCHAR(32)
) DEFAULT CHARSET=UTF8;
SELECT * FROM song ;

INSERT INTO song VALUES (101, 'Tell Me', 'tell me tell me tetetete tel me');
INSERT INTO song (title, lyrics) 
VALUES ('Gee', 'GEE GEE GEE GEE GEE BABY BABY'),
('미스터', '이름이 뭐야 미스터'), 
('Abracadabra', '이러다 미쳐 내가 여리여리'),
('8282', 'Give me a call Baby baby'), ('기대해', '기대해'),
('I Don\'t car', '다른 여자들의 다리를'), 
('Bad Girl Good Girl', '앞에선 한 마디 말도'), ('피노키오', '뉴예삐오'),
('별빛달빛', '너는 내 별빛 내 마음의 별빛'), 
('A', 'A 워오우 워오우워 우우우'),
('나혼자', '나 혼자 밥을 먹고 나 혼자 영화 보고'), ('LUV', '설레이나요 '),
('짧은치마', '짧은 치마를 입고 내가 길을 걸으면'),
('위아래', '위 아래 위위 아래'), ('Dumb Dumb' , '너 땜에 하루종일');

SELECT gg._id, gg.name, s.title
FROM girl_group AS gg
INNER JOIN song AS s  # join song AS s
ON s._id = gg.hit_song_id;

SELECT gg._id, gg.name, s.title
FROM girl_group AS gg
LEFT JOIN song AS s  # join song AS s
ON s._id = gg.hit_song_id;

SELECT gg._id, gg.name, s.title
FROM girl_group AS gg
RIGHT JOIN song AS s  # join song AS s
ON s._id = gg.hit_song_id;


#1
SELECT * from girl_group WHERE debut LIKE '2009%'
SELECT * FROM song ;

#2
SELECT gg._id, gg.debut , gg.name, s.title
FROM girl_group  AS gg 
LEFT JOIN song AS s  
ON s._id = gg.hit_song_id 
WHERE debut LIKE '2009%';

#3
USE world;
SELECT * FROM country;
SELECT continent, SUM(GNP),COUNT(*),AVG(GNP) 
FROM COUNTRY GROUP BY continent;

#4
SELECT co.Continent AS '대륙명', co.NAME AS '국가명',
c.NAME AS '도시명', c.population AS '인구수'
FROM country AS co
INNER JOIN city AS c
ON co.CODE=c.CountryCode
WHERE co.CONTINENT='Asia' 
ORDER BY c.Population DESC LIMIT 10;

#5
SELECT c.name AS '도시명', c.Population AS '인구수', cl.language AS '언어명'
FROM city AS c
INNER JOIN countrylanguage AS cl
ON c.CountryCode=cl.CountryCode
WHERE cl.IsOfficial=true 
ORDER BY c.Population DESC LIMIT 10;

# csv파일로 write 가능하게 하는 법!
USE ezen;
SHOW VARIABLES LIKE "secure_file_priv";

SELECT * FROM song INTO OUTFILE
'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/song.csv'
FIELDS TERMINATED BY ',' #(,)컴마 : csv 로 만들겠다
LINES TERMINATED BY '\r\n'; #유닉스 스타일  line Feed


SELECT * FROM girl_group INTO OUTFILE
'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/girl_group.csv'
FIELDS TERMINATED BY ',' #(,)컴마 : csv 로 만들겠다
LINES TERMINATED BY '\r\n'; #유닉스 스타일  line Feed




