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


# Create Plot 2
png("plot2.png", width=480, height=480)
plot(datetime, Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()