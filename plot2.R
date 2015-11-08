## Course Project 1
## Generate Figure 2
##
## Read in data file if it does not already exist
if(!file.exists("household_power_consumption.txt"))
{dir.create("household_power_consumption.txt")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile= "household_power_consumption.txt", method = "curl")
df <- read.table("household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = "?")

## Select only date and Global_active_power columns
dfFig2 <- select(df, Date, Time, Global_active_power)
dfFig2 <- filter(dfFig2, Date == "2/1/2007" | Date == "2/2/2007")

## Convert date/time to numeric format
dates <- as.character(dfFig2$Date)
times <- as.character(dfFig2$Time)
x <- paste(dates, times)
x2 <- parse_date_time(x,"%m%d%Y %H%M%S", truncated = 3)
wDay <- wday(x2, label =TRUE)

## Generate Figure 2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(x2, dfFig2$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",
     xlab = "", type = "l")
dev.off()