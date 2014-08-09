## script to generate Global Active Power line graph

library(sqldf)

infilename <- "household_power_consumption.txt"
outfilename <- "plot2.png"

## get the subset we want to analyze
sqlcmd <- "select * from file where Date in ('1/2/2007','2/2/2007')"
pdata <- read.csv2.sql(infilename,sql=sqlcmd,colClasses=c(rep("character",2),rep("numeric",7)))

## reformat the date and time, for use in plot
temp <- paste(pdata$Date,pdata$Time)
x <- strptime(temp,"%d/%m/%Y %H:%M:%S")

## save the graph in a png file
png(file=outfilename)
plot(x,pdata$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
