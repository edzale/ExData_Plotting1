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

##Converting the Global Actice Power column's type
library(dplyr)
mydataframe<-mutate(mydataframe, Global_active_power=as.numeric(Global_active_power))

##Opening a png device
png(file="plot1.png") 
##histogram
hist(mydataframe$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
##Closing the png device
dev.off
