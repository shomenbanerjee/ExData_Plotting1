plot4 <- function() {
       
       install.packages("downloader")
       library(downloader)
       
       #Load file location       
       
       url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
       
       download(url, dest="exdata_data_household_power_consumption.zip", mode="wb")
       
       unzip ("exdata_data_household_power_consumption.zip", exdir = "./exdata_data_household_power_consumption")       
       file <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
       
       
       #Read file into a data frame, read the headers using ';' as sep
       #and tag '? as NA
       epc <- read.table(file, sep=";", header=TRUE, na.strings="?")
       
       
       #Convert the date column into date field
       epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
       
       
       #Filter off data set for dates within 2007-02-01 to 2007-02-02
       epc <- subset(epc, epc$Date <= "2007-02-02" & epc$Date >= "2007-02-01")
       
       
       #Remove NA rows
       epc <- subset(epc, !is.na(epc))
       
       
       #Concatenate date & time into new variable
       epc$DateTime <- paste(epc$Date, epc$Time)
       
       
       #Convert DateTime into a date/time format
       epc$DateTime <- strptime(epc$DateTime, format="%Y-%m-%d %H:%M:%S")
       
       
       #Remove Date and Time columns
       epc$Date <- NULL      
       epc$Time <- NULL
       
       
       #Draw plot4 diagram 1..................
       png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
       
       par(mfrow = c(2,2))
       
       
       plot(x = epc$DateTime, 
            y = epc$Global_active_power,             
            type = "n",            
            ylab = "Global Active Power", 
            xlab = "")       
       
       lines(x = epc$DateTime, 
             y = epc$Global_active_power, 
             col = "black")
       
       
       #Draw plot4 diagram 2...................
       
       plot(x = epc$DateTime, 
            y = epc$Voltage,             
            type = "n",            
            ylab = "Voltage", 
            xlab = "datetime")       
       
       lines(x = epc$DateTime, 
             y = epc$Voltage, 
             col = "black")
       
       
       #Draw the plot for plot4 diagram 3
       
       plot(x = epc$DateTime, 
            y = epc$Sub_metering_1,             
            type = "n",                    
            ylab = "Energy sub metering", 
            xlab = "")       
       
       lines(x = epc$DateTime, 
             y = epc$Sub_metering_1, 
             col = "black")
       
       lines(x = epc$DateTime, 
             y = epc$Sub_metering_2, 
             col = "red")
       
       lines(x = epc$DateTime, 
             y = epc$Sub_metering_3, 
             col = "blue")
       
       legend("topright",
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
              col = c("black", "red", "blue"),
              lty=1)
       
       
       #Draw plot4 diagram 4...............
       
              
       plot(x = epc$DateTime, 
            y = epc$Global_reactive_power,             
            type = "n",            
            ylab = "Global_reactive_Power", 
            xlab = "datetime")       
       
       lines(x = epc$DateTime, 
             y = epc$Global_reactive_power, 
             col = "black")
       
       junkMsg <- dev.off()
       
       
}