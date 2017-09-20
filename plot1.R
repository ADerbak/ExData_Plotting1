#Bring in required packages
require(readr)
require(lubridate)

#Set Working Directory and read in file
setwd("~\\R\\Power Consumption")
file <- fread("household_power_consumption.txt",
              sep = ";",
              header = TRUE,
              colClasses = rep("character",9))

#Clean up data by adding in NA's and chaning data to date/numeric classes
file[file == "?"] <- NA
file$Date <- as.Date(file$Date, format = '%d/%m/%Y')
file$Global_active_power <- as.numeric(file$Global_active_power)

# Filter the file to the selected dates
file <- file[(file$Date == as.Date("2007-02-01")) | (file$Date == as.Date("2007-02-02")),]



# Create Plot 1
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(file$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()  # Close the png file device



