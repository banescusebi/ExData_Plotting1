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

## Unite Data and Time variables into datetime variable.
uci = unite(uci, "datetime", Date, Time, sep=" ")

## Convert datetime variable from chr to POSIXlt. 
uci$datetime = strptime(uci$datetime, format="%d/%m/%Y %H:%M:%S")

## Open png device having both width and height equal to 480 pixels.
png("plot4.png", width = 480, height = 480)

## Set 2x2 matrix layout for plot device
par(mfcol = c(2,2))

## Top-left plot: scatter plot of datetime versus 
## Global_active_power as a line.
plot(uci$datetime, uci$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

## Bottom-left plot in follwing 4 R commands:
## Create scatter plot of datetime versus Sub_metering_1 as a line.
plot(uci$datetime, uci$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

## Add red line for datetime versus Sub_metering_2
lines(uci$datetime, uci$Sub_metering_2, col = "red")

## Add blue line for datetime versus Sub_metering_3
lines(uci$datetime, uci$Sub_metering_3, col = "blue")

## Add legend to top-right corner of plot 
legend("topright", 
       lty = c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

## Top-right plot: Scatter plot of datetime versus Voltage as a line.
with(uci, plot(datetime, Voltage, type = "l"))

## Bottom-right plot: Scatter plot of datetime versus Global_reactive_power.
with(uci, plot(datetime, Global_reactive_power, type = "l"))

## Close png device.
dev.off()
