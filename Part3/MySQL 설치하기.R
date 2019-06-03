# Mysql 설치 방법
# 1. https://dev.mysql.com/downloads/file/?id=485751에서 5.7.26 설치
# 2. https://dotnet.microsoft.com/download/dotnet-framework/net452 오류떴을때 .NET Framework 4.5.2 설치
# 3. root pw - smartdata로 설정함. 설치시 조심조심.
# 4. cmd -> cd c\Program Files\MySQL\My Server 5.7\bin
# 5. create user ‘smartuser'@'localhost' identified by ‘smartpass'; : 직접 입력해야한다.
# 6. grant all privileges on *.* to ‘smartuser'@'localhost'; 직접 입력
# 7. flush privileges; 직접 입력

# 8. https://www.heidisql.com/download.php에서 installer에서 다운
# 9. 설치 
# 10. ID smartuser / pw smartpass
# 11. world create database ezen
#     default character set utf8
#     default collate utf8_general_ci; 입력후 재생 후 새로고침
