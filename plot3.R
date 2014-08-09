## script to generate Energy Sub Metering line graph

library(sqldf)

infilename <- "household_power_consumption.txt"
outfilename <- "plot3.png"

## get the subset we want to analyze
sqlcmd <- "select * from file where Date in ('1/2/2007','2/2/2007')"
pdata <- read.csv2.sql(infilename,sql=sqlcmd,colClasses=c(rep("character",2),rep("numeric",7)))

## reformat the date and time, for use in plot
temp <- paste(pdata$Date,pdata$Time)
x <- strptime(temp,"%d/%m/%Y %H:%M:%S")

## save the graph in a png file
png(file=outfilename)
plot(x,pdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(x,pdata$Sub_metering_2,type="l",col="red")
lines(x,pdata$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()
