library(lubridate)
library(ggplot2)
library(dplyr)
library(png)
hp<-read.table("./house_power.txt", sep=";", na.strings="?", nrows=2880, skip=66637)
cn<-read.table("./house_power.txt", sep=";", na.strings="?", nrows=1)
cn<-sapply(cn, as.character)
names(hp)<-cn
when= paste(hp$Date, hp$Time)
when<-as.character(when)
when<- dmy_hms(when)
day<-weekdays(when)
hp<-mutate(hp, when=when, day=day)

plot3<- ggplot(hp, aes(when))+
        geom_line(aes(y=Sub_metering_1, col="Sub_metering_1"))+
        geom_line(aes(y=Sub_metering_2, col="Sub_metering_2"))+
        geom_line(aes(y=Sub_metering_3, col="Sub_metering_3"))+
        scale_colour_manual(values=c("black", "red", "blue"))+
        labs(y="Energy Sub Metering", x=" ")+
        scale_x_datetime(date_breaks="1 day", date_labels=c("Sat", "Thu", "Fri"))+
        theme_classic()+
        theme(legend.title = element_blank(), legend.justification = "top",legend.position = c(.8, 1),legend.background = element_rect(colour="black"),panel.border = element_rect(colour="black", fill=NA))

ggsave(plot3, file="./plot3.png", , width = 4, height = 4, units="in", dpi=120)
