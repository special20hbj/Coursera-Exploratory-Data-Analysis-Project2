## Question 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? ##
## Download and unzip the EPA file data from the website ##
setwd("~/Documents/Coursera/Exploratory Data Analysis/project 2")
getwd()
if(!file.exists("./NEIdata"))
        dir.create("./NEIdata")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "~/Documents/Coursera/Exploratory Data Analysis/project 2/NEI_data.zip", method = "curl")
unzip("/Users/HBJ/Documents/Coursera/Exploratory Data Analysis/project 2/NEI_data.zip", exdir = "~/Documents/Coursera/Exploratory Data Analysis/project 2/NEIdata")

## Read the NEI and SCC data frames from the .rds files ##
NEI <- readRDS("~/Documents/Coursera/Exploratory Data Analysis/project 2/NEIdata/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("~/Documents/Coursera/Exploratory Data Analysis/project 2/NEIdata/Source_Classification_Code.rds")
head(SCC)

## Extract the motor vehicle sources data ##
motorVehicle <- SCC[grepl("*Vehicle", SCC$EI.Sector, ignore.case = TRUE), ]
motorSCC <- motorVehicle$SCC
baltimore <- NEI[NEI$fips == "24510", ]
motordata <- baltimore[baltimore$SCC %in% motorSCC, ]
## Aggregate the total PM2.5 emissions from motor vehicle sources by year in Baltimore City ##
library(plyr)
aggmotordata <- ddply(motordata, "year", summarize, Emissions = sum(Emissions))
aggmotordata
## Plot5 ##
library(ggplot2)
g <- ggplot(aggmotordata, aes(year, Emissions))
p <- g + geom_point(size = 3) + geom_path() + labs(x = "Year") + labs(y = expression("Total PM"[2.5]*" Emissions (Tons)")) + labs(title = expression("Total PM"[2.5]*" emissions from motor vehicle sources changed by year in Baltimore City"))
print(p)
dev.copy(png, file = "plot5.png",width = 540, height = 540, units='px')
dev.off()