setwd("D:/dudwlsrla92/R_Data_Analysis/R-Lecture/Part3/data")
a<- readLines('urls.txt')
class(a)

install.packages('stringr')
library(stringr)

a2<-str_detect(a,'tag')
a3<-str_detect(a,'economy/article')
a[a3]

a

b  <- read.csv('1-4호선승하차승객수.csv')
b[nchar(b$시간)==3,2] <- str_c(0,b[nchar(b$시간)==3,2])
b
