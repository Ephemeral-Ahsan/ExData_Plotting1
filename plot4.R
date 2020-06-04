# Load data into memort
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Subsetting data with only from the dates 2007-02-01 and 2007-02-02
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Change the date and time to Date/Time class
DateTimeString <- paste(data[["Date"]], data[["Time"]])
DateTime <- strptime(DateTimeString, format = "%d/%m/%Y %H:%M:%S")
Data <- cbind(DateTime, data[,3:9])

# Convert the required columns to numeric
Data[,2:7] <- sapply(Data[,2:7], as.numeric)

# Configure the plotting canvas
par(mfcol=c(2,2), oma=c(0,0,0,0), mar= c(4,4,2,1), cex=0.7)

# Plot the lineplot
plot(Data$DateTime, as.numeric(Data$Global_active_power), type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

plot(Data$DateTime, Data$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
points(Data$DateTime, Data$Sub_metering_2, type="l", col="red")
points(Data$DateTime, Data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1, bty = "n")

with(Data, plot(DateTime, Voltage, type="l", xlab="datetime"))

with(Data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))


# Save the plot
dev.copy(png, "plot4.png")
dev.off()