library(dplyr)


mydata <- read.csv("sampledata.csv",header = TRUE)

head(mydata)

data <- filter(mydata, Index %in% c("A","C") & Y2002 >= 1300000)

data18 <- filter(mydata, !Index %in% c("A","C") & Y2002 <= 1300000)

data19 <- arrange(mydata, desc(Index), Y2011)

head(data18)
