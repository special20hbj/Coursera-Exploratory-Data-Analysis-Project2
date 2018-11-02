## Question 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions? ##
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

## Extract the motor vehicle sources data for Baltimore and LosAngeles ##
motorVehicle <- SCC[grepl("*Vehicle", SCC$EI.Sector, ignore.case = TRUE), ]
motorSCC <- motorVehicle$SCC
BaltLA <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
BaltLAmotordata <- BaltLA[BaltLA$SCC %in% motorSCC, ]
## Get subset of the aggregated total PM2.5 emissions from motor vehicle sources by year in Baltimore City and Los Angeles County ##
library(plyr)
aggBaltLA <- ddply(BaltLAmotordata, c("fips", "year"), summarise,Emissions = sum(Emissions))
aggBaltLA$city <- ifelse(aggBaltLA$fips == "24510", "Baltimore City, MD", "Los Angeles County, CA")
aggBaltLA
## Plot6 ##
library(ggplot2)
g <- ggplot(aggBaltLA, aes(year, Emissions))
p <- g + geom_point(size = 3, aes(color = city)) + geom_path(aes(color = city)) + theme(plot.title = element_text(size = 10)) + labs(x = "Year") + labs(y = expression("Total PM"[2.5]*" Emissions (Tons)")) + labs(title = expression("Baltimore City vs Los Angeles County  in Total PM"[2.5]*" emissions from motor vehicle sources changed by year")) 
print(p)
dev.copy(png, file = "plot6.png",width = 540, height = 540, units='px')
dev.off()