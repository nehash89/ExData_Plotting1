# Downloading File in R ---------------------------------------------------


temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
con <- unz(temp, "household_power_consumption.txt")
Rawdata <- read.csv(con, sep=";", na.strings = "?", stringsAsFactors = FALSE)

# Re-formating Data -------------------------------------------------------
Rawdata$Global_active_power <- as.numeric(Rawdata$Global_active_power)
Rawdata$Global_reactive_power<- as.numeric(Rawdata$Global_reactive_power)
Rawdata$Voltage <- as.numeric(Rawdata$Voltage)
Rawdata$Global_intensity <- as.numeric(Rawdata$Global_intensity)
Rawdata$Sub_metering_1<- as.numeric(Rawdata$Sub_metering_1)
Rawdata$Sub_metering_2<- as.numeric(Rawdata$Sub_metering_2)
Rawdata$Sub_metering_3<- as.numeric(Rawdata$Sub_metering_3)
Rawdata$Date <- as.Date(Rawdata$Date, "%d/%m/%Y")
Rawdata$DateTime <- paste(Rawdata$Date, Rawdata$Time, sep = " ")
Rawdata$DateTime <- strptime(Rawdata$DateTime, "%Y-%m-%d %H:%M:%S")
temp_dat <- subset(Rawdata, Rawdata$DateTime >= "2007-02-01" )
final <- subset(temp_dat, temp_dat$DateTime < "2007-02-03")

# PLOTTING ----------------------------------------------------------------


png(file = "plot4.png")

par(mfrow = c(2,2))

# Plot 1 ------------------------------------------------------------------
plot(final$DateTime, final$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power(kilowatts)")

# Plot 2 ------------------------------------------------------------------

plot(final$DateTime, final$Voltage, type = "l", xlab = "datetime" , ylab = "Voltage")

# Plot 3 ------------------------------------------------------------------

plot(final$DateTime, final$Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering")

lines(final$DateTime, final$Sub_metering_2, col = "red")

lines(final$DateTime, final$Sub_metering_3, col = "blue")

legend(x = "topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), col = c("black","red","blue"), lty = 1 )

# Plot 4 ------------------------------------------------------------------

plot(final$DateTime, final$Global_reactive_power, type = "l", xlab = "datetime" , ylab = "Global_reactive_power")

# Dev Off -----------------------------------------------------------------


dev.off()
