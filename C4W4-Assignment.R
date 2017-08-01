#### C4W4 - Assignment

### C4W4 - Exploratory data analysis IFG

# Plot1.R: Is the pm25 (pollution) decreasen from 1999 to 2008?

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
head(NEI)
head(SCC)

# Calculate the total pm2.5 and verify the results
total_pm25 <-  with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))
head(total_pm25)

# Plot the data with barplot
barplot(total_pm25, NEI$year,
        main = "Total PM2.5 Emissions Vs Year",
        xlab = "Year",
        ylab = "PM2.5 Emissions",
        col = "darkblue")

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

# Plot the data with plot
# type "o" point-line, pch 19 solid circle
# lty line type dash, lwd line width
plot(total_pm25, 
     main = "Total PM2.5 Emissions Vs Year",
     xlab = "Year",
     ylab = "PM2.5 Emissions",
     col = "red",
     type = "o",
     pch = 19,
     lty = 2,
     lwd = 2)

# Save to png file
dev.copy(png, "plot1_plot.png", width = 480, height = 480)
dev.off()

# Plot2.R: Have total emissions pm25 decreased in Baltimore
# city (Maryland) fips == "24510" from 1999-2008?

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
head(NEI)
head(SCC)

# Make subset of Baltimore city data
sub_balt <- subset(NEI, fips =="24510")
head(sub_balt)

# Calculate the total emissions vs year
total_balt <- tapply(sub_balt$Emissions,
                     sub_balt$year, sum)

# Plot with barplot
barplot(total_balt, NEI$year,
        main = "Total PM2.5 Baltimore city (MD) Vs Year",
        xlab = "Year",
        ylab = "PM2.5 Emissions",
        col = "darkblue")

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

### C4W4 - Exploratory data analysis IFG

# Plot3.R: type(point, nopint, onroad, nonroad)
# Wich of the sources decreases in emissions for
# Baltimore city? Wich increases?

# Use ggplot2 system
library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
head(NEI)
head(SCC)

# Make subset of Baltimore city data
sub_balt <- subset(NEI, fips =="24510")
head(sub_balt)

# Emission per year per type
type_balt <- aggregate(Emissions ~ year + type, 
                       sub_balt, 
                       sum)

# Plot the data
g <- ggplot(type_balt, aes(year, Emissions, color = type))
g + geom_line() +
    ggtitle("Total PM2.5 Baltimore (MD) Vs Year & Type") +
    xlab("Year") + 
    ylab("PM2.5 Emissions")

# Save to png file
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()

### C4W4 - Exploratory data analysis IFG

# Plot4.R: Emissions from coal combustion change
# between 1999 and 2012

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
View(NEI)
View(SCC)

# Take the coal combustion sources from SCC
# ignore.case = TRUE case is ignored during matching
coal  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
sub_SCC <- SCC[coal, ]

# Merge the data from SCC and NEI
mrg <- merge(NEI, sub_SCC, by = "SCC")

# Total emissions per year
total_pm25 <- tapply(mrg$Emissions, mrg$year, sum)

# Plot with barplot
barplot(total_pm25, mrg$year,
        main = "Total PM2.5 Emissions from Coal",
        xlab = "Year",
        ylab = "PM2.5 Emissions",
        col = "darkblue")

# Save the plot
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()

### C4W4 - Exploratory data analysis IFG

# Plot5.R: How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
View(NEI)
View(SCC)

# Take the vehicle sources from SCC
# ignore.case = TRUE case is ignored during matching
vehicle  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
sub_SCC <- SCC[vehicle, ]

# Make subset of Baltimore city data
sub_balt <- subset(NEI, fips =="24510" & type == "ON-ROAD")

# Total emissions per year
total_pm25 <- tapply(sub_balt$Emissions, sub_balt$year, sum)

# Plot with barplot
barplot(total_pm25, mrg$year,
        main = "Total PM2.5 vehicle emissions in Baltimore",
        xlab = "Year",
        ylab = "PM2.5 Emissions",
        col = "darkblue")

# Save the plot
dev.copy(png, "plot5.png", width = 480, height = 480)
dev.off()

### C4W4 - Exploratory data analysis IFG

# Plot6.R: Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the data
View(NEI)
View(SCC)

# Make subset of Baltimore and LA data
sub_balt <- subset(NEI, fips =="24510" & type == "ON-ROAD")
sub_la <- subset(NEI, fips == "06037" & type == "ON-ROAD")

# Add city column
sub_balt$city <- "Baltimore"
sub_la$city <- "Los Angeles"

balt <- aggregate(Emissions ~ year + type + city, sub_balt, sum)
la <- aggregate(Emissions ~ year + type + city, sub_la, sum)

# Merge the data
total_pm25 <- rbind(balt, la)

# Plot 
qplot(year, Emissions, data = total_pm25, color = city, geom = "line") +
ggtitle("Total PM2.5 vehicle emissions in Baltimore and LA") +
xlab = "Year" +
ylab = "PM2.5 Emissions"

dev.copy(png, "plot6.png", width = 480, height = 480)
dev.off()


