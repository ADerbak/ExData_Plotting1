#Bring in required packages
require(readr)
require(lubridate)
require(data.table)

#Set Working Directory and read in file
setwd("~\\R\\Power Consumption")
file <- fread("household_power_consumption.txt",
              sep = ";",
              header = TRUE,
              colClasses = rep("character",9),
              stringsAsFactors = FALSE,
              dec = ".")

#Clean up data by adding in NA's and chaning data to date/numeric classes
file[file == "?"] <- NA
file$Date <- as.Date(file$Date, format = '%d/%m/%Y')
file$Global_active_power <- as.numeric(file$Global_active_power)

# Filter the file to the selected dates
file <- file[(file$Date == as.Date("2007-02-01")) | (file$Date == as.Date("2007-02-02")),]

#Convert date and time to one UTC field
datetime <- ymd_hms(paste(file$Date, file$Time, sep=" "))

# Create Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
## Position 1 (top-left)
plot(datetime, file$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Position 2 (top-right)
plot(datetime, file$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Position 3 (bottom-left)
plot(datetime, file$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(datetime, file$Sub_metering_2, col = "red")
lines(datetime, file$Sub_metering_3, col = "blue")
# Remove the border of legend
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Position 4 (bottom-right)
plot(datetime, file$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime",
     ylab = "Global_Reactive_Power")
dev.off()