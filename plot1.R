# assuming data file is in working directory. Otherwise script will throw error
library(dplyr)

file<-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
file2<-subset(file, Date=="1/2/2007" | Date=="2/2/2007")
tbl<-tbl_df(file2)
rm(file)

tbl$Date<-strptime(tbl$Date, "%d/%m/%Y")
tbl$Time<-strptime(tbl$Time, "%H:%M:%S")

tbl$Global_active_power<-as.numeric(tbl$Global_active_power)
tbl$Global_reactive_power<-as.numeric(as.character(tbl$Global_reactive_power))
tbl$Voltage<-as.numeric(as.character(tbl$Voltage))
tbl$Global_intensity<-as.numeric(as.character(tbl$Global_intensity))
tbl$Sub_metering_1<-as.numeric(as.character(tbl$Sub_metering_1))
tbl$Sub_metering_2<-as.numeric(as.character(tbl$Sub_metering_2))
tbl$Sub_metering_3<-as.numeric(as.character(tbl$Sub_metering_3))
tbl2<-mutate(tbl, DateTime=paste(Date," ", Time))
tbl2$DateTime<-strptime(tbl2$DateTime, "%d/%m/%Y %H:%M:%S")

# plot 1
png("plot1.png", 480, 480)
hist(tbl$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatt)", col="red")
dev.off()
rm(tbl2)
rm(tbl)
rm(file2)
