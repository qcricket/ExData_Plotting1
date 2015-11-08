## Course Project 1
## Generate Figure 4
##
## Read in data file
df <- read.table("household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = "?")

## Select only date and sub_metering #1-3 columns
dfFig4 <- select(df, Date, Time, Global_active_power, 
                 Voltage, 
                 Sub_metering_1, Sub_metering_2, Sub_metering_3,
                 Global_reactive_power)
dfFig4 <- filter(dfFig4, Date == "2/1/2007" | Date == "2/2/2007")

## Convert date/time to numeric format
dates <- as.character(dfFig4$Date)
times <- as.character(dfFig4$Time)
x <- paste(dates, times)
x2 <- parse_date_time(x,"%m%d%Y %H%M%S", truncated = 3)
wDay <- wday(x2, label =TRUE)

## Remove NA values
sm1 <- na.omit(dfFig3$Sub_metering_1)
sm2 <- na.omit(dfFig3$Sub_metering_2)
sm3 <- na.omit(dfFig3$Sub_metering_3)

## Generate Figure 4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(dfFig4, {
        plot(x2, dfFig4$Global_active_power, 
             ylab = "Global Active Power (kilowatts)",
             xlab = "", type = "l")
        plot(x2, dfFig4$Voltage,
             ylab = "Voltage",
             xlab = "datetime", type = "l")
        plot(x2, sm3, type = "n",
             ylab = "Energy sub metering",
             xlab = "",
             ylim = c(0,40))
             lines(x2, sm1, col = "black")
             lines(x2, sm2, col = "red")
             lines(x2, sm3, col = "blue")
             leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
             legend(legend = leg.txt, "topright", lty = 1, col = c("black", "red", "blue"))
        plot(x2, dfFig4$Global_reactive_power,
             ylab = "Global_reactive_power",
             xlab = "datetime", type = "l")
})

dev.off()