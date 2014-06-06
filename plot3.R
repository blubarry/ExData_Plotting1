# Script for reproducting plot3

# Read data file.  Semicolon is the separator and "?" are NAs.
consump<-read.delim("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE)

# Create POSIXlt date times from data
datetimes <- strptime(paste(consump$Date,consump$Time),"%d/%m/%Y %H:%M:%S")
# Select rows from the desired dates 
selectedrows <- as.Date(datetimes)>=as.Date("2007-02-01") & as.Date(datetimes)<=as.Date("2007-02-02")

selconsump <- consump[selectedrows,]
seldatetimes <- datetimes[selectedrows]

# open png graphics device 480x480 pixels
png("plot3.png",480,480)

# set background to transparent
par(bg=NA)

# setup axes with plot and type="n"
plot(seldatetimes,selconsump$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
# add lines of 3 different sub_meterings
lines(seldatetimes,selconsump$Sub_metering_1)
lines(seldatetimes,selconsump$Sub_metering_2,col="red")
lines(seldatetimes,selconsump$Sub_metering_3,col="blue")
# add legend
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# finalize png
dev.off()