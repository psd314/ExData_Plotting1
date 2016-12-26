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
                  "submetering1", "submetering2", "submetering3")

#combine dates and time and convert to POSIXct
power <- power %>% mutate(datetime = paste(date, time), 
                          datetime = as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")) 

#output plot as a png file
png("plot2.png", width = 480, height= 480, units="px")
plot(globalactivepower ~ datetime, data = power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
par(new=TRUE)
dev.off()






