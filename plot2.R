plot2 <- function() {
       
       
       install.packages("downloader")
       library(downloader)
       
       #Load file location       
       
       url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
       
       download(url, dest="exdata_data_household_power_consumption.zip", mode="wb")
       
       unzip ("exdata_data_household_power_consumption.zip", exdir = "./exdata_data_household_power_consumption")
       
       ##Machine learning repo - http://archive.ics.uci.edu/ml/
       
       #Load file location       
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
       epc$Global_reactive_power <- NULL
       epc$Voltage <- NULL
       epc$Global_intensity <- NULL
       epc$Sub_metering_1 <- NULL
       epc$Sub_metering_2 <- NULL
       epc$Sub_metering_3 <- NULL
       
       
       #Draw the plot for plot2.png
       png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
       
       
       
       plot(x = epc$DateTime, 
            y = epc$Global_active_power,             
            type = "n",            
            ylab = "Global Active Power (kilowatts)", 
            xlab = "")       
       
       lines(x = epc$DateTime, 
             y = epc$Global_active_power, 
             col = "black")
       
       junkMsg <- dev.off()
       
       
}