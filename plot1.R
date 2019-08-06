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


## Generate Plot 1 
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(hpc$Global_active_power,col="red",breaks=12,
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.off()



