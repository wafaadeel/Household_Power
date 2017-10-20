library(lubridate)
library(ggplot2)
library(dplyr)
library(grid)
library(gridBase)
library(gridExtra)
library(png)
dev.set(3)

plot2<-plot(hp$when, hp$Global_active_power, type="l", ylab="Global Active Power (kilowatts)" ,xlab=" ")

plot3<- ggplot(hp, aes(when))+
  geom_line(aes(y=Sub_metering_1, col="Sub_metering_1"))+
  geom_line(aes(y=Sub_metering_2, col="Sub_metering_2"))+
  geom_line(aes(y=Sub_metering_3, col="Sub_metering_3"))+
  scale_colour_manual(values=c("black", "red", "blue"))+
  labs(y="Energy Sub Metering", x=" ")+
  scale_x_datetime(date_breaks="1 day", date_labels=c("Sat", "Thu", "Fri"))+
  theme_classic()+
  theme(legend.title = element_blank(), legend.justification = "top",legend.position = c(.895, 1),legend.background = element_rect(colour="black"),panel.border = element_rect(colour="black", fill=NA))


plot4a<-plot(hp$when, hp$Voltage, type="l", ylab="Voltage" ,xlab="datetime")
plot4b<-plot(hp$when, hp$Global_reactive_power, type="l", ylab="Global_reactive_power" ,xlab="datetime")

plot2.png <- readPNG("./plot2.PNG")
plot3.png <- readPNG("./plot3.PNG")
plot4a.png <- readPNG("./plot4a.PNG")
plot4b.png <- readPNG("./plot4b.PNG")

g1 <- rasterGrob(plot2.png, interpolate=TRUE)
g2 <- rasterGrob(plot3.png, interpolate=TRUE)
g3 <- rasterGrob(plot4a.png, interpolate=TRUE)
g4 <- rasterGrob(plot4b.png, interpolate=TRUE)

grid.arrange(g1, g3, g2, g4, nrow=2, ncol=2)
dev.copy(png,'plot4.png')        
dev.off()