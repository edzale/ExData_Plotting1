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


##Opening a png device
png(file="plot3.png") 
##Plotting
with(mydataframe, plot(DateTime, Sub_metering_1, pch=20, type="n", xlab="", ylab="Energy sub metering"))
with(mydataframe, points(DateTime, Sub_metering_1, pch=20, type="l"))
with(mydataframe, points(DateTime, Sub_metering_2, pch=20, type="l", col="red"))
with(mydataframe, points(DateTime, Sub_metering_3, pch=20, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering2", "Sub_metering_3"))
##Closing the png device
dev.off()