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

png(filename = "plot3.png")

plot(household$Sub_metering_1 ~ household$DateTime, xaxt = "n", type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", col = "black")
lines(household$Sub_metering_2 ~ household$DateTime, col = "red")
lines(household$Sub_metering_3 ~ household$DateTime, col = "blue")
axis(1, at = as.POSIXct(as.Date(axisValues)) , format(axisValues, "%a"))
legend(x = "topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1))

dev.off()