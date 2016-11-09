# assuming data file is in working directory. Otherwise script will throw error
library(dplyr)
library(lubridate)
library(ggplot2)

file<-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
file2<-subset(file, Date=="1/2/2007" | Date=="2/2/2007")
tbl<-tbl_df(file2)
rm(file)

tbl$Sub_metering_1<-as.numeric(as.character(tbl$Sub_metering_1))
tbl$Sub_metering_2<-as.numeric(as.character(tbl$Sub_metering_2))
tbl$Sub_metering_3<-as.numeric(as.character(tbl$Sub_metering_3))


tbl2<-mutate(tbl, DateTime=paste(as.character(Date)," ", as.character(Time)))
tbl2$DateTime<-strptime(tbl2$DateTime, "%d/%m/%Y %H:%M:%S")

tbl2<-mutate(tbl2, DOW = wday(Date, label=TRUE))

tbl3<-select(tbl2, DateTime,DOW, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png("plot3.png", 480, 480)

with(tbl3, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(tbl3,lines(DateTime, Sub_metering_2, col="red") )
with(tbl3,lines(DateTime, Sub_metering_3, col="blue") )
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("brown","red","blue"), lty=1)

dev.off()
rm(tbl3)
rm(tbl2)
rm(tbl)
rm(file2)
