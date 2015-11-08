## Course Project 1
## Generate Figure 3
##
## Read in data file if it does not already exist
if(!file.exists("household_power_consumption.txt"))
{dir.create("household_power_consumption.txt")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile= "household_power_consumption.txt", method = "curl")
df <- read.table("household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = "?")

## Select only date and sub_metering #1-3 columns
dfFig3 <- select(df, Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
dfFig3 <- filter(dfFig3, Date == "2/1/2007" | Date == "2/2/2007")

## Convert date/time to numeric format
dates <- as.character(dfFig3$Date)
times <- as.character(dfFig3$Time)
x <- paste(dates, times)
x2 <- parse_date_time(x,"%m%d%Y %H%M%S", truncated = 3)
wDay <- wday(x2, label =TRUE)

## Remove NA values
sm1 <- na.omit(dfFig3$Sub_metering_1)
sm2 <- na.omit(dfFig3$Sub_metering_2)
sm3 <- na.omit(dfFig3$Sub_metering_3)

## Generate Figure 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(x2, sm3, type = "n",
     ylab = "Energy sub metering",
     xlab = "",
     ylim = c(0,40))

lines(x2, sm1, col = "black")
lines(x2, sm2, col = "red")
lines(x2, sm3, col = "blue")

leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(legend = leg.txt, "topright", lty = 1, col = c("black", "red", "blue"))
dev.off()