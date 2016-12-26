library(data.table); library(dplyr)
setwd("C:/Users/Philippe/Documents/DataScience")


fileName <- "household_power_consumption.txt"

#declare dates used to calculate rows needed 
date1 <- as.POSIXct("2006-12-16 17:24:00")
date2 <- as.POSIXct("2007-02-01 00:00:00")
date3 <- as.POSIXct("2007-02-03 00:00:00")

skipRows <- abs(as.numeric(difftime(date1, date2, unit="mins")))
getRows <- abs(as.numeric(difftime(date2,date3, units="mins")))


#read in only rows in the desired date range
power <- read.table(fileName, sep=";", header= TRUE, 
                    stringsAsFactors = FALSE, skip = skipRows + 1, nrows = getRows)
names(power) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity",
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#combine dates and time and convert to POSIXct
power <- power %>% mutate(datetime = paste(date, time), 
                          datetime = as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")) 

#output plot as a png file
png("plot3.png", width = 480, height= 480, units="px")

plot(Sub_metering_1 ~ datetime, data = power, type = "l", xlab="", ylab = "Energy sub metering")
par(new=TRUE)

lines(Sub_metering_2 ~ datetime, data = power, col="red", type = "l", xlab="", ylab="")
par(new=TRUE)

lines(Sub_metering_3 ~ datetime, data = power, col="blue", type = "l", xlab="", ylab="")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty =c(1,1), col=c("black", "red", "blue"))

dev.off()
