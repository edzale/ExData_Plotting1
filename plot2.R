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
mydataframe<-mutate(mydataframe, Global_active_power=as.numeric(Global_active_power))


##Opening a png device
png(file="plot2.png") 
##Plotting
with(mydataframe, plot(DateTime, Global_active_power, pch=20, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
##Closing the png device
dev.off()
