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

# Plot the data
ggp <- ggplot(sub_balt,aes(factor(year),Emissions,fill=type)) 
+      geom_bar(stat="identity")
+      


