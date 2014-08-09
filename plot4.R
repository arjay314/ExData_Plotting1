## script to generate a set of 4 graphs:
##   1) Global Active Power
##   2) Energy Sub Metering
##   3) Voltage
##   4) Global Reactive Power

library(sqldf)

infilename <- "household_power_consumption.txt"
outfilename <- "plot4.png"

## get the subset we want to analyze
sqlcmd <- "select * from file where Date in ('1/2/2007','2/2/2007')"
pdata <- read.csv2.sql(infilename,sql=sqlcmd,colClasses=c(rep("character",2),rep("numeric",7)))

## reformat the date and time, for use in plots
temp <- paste(pdata$Date,pdata$Time)
x <- strptime(temp,"%d/%m/%Y %H:%M:%S")

## save current graphics parms
opar <- par(no.readonly=TRUE)

## save the graph in a png file
png(file=outfilename)

## display graphs 2 X 2, load column major
par(mfcol=c(2,2))

## graph(1,1)
plot(x,pdata$Global_active_power,type="l",xlab="",ylab="Global Active Power")

## graph(2,1)
plot(x,pdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(x,pdata$Sub_metering_2,type="l",col="red")
lines(x,pdata$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

## graph(1,2)
plot(x,pdata$Voltage,type="l",xlab="datetime",ylab="Voltage")

## graph(2,2)
plot(x,pdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()

## restore graphics parms
par(opar)


