

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

# check that there are no ? 
index3 <- data_used[,3] == "?"
sum(index3)

#turn numeric
data_used$Global_active_power <- as.numeric(as.character(data_used$Global_active_power))

# get week days
data_used[,1] <- gsub("1/2/2007","2007-02-01",data_used[,1])
data_used[,1] <- gsub("2/2/2007","2007-02-02",data_used[,1])
data_used$daytime <- as.POSIXct(paste(data_used[,1],data_used[,2]))

#plot and save as png
library(datasets)
plot(x=data_used$daytime, y=data_used$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png, file = "Plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!


     


     
     