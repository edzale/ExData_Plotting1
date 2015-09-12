##---------------------------------------##
## Download and unzip the dataset archive##
##---------------------------------------##
if (!exists("household_power_consumption.txt")){
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, 'Dataset.zip')
  unzip('Dataset.zip')
}
##Reading the data from the file
data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE);

##Subsetting the data
my_subset<-data[grepl("^[1-2]/2/2007", data$Date), ]
mydataframe <- as.data.frame(my_subset)
colnames(mydataframe)<-strsplit(colnames(data), "\\.")

##Converting the types of the columns
library(dplyr)
mydataframe<-mutate(mydataframe, DateTime=paste(Date, Time, sep=" "))
mydataframe<-mutate(mydataframe, DateTime=as.POSIXct(DateTime, format="%d/%m/%Y%H:%M:%S"))
mydataframe<-mutate(mydataframe, Sub_metering_1=as.numeric(Sub_metering_1))
mydataframe<-mutate(mydataframe, Sub_metering_2=as.numeric(Sub_metering_2))
mydataframe<-mutate(mydataframe, Global_reactive_power=as.numeric(Global_reactive_power))
mydataframe<-mutate(mydataframe, Voltage=as.numeric(Voltage))


##Opening a png device
png(file="plot4.png") 
##Plotting
par(mfrow = c(2,2))
with(mydataframe, {
  plot(DateTime, Global_active_power, pch=20, type="l", xlab="", ylab="Global Active Power")
  plot(DateTime, Voltage, pch=20, type="l", xlab="", ylab="Voltage")

  with(mydataframe, {
    plot(DateTime, Sub_metering_1, pch=20, type="n", xlab="", ylab="Energy sub metering")
    points(DateTime, Sub_metering_1, pch=20, type="l")
    points(DateTime, Sub_metering_2, pch=20, type="l", col="red")
    points(DateTime, Sub_metering_3, pch=20, type="l", col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering2", "Sub_metering_3"))
  })
  plot(DateTime, Global_reactive_power, pch=20, type="l", xlab="", ylab="Global Reactive Power")
})
##Closing the png device
dev.off()