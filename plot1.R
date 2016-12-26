library(data.table)
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
power <- data.table(power)
names(power) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity",
                  "submetering1", "submetering2", "submetering3")

#output plot as a png file
png("plot1.png", width = 480, height= 480, units="px")
hist(power$globalactivepower, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()

