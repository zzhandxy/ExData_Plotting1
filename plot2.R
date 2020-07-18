### load the packages used in this assignment
Sys.setlocale("LC_TIME", "English")
library(dplyr)
library(lubridate)

### download the original data

if(!file.exists("./week1")) dir.create("./week1")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, "./week1/data.zip")
data_unzip <- unzip("./week1/data.zip", exdir = "./week1")

### load the original data  

ori_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

### data processing

ori_data$Date <- dmy(ori_data$Date)
date <- c(ymd("2007-02-01"), ymd("2007-02-02"))
data <- filter(ori_data, ori_data$Date %in% date)
data <- mutate(data, date_time = paste(as.character(data$Date), data$Time))
data$date_time <- ymd_hms(data$date_time)
data <- data[,-c(1,2)]
start <- data$date_time[1]
end <- data$date_time[nrow(data)]
diff <- as.numeric(difftime(end, start, units= "mins")) 

### plot the figure "plot2.png"

png(file = "plot2.png", width = 480, height = 480)
x <- 0:diff
plot(x, data$Global_active_power, type = "n", xaxt="n", xlab = " ", ylab = "Global Acitive Power (kilowatts)")
lines(x, data$Global_active_power, axis=FALSE)
axis(1, at=c(0,round(0.5*length(x)),length(x)),labels=c("Thu", "Fri", "Sat"))
dev.off()

