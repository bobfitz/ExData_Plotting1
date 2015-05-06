plot1 <-function()
{
        library(lubridate)
        # read the whole dataset
        x <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=c(Date="character", Time="character", Global_active_power="double", Global_reactive_power="double", Voltage="double", Global_intensity="double", Sub_metering_1="double", Sub_metering_2="double", Sub_metering_3="numeric"))
        # convert the date and time to lubridate posix format
        x$Date <- dmy(x$Date)
        x$Time <- hms(x$Time)
        
        # use lubridate interval %within% for subset
        int <- new_interval(ymd("2007-02-01"), ymd("2007-02-02"))
        xs <- subset(x, ymd(x$Date) %within% int)
        
                
        # make plot 1
        png(file="plot1.png", width=480, height=480)
        par(bg="white")
        hist(xs$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        # close the png        
        dev.off()
}