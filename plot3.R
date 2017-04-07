# ============================================================================================
# File: plot3.R
# ============================================================================================
# Reference: UC Irvine Machine Learning Repository,
# Dataset  : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Title    : Individual household electric power consumption Data Set

# Variables:
# - Date: Date in format dd/mm/yyyy
# - Time: time in format hh:mm:ss
# - Global_active_power: household global minute-averaged active power (in kilowatt)
# - Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# - Voltage: minute-averaged voltage (in volt)
# - Global_intensity: household global minute-averaged current intensity (in ampere)
# - Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# - Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# - Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


# ============================================================================================
# 1. Loading Data
# ============================================================================================

# Download File if does not exists
filename <- "household_power_consumption.zip"
if (!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile=filename)
}

# Extract and load data into memmory
data <- subset(
  read.csv( unz("household_power_consumption.zip","household_power_consumption.txt"),
            header     = TRUE,
            sep        = ";",
            dec        = ".",
            na.strings = c("?")),
  Date == "1/2/2007" | Date == "2/2/2007")


# ============================================================================================
# 2. Data Conversion
# ============================================================================================

# Date and Time conversion
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data$Time <- strptime( paste(data$Date, data$Time, sep=" "), format="%Y-%m-%d %H:%M:%S" )


# ============================================================================================
# 3. Processing / Results
# ============================================================================================

# Set parameters to create .png file
png(filename="plot3.png", width=480, height=480)

# Plot
plot(x    = data$Time,
     y    = data$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

points(data$Time, data$Sub_metering_1, col="black", type = "l")
points(data$Time, data$Sub_metering_2, col="red",   type = "l")
points(data$Time, data$Sub_metering_3, col="blue",  type = "l")

legend("topright",
       lty    = c(1,1),
       col    = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

# Close the device and save the file
dev.off()