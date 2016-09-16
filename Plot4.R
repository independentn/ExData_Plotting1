

## check wd is correct and read table
getwd()
exdata1 <- read.table("household_power_consumption.txt",sep=";",header=TRUE)

# check names and that everything came in alright
names(exdata1)
head(exdata1)
str(exdata1)

# get data for the 2 dates needed 
index1 <- exdata1[,1] == "1/2/2007"
index2 <- exdata1[,1] == "2/2/2007"

data_used1 <- exdata1[index1,]
data_used2<- exdata1[index2,]

data_used <- rbind(data_used1,data_used2)
str(data_used)

# check that there are no ? , if any replace with NA
data_used[,3]<-gsub("?",NA,data_used[,3],fixed=TRUE)
data_used[,4]<-gsub("?",NA,data_used[,4],fixed=TRUE)
data_used[,5]<-gsub("?",NA,data_used[,5],fixed=TRUE)
data_used[,7]<-gsub("?",NA,data_used[,7],fixed=TRUE)
data_used[,8]<-gsub("?",NA,data_used[,8],fixed=TRUE)
data_used[,9]<-gsub("?",NA,data_used[,9],fixed=TRUE)

#turn numeric
data_used[,3]<-as.numeric(data_used[,3])
data_used[,4]<-as.numeric(data_used[,4])
data_used[,5]<-as.numeric(data_used[,5])
data_used[,7]<-as.numeric(data_used[,7])
data_used[,8]<-as.numeric(data_used[,8])
data_used[,9]<-as.numeric(data_used[,9])


# get week days
data_used[,1] <- gsub("1/2/2007","2007-02-01",data_used[,1])
data_used[,1] <- gsub("2/2/2007","2007-02-02",data_used[,1])
data_used$daytime <- as.POSIXct(paste(data_used[,1],data_used[,2]))

#plot and save as png
library(datasets)

# open window
windows(10,10)

# set matrix dim for plot area
par(mfrow = c(2, 2))
#plot up left
plot(x=data_used$daytime,y=data_used[,3],type="l",ylab="Global Active Power",xlab="")

#pot upright
plot(x=data_used$daytime,y=data_used[,5],type="l",ylab="Voltage",xlab="daytime")

#plot bottom left
plot(x=data_used$daytime, y=data_used[,7],type="l",ylab="Energy sub metering",xlab="",ylim=c(0,38))
par(new=TRUE)
plot(x=data_used$daytime, y=data_used[,8],type="l",col="red",ylab="Energy sub metering",xlab="",ylim=c(0,38))
par(new=TRUE)
plot(x=data_used$daytime, y=data_used[,9],type="l",col="blue",ylab="Energy sub metering",xlab="",ylim=c(0,38))
legend("topright", lwd=1,bty="n" ,col = c("black","red","blue"), legend = c("Sub_metering_1  ", "Sub_metering_2  ","Sub_metering_3  "))

#plot bottom right
plot(x=data_used$daytime,y=data_used[,4],type="l",ylab="Global_reactive_power",xlab="daytime")


dev.copy(png, file = "Plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!


     
     