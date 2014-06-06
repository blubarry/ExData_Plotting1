# Script for reproducting plot4

# Read data file.  Semicolon is the separator and "?" are NAs.
consump<-read.delim("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE)

# Create POSIXlt date times from data
datetimes <- strptime(paste(consump$Date,consump$Time),"%d/%m/%Y %H:%M:%S")
# Select rows from the desired dates 
selectedrows <- as.Date(datetimes)>=as.Date("2007-02-01") & as.Date(datetimes)<=as.Date("2007-02-02")

selconsump <- consump[selectedrows,]
seldatetimes <- datetimes[selectedrows]

# open png graphics device 480x480 pixels
png("plot4.png",480,480)

# setup 2 by 2 panel and make background transparent
par(bg=NA, mfrow = c(2, 2))

# 1st plot global active power
# setup axes with plot and type="n"
plot(seldatetimes,selconsump$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
# add lines of global active power
lines(seldatetimes,selconsump$Global_active_power)

# 2nd plot voltage
# setup axes with plot and type="n"
plot(seldatetimes,selconsump$Voltage,type="n",xlab="datetime",ylab="Voltage")
# add lines of global active power
lines(seldatetimes,selconsump$Voltage)

# 3rd plot sub meterings
# setup axes with plot and type="n"
plot(seldatetimes,selconsump$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
legend("topright", box.lty="blank", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# add lines of sub meterings
lines(seldatetimes,selconsump$Sub_metering_1)
lines(seldatetimes,selconsump$Sub_metering_2,col="red")
lines(seldatetimes,selconsump$Sub_metering_3,col="blue")

# 4th plot global reactive power
plot(seldatetimes,selconsump$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
# add lines of global active power
lines(seldatetimes,selconsump$Global_reactive_power)


# finalize png
dev.off()