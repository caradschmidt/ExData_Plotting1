##Load dplyr
library(dplyr)
library(tidyr)

##Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
household_power <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

##Filter by dates
household_power_weekday<-filter(household_power, Date == "1/2/2007" | Date == "2/2/2007")

##Unite Date and Time variables
household_power_weekday1<-unite(household_power_weekday, "DateTime", c("Date", "Time"), sep = " ")
household_power_weekday2<-mutate(household_power_weekday1, DateTime = as.POSIXct(household_power_weekday1$DateTime, "%d/%m/%Y %H:%M:%S", tz = "Europe/Paris"))

##Set 2 rows and 2 columns of graphs parameter
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

##Add plot 1
plot(household_power_weekday2$DateTime, household_power_weekday2$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")

##Add plot 2
plot(household_power_weekday2$DateTime, household_power_weekday2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##Add plot 3
plot(household_power_weekday2$DateTime, household_power_weekday2$Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub metering")
lines(household_power_weekday2$DateTime, household_power_weekday2$Sub_metering_1, type = "l")
lines(household_power_weekday2$DateTime, household_power_weekday2$Sub_metering_2, type = "l", col = "red")
lines(household_power_weekday2$DateTime, household_power_weekday2$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#Add plot 4
plot(household_power_weekday2$DateTime, household_power_weekday2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
