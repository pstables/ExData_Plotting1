#Check if data has been downloaded and if not download and unzip
if (!file.exists("data.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip", method = "curl")
        unzip ("data.zip", exdir = "./")
}

# Read file into data and convert Date and Times
data_download <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE) 
data <- data_download[(data_download$Date == "1/2/2007" | data_download$Date == "2/2/2007"),]
dateTime <- paste(as.Date(data$Date, format="%d/%m/%Y"),data$Time)
data$DateTime <- as.POSIXct(dateTime)

# Open png graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

# Create plots
plot( data$Global_active_power~data$DateTime, type = "l",ylab="Global Active Power (kilowatts)", xlab="")

plot( data$Voltage~data$DateTime, type = "l",ylab="Voltage", xlab="")

plot(data$DateTime,data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" , col = "black")
lines(data$Sub_metering_2~data$DateTime, type = "l", col="red")
lines(data$Sub_metering_3~data$DateTime, type = "l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

plot( data$Global_reactive_power~data$DateTime, type = "l",ylab="Global_reactive_power", xlab="")

# Close graphics device to create file
dev.off()