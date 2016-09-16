

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
data_used[,7]<-gsub("?",NA,data_used[,7],fixed=TRUE)
data_used[,8]<-gsub("?",NA,data_used[,8],fixed=TRUE)
data_used[,9]<-gsub("?",NA,data_used[,9],fixed=TRUE)

#turn numeric
data_used[,7]<-as.numeric(data_used[,7])
data_used[,8]<-as.numeric(data_used[,8])
data_used[,9]<-as.numeric(data_used[,9])


# get week days
data_used[,1] <- gsub("1/2/2007","2007-02-01",data_used[,1])
data_used[,1] <- gsub("2/2/2007","2007-02-02",data_used[,1])
data_used$daytime <- as.POSIXct(paste(data_used[,1],data_used[,2]))

#plot and save as png
library(datasets)
windows(10,10)
par(bg="white")
plot(x=data_used$daytime, y=data_used[,7],type="l",ylab="Energy sub metering",xlab="",ylim=c(0,38))
par(new=TRUE)
plot(x=data_used$daytime, y=data_used[,8],type="l",col="red",ylab="Energy sub metering",xlab="",ylim=c(0,38))
par(new=TRUE)
plot(x=data_used$daytime, y=data_used[,9],type="l",col="blue",ylab="Energy sub metering",xlab="",ylim=c(0,38))
legend("topright", lwd=1, col = c("black","red","blue"), legend = c("Sub_metering_1  ", "Sub_metering_2  ","Sub_metering_3  "))

dev.copy(png, file = "Plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!


     


     
     