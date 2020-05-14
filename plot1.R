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

## Plot histogram 'Global Active Power': Global Active Power (kilowatts) vs. Frequency
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels

png("plot1.png")                #default dimension 480 x 480
with(data, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()