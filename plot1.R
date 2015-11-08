## Course Project 1
## Generate Figure 1
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
dfFig1 <- select(df, Date, Global_active_power)
dfFig1 <- filter(dfFig1, Date == "2/1/2007" | Date == "2/2/2007")

## Generate Figure 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(dfFig1$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "Red", freq = TRUE, 
     main = "Global Active Power", 
     xaxp = c(0,6,3), yaxp = c(0,1200,6), 
     xpd = NA)
dev.off()
