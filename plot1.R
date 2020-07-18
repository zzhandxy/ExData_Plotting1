### load the packages used in this assignment

library(dplyr)
library(lubridate)

### download the original data

if(!file.exists("./week1")) dir.create("./week1")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, "./week1/data.zip")
data_unzip <- unzip("./week1/data.zip", exdir = "./week1")

### load the original data  

ori_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

### use 'filter' function to select the subset

ori_data$Date <- dmy(ori_data$Date)
date <- c(ymd("2007-02-01"), ymd("2007-02-02"))
data <- filter(ori_data, ori_data$Date %in% date)

### plot the figure "plot1.png"

png(file = "plot1.png", width = 480, height = 480)
hist(as.numeric(data$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

