## script to generate Global Active Power histogram

library(sqldf)

infilename <- "household_power_consumption.txt"
outfilename <- "plot1.png"

## get the subset we want to analyze
sqlcmd <- "select * from file where Date in ('1/2/2007','2/2/2007')"
pdata <- read.csv2.sql(infilename,sql=sqlcmd,colClasses=c(rep("character",2),rep("numeric",7)))

## save the graph in a png file
png(file=outfilename)
hist(pdata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)"
     ,ylab="Frequency",main="Global Active Power",ylim=c(0,1200))
dev.off()
