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

# Generate and save plot 2
png(filename = "plot2.png", width = 480, height = 480, units = "px")

with(dat, plot(DateTime, Global_active_power, type="l", ylim = c(0, 6),
               xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()