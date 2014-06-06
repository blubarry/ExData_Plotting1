# Script for reproducting plot1

# Read data file.  Semicolon is the separator and "?" are NAs.
consump<-read.delim("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE)

# Create POSIXlt date times from data
datetimes <- strptime(paste(consump$Date,consump$Time),"%d/%m/%Y %H:%M:%S")

# Select rows from the desired dates 
selectedrows <- as.Date(datetimes)>=as.Date("2007-02-01") & as.Date(datetimes)<=as.Date("2007-02-02")

selconsump <- consump[selectedrows,]
seldatetimes <- datetimes[selectedrows]

# open png graphics device 480x480 pixels
png("plot1.png",480,480)

# set background to transparent
par(bg=NA)

# Plot the histogram of "Global_active_power"
hist(selconsump$Global_active_power,col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")
# finalize png
dev.off()