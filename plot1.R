# Read data
f <- "household_power_consumption.txt"
colC <- c("character", "character", rep("numeric", 7))
dat <- read.table(f, header = TRUE, sep = ";", as.is = TRUE ,na.strings = "?")

# Change date to Date class and all readings to class 'numeric'
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
for(i in 3:9) {dat[, i] <- as.numeric(dat[, i])}

# Subset the data
dates <- as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
dat <- subset(dat, Date == dates)

# Generate and save plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(dat$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     xlim = c(0,6))
dev.off()