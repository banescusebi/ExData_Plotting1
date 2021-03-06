## This R script was written as part of the "Peer Graded Assignment: Course 
## Project 1" from the "Exploratory Data Analysis" course on Coursera. 
##
## author: Sebastian Banescu

library(sqldf)
library(tidyr)

## Load subset of UCI dataset from 1st and 2nd February 2007.
uci = read.csv2.sql("household_power_consumption.txt",
                   sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' OR Date == '2/2/2007'")
closeAllConnections()

## Unite Data and Time variables into DateTime variable.
uci = unite(uci, "DateTime", Date, Time, sep=" ")

## Convert DateTime variable from chr to POSIXlt. 
uci$DateTime = strptime(uci$DateTime, format="%d/%m/%Y %H:%M:%S")

## Open png device having both width and height equal to 480 pixels.
png("plot3.png", width = 480, height = 480)

## Create scatter plot of DateTime versus Sub_metering_1 as a line.
plot(uci$DateTime, uci$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

## Add red line for DateTime versus Sub_metering_2
lines(uci$DateTime, uci$Sub_metering_2, col = "red")

## Add blue line for DateTime versus Sub_metering_3
lines(uci$DateTime, uci$Sub_metering_3, col = "blue")

## Add legend to top-right corner of plot 
legend("topright", 
       lty = c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close png device.
dev.off()
