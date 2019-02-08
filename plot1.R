##Load dplyr
library(dplyr)

##Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
household_power <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

##Filter by dates
household_power_dates<-filter(household_power, Date == "1/2/2007" | Date == "2/2/2007")

##Build plot using base package
png("plot1.png", width = 480, height = 480)
hist(household_power_dates$Global_active_power, breaks = 11, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()