##  Load packages

library(lubridate)
library(dplyr)

##  Read data 

full_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

##  Subset and format the data needed

full_data$Date <- dmy(full_data$Date)
data <- full_data %>%
        filter(year(full_data$Date) == 2007, month(full_data$Date) == 02, day(full_data$Date) == 01 | day(full_data$Date) == 02) %>%
        mutate(datetime = paste(Date, Time)) %>%
        select(datetime, Global_active_power:Sub_metering_3)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")

## Plot energy sub metering

png("plot3.png")
with(data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()