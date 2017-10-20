library(lubridate)
library(dplyr)
hp<-read.table("./house_power.txt", sep=";", na.strings="?", nrows=2880, skip=66637)
cn<-read.table("./house_power.txt", sep=";", na.strings="?", nrows=1)
cn<-sapply(cn, as.character)
names(hp)<-cn

when= paste(hp$Date, hp$Time)
when<-as.character(when)
when<- dmy_hms(when)
day<-weekdays(when)
hp<-mutate(hp, when=when, day=day)


dev.set(3)
png(filename = "plot2.png", width = 480, height = 480)
plot2<-plot(hp$when, hp$Global_active_power, type="l", ylab="Global Active Power (kilowatts)" ,xlab=" ")
dev.off()