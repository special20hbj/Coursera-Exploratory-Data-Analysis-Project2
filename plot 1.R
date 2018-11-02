## Question 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? ##
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

## Aggregate the total PM2.5 emissions by year ##
aggTotals <- aggregate(Emissions ~ year, NEI, sum)
aggTotals
## Plot1 ##
barplot(height = (aggTotals$Emissions)/10^6, names.arg = aggTotals$year, xlab = "Year", ylab = expression("Total PM"[2.5]*" Emissions (10^6 Tons)"), main = expression("Total PM"[2.5]*" emissions in the US from all sources by year"))
dev.copy(png, file = "plot1.png",width = 480, height = 480, units='px')
dev.off()