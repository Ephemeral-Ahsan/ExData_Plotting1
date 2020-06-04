# Load data into memort
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Subsetting data with only from the dates 2007-02-01 and 2007-02-02
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Change the date and time to Date/Time class
DateTimeString <- paste(data[["Date"]], data[["Time"]])
DateTime <- strptime(DateTimeString, format = "%d/%m/%Y %H:%M:%S")
Data <- cbind(DateTime, data[,3:9])

# Plot the histogram
hist(as.numeric(Data$Global_active_power), xlab="Global Active Power (kilowatts)", col="red",
     main="Global Active Power")

# Save the plot
dev.copy(png, "plot1.png")
dev.off()