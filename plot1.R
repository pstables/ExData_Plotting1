#Check if data has been downloaded and if not download and unzip
if (!file.exists("data.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip", method = "curl")
        unzip ("data.zip", exdir = "./")
}

# Read file into data and convert Date and Times
data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE) 
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format ="%H:%M:%S")


# Open png graphics device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot histogram of Global_active_power for 1st and 2nd of Feb 07
hist(data$Global_active_power[data$Date == "2007-02-01" | data$Date == "2007-02-02"], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

# Close graphics device to create file
dev.off()