zipFileName = "household_power_consumption.zip"

if(!file.exists(zipFileName)) {
    zipFileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(zipFileUrl, zipFileName)
}

fileName = "household_power_consumption.txt"

if (!file.exists(fileName)) {
    unzip(zipFileName) 
}
household <- read.table(fileName, sep = ";", na.strings= "?", header = TRUE)
household = subset(household, as.character(household$Date) %in% c("1/2/2007", "2/2/2007"))
household$DateTime <- as.POSIXct(paste(household$Date, household$Time), format="%d/%m/%Y %H:%M:%S")

axisValues <- append(household$DateTime, as.POSIXct("3/2/2007 00:00:00", format="%d/%m/%Y %H:%M:%S"))

png(filename = "plot1.png")
hist(household$Global_active_power, freq = TRUE, breaks = 15, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

dev.off()