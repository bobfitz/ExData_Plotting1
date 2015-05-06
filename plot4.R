plot4 <-function()
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
        
        # plot4
        png(file="plot4.png", width=480, height=480)
        # setup the four plot grid
        par(mfrow=c(2,2), mar=c(4,4,4,1), bg="white")
        # top left
        plot(xs$Date+xs$Time, xs$Global_active_power, type="n", ylab="Global Active Power", xlab ="")
        points(xs$Date+xs$Time, xs$Global_active_power, type="l")
        # top right
        plot(xs$Date+xs$Time, xs$Voltage, type="n", ylab="Voltage", xlab ="datetime")
        points(xs$Date+xs$Time, xs$Voltage, type="l")
        
        # botton left
        plot(xs$Date+xs$Time, xs$Sub_metering_1, type="n", ylab="Energy sub metering", xlab ="")
        points(xs$Date+xs$Time, xs$Sub_metering_1, col="black", type="l")
        points(xs$Date+xs$Time, xs$Sub_metering_2, col="red", type="l")
        points(xs$Date+xs$Time, xs$Sub_metering_3, col="blue", type="l")
        legend("topright", lty=1, bty="n", title.adj=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        # bottom right 
        plot(xs$Date+xs$Time, xs$Global_reactive_power, type="n", ylab="Global_reactive_power", xlab ="datetime")
        points(xs$Date+xs$Time, xs$Global_reactive_power, type="l")
        
        # close the png
        dev.off()
}