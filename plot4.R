# assuming data file is in working directory. Otherwise script will throw error
library(dplyr)
library(lubridate)

file<-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
file2<-subset(file, Date=="1/2/2007" | Date=="2/2/2007")
tbl<-tbl_df(file2)
rm(file)

tbl$Global_active_power<-as.numeric(tbl$Global_active_power)
tbl$Global_reactive_power<-as.numeric(as.character(tbl$Global_reactive_power))
tbl$Voltage<-as.numeric(as.character(tbl$Voltage))
tbl$Global_intensity<-as.numeric(as.character(tbl$Global_intensity))
tbl$Sub_metering_1<-as.numeric(as.character(tbl$Sub_metering_1))
tbl$Sub_metering_2<-as.numeric(as.character(tbl$Sub_metering_2))
tbl$Sub_metering_3<-as.numeric(as.character(tbl$Sub_metering_3))

tbl2<-mutate(tbl, DateTime=paste(Date," ", Time))
tbl2$DateTime<-strptime(tbl2$DateTime, "%d/%m/%Y %H:%M:%S")
tbl2<-mutate(tbl2, DOW = wday(Date, label=TRUE))

png("plot4.png", 480, 480)

par(mfrow=c(2,2))

with(tbl2, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

with(tbl2, plot(DateTime, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

#with(tbl2, plot(DateTime, Voltage, ) , xlab = "datetime", ylab = "Voltage")

with(tbl2, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(tbl2,lines(DateTime, Sub_metering_2, col="red") )
with(tbl2,lines(DateTime, Sub_metering_3, col="blue") )
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("brown","red","blue"), lty=1)


with(tbl2, plot(DateTime, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
rm(tbl2)
rm(tbl)
rm(file2)
