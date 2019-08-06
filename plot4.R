## Get data
myfile <- "household_power_consumption.txt"
myzip <- "household_power_consumption.zip"
myurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (! file.exists(myfile)){
    print("Downloading data ..." )
    download.file(myurl,myzip,method="curl")
    unzip(myzip)
    print("... done!")
}
                  
## Read data

hpc <- read.table(myfile,header=TRUE,sep=";",na.strings="?", stringsAsFactors=FALSE)
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")

## Only February 1st and 2nd of 2007
hpc <- subset(hpc,Date=="2007-02-01" | Date=="2007-02-02")

## Generate Plot 2 

## Combine date and time for x-Axis 
datetime <- as.POSIXct(paste(hpc$Date,hpc$Time))



png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
## Left top plot
plot(datetime,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power")

## Right top plot
plot(datetime,hpc$Voltage,type="l",xlab="datetime",ylab="Voltage")

## Left botom plot
plot(datetime ,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="",type="n")
lines(datetime,hpc$Sub_metering_1,type="l",col="black")
lines(datetime,hpc$Sub_metering_2,type="l",col="red")
lines(datetime,hpc$Sub_metering_3,type="l",col="blue")
lnames <- names(hpc)[7:9]
legend("topright",
       legend=lnames,
       col=c("black","red","blue"),
       lwd=c(1,1,1),
       bty="n")

## Right bottom plot 
plot(datetime,hpc$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
