## Question 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? ##
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

## Aggregate the total PM2.5 emissions for the Baltimore City, Maryland by year and type ##
aggbaltimoreYT <- aggregate(Emissions ~ year + type, baltimore, sum)
aggbaltimoreYT
## Plot3 ##
library(ggplot2)
g <- ggplot(aggbaltimoreYT,aes(year, Emissions, color = type))
p <- g + geom_line() + labs(x = "Year") + labs(y = expression("Total PM"[2.5]*" Emissions (Tons)")) + labs(title = expression("Total PM"[2.5]*" emissions in the Baltimore City from 1999-2008 by source type"))
print(p)
dev.copy(png, file = "plot3.png",width = 540, height = 540, units='px')
dev.off()