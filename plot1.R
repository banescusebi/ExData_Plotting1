## This R script was written as part of the "Peer Graded Assignment: Course 
## Project 1" from the "Exploratory Data Analysis" course on Coursera. 
##
## author: Sebastian Banescu

library(sqldf)

## Load subset of UCI dataset from 1st and 2nd February 2007.
uci = read.csv2.sql("household_power_consumption.txt",
                   sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' OR Date == '2/2/2007'")
closeAllConnections()

## Open png device having both width and height equal to 480 pixels.
png("plot1.png", width = 480, height = 480)

## Plot histogram of Global_active_power variable.
hist(uci$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")

## Close png device.
dev.off()
