## Question 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? ##
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

## Extract the coal combustion-related sources data ##
coalsources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = TRUE), ]
coalSCC <- coalsources$SCC
coaldata <- NEI[NEI$SCC %in% coalSCC, ]
## Aggregate the total PM2.5 emissions from coal combustion-related sources by year ##
library(plyr)
aggcoaldata <- ddply(coaldata, "year", summarize, Emissions = sum(Emissions))
aggcoaldata
## Plot4 ##
library(ggplot2)
g <- ggplot(aggcoaldata, aes(year, Emissions/10^5))
p <- g + geom_point(size = 3) + geom_path() + labs(x = "Year") + labs(y = expression("Total PM"[2.5]*" Emissions (10^5 Tons)")) + labs(title = expression("Total PM"[2.5]*" emissions from coal combustion-related sources changed by year"))
print(p)
dev.copy(png, file = "plot4.png",width = 540, height = 540, units='px')
dev.off()