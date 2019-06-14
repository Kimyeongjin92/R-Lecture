###=======================================================================================
### 폰트 설치하기. =======================================================================
###=======================================================================================

install.packages("extrafont")
library(extrafont)
# 모든 글씨체는 제어판  →  글꼴 폴더에 설치가 되어 있어야 한다.
font_import()
y
loadfonts(device="win")

#원하는 글씨체 
font_import(pattern = "")

windowsFonts(malgun=windowsFont("맑은 고딕"))
windowsFonts(headline=windowsFont("HY헤드라인M"))
windowsFonts(baedal=windowsFont("배달의민족 도현"))
