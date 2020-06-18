# Read data
f <- "household_power_consumption.txt"
colC <- c("character", "character", rep("numeric", 7))
dat <- read.table(f, header = TRUE, sep = ";", as.is = TRUE ,na.strings = "?")

# Create new column with date/time as POSIXct
dat$DateTime <- as.POSIXct(strptime(paste(dat$Date, dat$Time),
                                    "%d/%m/%Y %H:%M:%S"))

# Change date to Date class and all readings to class 'numeric'
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
for(i in 3:9) {dat[, i] <- as.numeric(dat[, i])}



# Subset the data
dates <- as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
dat <- subset(dat, Date == dates)




# Generate and save plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")

par(mar = c(2, 4, 4, 2)) # Set up plot
plot(dat$DateTime, dat$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = "n") # Plot parameters
points(dat$DateTime, dat$Sub_metering_1, type = "l", col = "black") # Add 1
points(dat$DateTime, dat$Sub_metering_2, type = "l", col = "red") # Add 2
points(dat$DateTime, dat$Sub_metering_3, type = "l", col = "blue") # Add 3
legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) # Legend

dev.off()